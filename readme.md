# Nvim Config

This is my [nvim](https://github.com/neovim) config. Feel free to use this as
is, as a reference, or as a starting point for your own config.

## Getting Started

Note: This project uses git submodules to reference external git repositories.
You will need some extra flags/commands to populate the relevant directories.

On Linux/MacOS

```bash
cd ~/.config
git clone --recurse-submodules "-j$(nproc)" \
    git@gitlab.com:oclc-top/data-services/metadata-applications/cbs/user/brownd/nvim.git
```

Or, if you already have it cloned:

```bash
cd ~/.config/nvim
git submodule update --init
```

## Getting nvim

Prebuilt linux releases are available at
https://github.com/neovim/neovim-releases/releases.

MacOS users can install nvim with homebrew via `brew install nvim`.

## Dependencies

The telescope plugin depends on [ripgrep](https://github.com/BurntSushi/ripgrep)
and [fd](https://github.com/sharkdp/fd), parallel implementations of `grep` and
`find` respectively. These are commonly found in linux package repos, homebrew
on MacOS, or you can find prebuilt releases directly from their respective
github pages.

## Configuration

nvim uses `init.lua` for configuration. If you are used to vim, `init.lua` is
the nvim equivalent to `.vimrc`. You can write arbitraty lua (instead of
vimscript), and there are "lua ways" to set configuration options (see the docs
link below). If you are coming from vim, there is a section where you can paste
vim configs, which can be helpful during migration.

* [nvim config docs](https://neovim.io/doc/user/options.html)

Some useful keyboard shortcuts I have configured:

* `ctrl + F1` -> toggle warning/error diagnostic popover
* `ctrl + F2` -> syntax aware symbol rename
* `ctrl + F7` -> toggle function call parameter help popover
* `ctrl + F8` -> toggle type info popover
* `ctrl + F10` -> find references
* `ctrl + F11` -> find callers
* `ctrl + F12` -> find declarations

See the plugins section for plugin specific key bindings.

## Plugins

Plugins are in `pack/plugins/start`.

### nvim-lspconfig

Provides some nice out of the box LSP client configurations.

### nvim-treesitter

Provides language/syntax aware syntax highlighting.

To see which languages are installed:

```vim
:TSInstallInfo
```

To install a language:

```vim
:TSInstall <language_to_install>
```

### plenary.nvim

Dependency for telescope.

### telescope.nvim

Flexible fuzzy finder used to search filenames (via `fd`) and file contents (via
`ripgrep`). Keyboard shortcuts I have configured:

* `ctrl + shift + l` -> search filename
* `ctrl + shift + f` -> grep file contents
* `ctrl + shift + s` -> lsp symbol search

### vim-fugitive

Provides git integration. Keyboard shortcuts I have configured:

* `ctrl + F5` -> git diff
* `ctrl + F6` -> git blame

### vim-visual-multi

Provides multi-cursor support. Use `alt + <arrow-key>` to add cursors, followed by
`i` to enter insert mode. `esc` twice to exit.

## Further reading

* https://ofirgall.github.io/learn-nvim (getting started though intermediate)
* https://github.com/AstroNvim/AstroNvim (plugin ideas)
* https://github.com/NvChad/NvChad (plugin ideas)
