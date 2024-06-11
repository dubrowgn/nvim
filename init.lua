local lsp = vim.lsp
local map = vim.keymap.set
local opt = vim.opt

opt.autoindent = true
opt.hlsearch = true
opt.ignorecase = true
opt.mouse = ""
opt.shiftwidth = 4
opt.tabstop = 4
opt.textwidth = 80

-- (w)in (o)ptions
vim.wo.number = true

vim.cmd [[
	" options
	colorscheme tender
	set colorcolumn=+0

	" show whitespace
	hi Whitespace guifg=grey37
	match Whitespace /\s\|\n/
	set list
	set listchars=tab:▸\ 

	" highlight whitespace at the end of a line
	highlight ExtraWhitespace guibg=grey37 guifg=black
	call matchadd('ExtraWhitespace', '\s\+$')

	" haven't used it yet, often annoying, just turn it off
	set noswapfile
	map q <nop>
]]

-- make ctrl+left/right consistent with insert/visual mode
map("n", "<C-Left>", "b")
map("n", "<C-Right>", "w")

-- nav
map({"n", "v"}, "<C-Up>", "9k")
map("i", "<C-Up>", "<C-o>9k")
map({"n", "v"}, "<C-Down>", "9j")
map("i", "<C-Down>", "<C-o>9j")

-- viewport nav
map({"n", "v"}, "<S-Down>", "3<C-E>")
map("i", "<S-Down>", "<C-o>3<C-E>")
map({"n", "v"}, "<S-Up>", "3<C-Y>")
map("i", "<S-Up>", "<C-o>3<C-Y>")
map({"n", "v"}, "<C-S-Down>", "9<C-E>")
map("i", "<C-S-Down>", "<C-o>9<C-E>")
map({"n", "v"}, "<C-S-Up>", "9<C-Y>")
map("i", "<C-S-Up>", "<C-o>9<C-Y>")

-- press alt+left/right to go to prev/next tag match
map({"n", "v"}, "<A-Left>", ":cprev<CR>")
map("i", "<A-Left>", "<C-o>:cprev<CR>")
map({"n", "v"}, "<A-Right>", ":cnext<CR>")
map("i", "<A-Right>", "<C-o>:cnext<CR>")

-- for the love of god, delete, not cut
map({"n", "v"}, "<bs>", "\"_X")
map({"n", "v"}, "<del>", "\"_x")

-- Setup language servers.
local lspconfig = require("lspconfig")
lspconfig.clangd.setup {}
--lspconfig.lua_ls.setup {}
lspconfig.rust_analyzer.setup {}

map("i", "<f3>", lsp.buf.completion) -- FIXME
map("n", "<f2>", lsp.buf.rename)
map({"n", "i"}, "<f7>", lsp.buf.signature_help)
map({"n", "i"}, "<f8>", lsp.buf.hover)
map({"n", "i"}, "<f10>", lsp.buf.references)
map({"n", "i"}, "<f11>", lsp.buf.incoming_calls)
map({"n", "i"}, "<f12>", lsp.buf.declaration)

-- telescope

local builtin = require("telescope.builtin")
map("n", "<c-l>", builtin.find_files)
map("n", "<c-s-f>", builtin.live_grep)

require("telescope").setup {
    defaults = {
	file_ignore_patterns = {
	    ".cache",
	    ".git",
	    ".svn",
	},
    },
}

