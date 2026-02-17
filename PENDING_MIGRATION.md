# Neovim migration status (lazy.nvim -> Nix + lze)

## Current status

- Plugin package management is Nix-based (`specs.nixpkgs` / `specs.custom` in `nvim/flake.nix`)
- Plugin packages are installed as lazy/opt by default; `lze` is loaded at startup
- Runtime lazy trigger handling is implemented with [`lze`](https://github.com/BirdeeHub/lze)
- Loader is in `nvim/lua/cfg/fns.lua` (`setup_nix_plugins`)
- Neodev uses a `.nvim` marker hack in `fnl/plugins/lsp.fnl` to force-enable plugin library hints for this repo

## Implemented parity

- Trigger support via lze:
  - `event` (including `VeryLazy` mapped to `DeferredUIEnter`)
  - `cmd`
  - `ft`
  - `keys`
  - `on_require` (module-trigger lazy loading)
- Dependency ordering bridge:
  - lazy.nvim `dependencies` translated to lze `dep_of`
- Config hooks:
  - lazy.nvim `init` -> lze `beforeAll`
  - lazy.nvim `config/opts` executed in lze `after`
- Treesitter migration stabilized to single plugin variant with compatibility shim for parser API differences

## Remaining follow-up (non-blocking)

1. Keep refining pack-name resolution heuristics in loader as edge-cases are found
2. Keep running/expanding `nvim/scripts/smoke-lazy.lua` as new plugins are added
3. Remove compatibility shims only after enough real-world runtime confidence
4. Optionally add an interactive smoke checklist doc for common daily workflows
