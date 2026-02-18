# Portable Neovim flake

This directory contains a standalone flake (`nvim/flake.nix`) that packages this Neovim config as a runnable app.

Goal: let anyone run your config with:

```bash
nix run ./nvim
```

(or from inside `nvim/fnl`, `nix run ..`).

## How it is implemented

## 1) Wrapper module: `nix-wrapper-modules`

The flake uses [`BirdeeHub/nix-wrapper-modules`](https://github.com/BirdeeHub/nix-wrapper-modules), specifically `wlib.wrapperModules.neovim`, to build a wrapped Neovim derivation.

In `wrappedNvim`:

- `binName = "nvim"`
- `settings.aliases = [ "vi" "vim" ]`
- `settings.config_directory = compiledConfig`

So the final package exposes `nvim` (and aliases) with this config baked in.

## 2) Build-time Fennel compilation (`compiledConfig`)

A separate derivation (`compiledConfig`) is created via `pkgs.runCommand "nvim-config-compiled"`.

It does:

1. Copies the whole `nvim/` tree into `$out`
2. Runs headless Neovim with `hotpot.nvim` on runtimepath:

```bash
nvim --headless --clean -u NONE \
  --cmd "set rtp+=${pkgs.vimPlugins.hotpot-nvim}" \
  "+lua require('hotpot').api.make.auto.build('$out', {verbose=true, force=true})" \
  +qa
```

3. Verifies expected compiled artifacts exist:
   - `$out/.compiled/lua/init.lua`
   - `$out/.compiled/lua/cfg/init.lua`

`HOME` and `XDG_CACHE_HOME` are set to writable temp dirs during this step so hotpot can run in Nix build sandbox.

## 3) Portable runtime `init.lua`

After compilation, `compiledConfig/init.lua` is overwritten to avoid requiring hotpot at runtime.

It becomes:

```lua
vim.opt.rtp:prepend("$out/.compiled")
vim.loader.enable()
dofile("$out/.compiled/lua/cfg/init.lua")
```

So runtime uses precompiled Lua directly from the store path.

> Source of truth note: edit `nvim/fnl/**` (and other source files), not `nvim/.compiled/**`.
> `.compiled` is generated output from the Fennel build.

## 4) Plugin packaging via Nix (no lazy.nvim package downloads)

The wrapper injects plugin sets through:

- `specs.nixpkgs = { lazy = true; pluginDeps = false; collateGrammars = false; data = with pkgs.vimPlugins; [ ... ]; }`
- `specs.custom = { lazy = true; pluginDeps = false; collateGrammars = false; data = builtins.attrValues customVimPlugins; }`
- `specs.lze = { data = pkgs.vimPlugins.lze; lazy = false; }`

So plugin code is provided by Nix store paths rather than runtime git clones, with plugins installed as opt/lazy packages by default.

Runtime behavior is handled by `lze` via `lua/cfg/fns.lua` (`setup_nix_plugins`), translating the existing lazy-style plugin specs into lze triggers (`event/cmd/ft/keys/on_require`).

PATH helpers and runtime tools are injected via `extraPackages` (e.g. `git`, `fd`, `ripgrep`, LSP binaries, and `sm-agent`).

### 4.1) Supermaven `sm-agent` patching

`supermaven-nvim` normally downloads `sm-agent` on first run into its local cache path.

This flake instead packages `sm-agent` in Nix (`supermaven-agent`) and exposes it in PATH. On startup, `fnl/plugins/supermaven.fnl`:

1. Resolves packaged `sm-agent` from PATH
2. Asks Supermaven where it expects the local binary (`binary_fetcher:local_binary_path()`)
3. Copies packaged `sm-agent` there if missing
4. Marks it executable

So Supermaven still works with its expected local layout, but without runtime network download.

This keeps your current lazy-based flow usable in the packaged runtime.

## 5) Flake outputs

The flake exports:

- `packages.<system>.nvim`
- `packages.<system>.smoke`
- `packages.<system>.live`
- `packages.<system>.default` (same as `nvim`)
- `apps.<system>.nvim`
- `apps.<system>.smoke`
- `apps.<system>.live`
- `apps.<system>.default`

`nix run` uses `apps.<system>.default` and launches `${pkg}/bin/nvim`.

## Supported systems

Configured for:

- `x86_64-linux`
- `aarch64-linux`
- `x86_64-darwin`
- `aarch64-darwin`

## Migration planning docs

- `nvim/LAZY_TRIGGERS.md` — archived lazy trigger intent per plugin
- `nvim/NIX_PLUGIN_MIGRATION.md` — nixpkgs availability audit (what is in nixpkgs vs what must be custom-fetched)

## Usage

From repo root:

```bash
nix run ./nvim
```

Build only:

```bash
nix build ./nvim#default
```

Inspect outputs:

```bash
nix flake show ./nvim
```

Lazy-load smoke test (headless):

```bash
nix run ./nvim#smoke
```

Live/dev mode (uses your working tree config with hotpot at runtime):

```bash
nix run ./nvim#live
```

`#live` defaults to `$PWD` as the config root. Override with:

```bash
NVIM_LIVE_CONFIG_ROOT=/path/to/this/repo/nvim nix run ./nvim#live
```

It does not write/symlink into your home config; it starts the wrapped Nix Neovim with a temporary init that loads your local repo (`hotpot` + `cfg`).

(Equivalent direct invocation if needed: `nix run ./nvim -- --headless "+luafile nvim/scripts/smoke-lazy.lua"`)
