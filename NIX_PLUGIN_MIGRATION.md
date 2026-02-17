# Nix plugin migration audit (lazy.nvim -> nixpkgs)

This is a snapshot audit of active plugin references from:

- `nvim/fnl/plugins/*.fnl`
- excluding `graveyard/` and `*.todo`

Compared against `pkgs.vimPlugins` on `nixos-unstable`.

## Summary

- Total plugin repos referenced: **100**
- Available from `pkgs.vimPlugins`: **88**
- Missing from `pkgs.vimPlugins`: **12**

## Missing (need `fetchFromGitHub` / local path / drop)

These are not currently in `pkgs.vimPlugins` and will require custom packaging:

1. `0xferrous/ansi.nvim`
2. `0xferrous/eth.nvim`
3. `iden3/vim-circom-syntax`
4. `JellyApple102/flote.nvim`
5. `neo451/feed.nvim`
6. `nvimdev/nightsky.vim`
7. `ravitemer/mcphub.nvim`
8. `rmagatti/logger.nvim`
9. `ryanmsnyder/toggleterm-manager.nvim`
10. `stevearc/stickybuf.nvim`
11. `Tyler-Barham/floating-help.nvim`
12. `vhyrro/luarocks.nvim`

---

## Available but attr name differs (important)

Use these `pkgs.vimPlugins.*` attrs:

- `numToStr/Comment.nvim` -> `comment-nvim`
- `lewis6991/gitsigns.nvim` -> `gitsigns-nvim`
- `j-hui/fidget.nvim` -> `fidget-nvim`
- `nvim-tree/nvim-web-devicons` -> `nvim-web-devicons`
- `echasnovski/mini.icons` -> `mini-icons`
- `echasnovski/mini.diff` -> `mini-diff`
- `saghen/blink.cmp` -> `blink-cmp`
- `saghen/blink.compat` -> `blink-compat`
- `stevearc/oil.nvim` -> `oil-nvim`
- `nvim-neorg/neorg` -> `neorg`
- `nvim-neotest/neotest` -> `neotest`
- `nvim-neotest/nvim-nio` -> `nvim-nio`
- `nvim-orgmode/orgmode` -> `orgmode` (or `orgmode-nvim`)
- `llllvvuu/neotest-foundry` -> `neotest-foundry`
- `0xferrous/telescope-project.nvim` -> `telescope-project-nvim`
- `akinsho/nvim-toggleterm.lua` -> `nvim-toggleterm-lua`
- `mrcjkb/rustaceanvim` -> `rustaceanvim`

## Available with direct repo match

Most remaining plugins are available with obvious attrs (examples):

- `neovim/nvim-lspconfig` -> `nvim-lspconfig`
- `nvim-treesitter/nvim-treesitter` -> `nvim-treesitter`
- `nvim-telescope/telescope.nvim` -> `telescope-nvim`
- `folke/which-key.nvim` -> `which-key-nvim`
- `folke/snacks.nvim` -> `snacks-nvim`
- `stevearc/conform.nvim` -> `conform-nvim`
- `stevearc/overseer.nvim` -> `overseer-nvim`
- `ThePrimeagen/harpoon` -> `harpoon` / `harpoon2`
- `rktjmp/hotpot.nvim` -> `hotpot-nvim`
- `saecki/crates.nvim` -> `crates-nvim`

---

## Current implementation status

Implemented:

- plugin package management moved to Nix
- plugin sets are installed as lazy/opt packages (`specs.nixpkgs` / `specs.custom` with `lazy = true`)
- runtime lazy trigger handling is driven by `lze`
- custom loader bridge is in `require('cfg.fns').setup_nix_plugins()`
- previously problematic modules/plugins were re-enabled after treesitter/runtime fixes

## Migration plan (recommended)

1. **Freeze trigger intent**
   - Keep `nvim/LAZY_TRIGGERS.md` as trigger archive.

2. **Create Nix plugin set**
   - Add all 87 available plugins from `pkgs.vimPlugins`.
   - Add the 13 missing via `pkgs.vimUtils.buildVimPlugin` + `fetchFromGitHub`.

3. **Remove lazy bootstrap from runtime**
   - Delete runtime `lazy.setup(...)` path from config entrypoint.
   - Keep runtime plugin loading deterministic via Nix-provided RTP.

4. **Encode trigger behavior without lazy.nvim**
   - Recreate triggers in plain autocmd/keymap/cmd registration where needed.
   - Keep this behavior in Lua/Fennel modules (not network downloader).

5. **Validate parity**
   - `nix run ./nvim`
   - compare startup, keymaps, commands, major workflows.

---

## Re-audit command

Use this when nixpkgs updates:

```bash
# Recompute available vs missing against current nixpkgs
python scripts-or-ad-hoc-audit.py
```

(If you want, I can add a checked-in script at `nvim/scripts/audit-plugins.py` to make this reproducible.)
