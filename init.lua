local api = vim.api
local lsp = vim.lsp
local map = vim.keymap.set
local opt = vim.opt

opt.hlsearch = true
opt.ignorecase = true
opt.jumpoptions = "stack"
opt.mouse = ""
opt.textwidth = 80

-- indentation
opt.autoindent = true
opt.shiftwidth = 4
opt.tabstop = 4

-- (w)in (o)ptions
vim.wo.number = true

vim.cmd [[
	" options
	colorscheme tender
	set colorcolumn=+1
	set completeopt-=preview

	" show whitespace
	hi Whitespace guifg=grey37
	set list
	set listchars=tab:▸\ 

	" highlight whitespace at the end of a line
	hi EoLWhitespace guibg=grey
	match EoLWhitespace /\s\+$/

	" haven't used it yet, often annoying, just turn it off
	set noswapfile
	map q <nop>

	" diff view
	set diffopt=internal,filler,context:99999
	set fillchars+=diff:\ 
]]

-- make ctrl+left/right consistent with insert/visual mode
map("n", "<C-Left>", "b")
map("n", "<C-Right>", "w")
-- use "inclusive" motion in visual mode
map("v", "<c-left>", "<s-left>")
map("v", "<c-right>", "<s-right>")

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

-- window nav
map({"n", "v"}, "<c-tab>", ":wincmd w<cr>")
map("i", "<c-tab>", "<c-o>:wincmd w<cr>")
map({"n", "v"}, "<c-s-tab>", ":wincmd W<cr>")
map("i", "<c-s-tab>", "<c-o>:wincmd W<cr>")

-- press alt+left/right to go to prev/next tag match
map({"n", "v"}, "<A-Left>", ":cprev<CR>")
map("i", "<A-Left>", "<C-o>:cprev<CR>")
map({"n", "v"}, "<A-Right>", ":cnext<CR>")
map("i", "<A-Right>", "<C-o>:cnext<CR>")

-- for the love of god, delete, not cut
map({"n", "v"}, "<bs>", "\"_X")
map({"n", "v"}, "<del>", "\"_x")

-- rust
-- https://neovim.io/doc/user/ft_rust.html

vim.g.rust_recommended_style = false

-- lsp

-- Setup language servers
local lspconfig = require("lspconfig")
lspconfig.clangd.setup {}
--lspconfig.lua_ls.setup {}

local function make_toggler(handler)
	local win =-1
	return function(...)
		if win and api.nvim_win_is_valid(win) then
			api.nvim_win_close(win, false)
			win = -1
		else
			local fbuf, fwin = handler(...)
			win = fwin
			return fbuf, fwin
		end
	end
end

map({"i", "n", "v"}, "<f1>", make_toggler(vim.diagnostic.open_float))
map("i", "<c-space>", "<C-x><C-o>")
map("n", "<f26>", lsp.buf.rename)
map({"n", "i"}, "<f31>", lsp.buf.signature_help)
map({"n", "i"}, "<f32>", lsp.buf.hover)
map({"n", "i"}, "<f34>", lsp.buf.references)
map({"n", "i"}, "<f35>", lsp.buf.incoming_calls)
map({"n", "i"}, "<f36>", lsp.buf.declaration)

--override popover options
local popover_opts = {
	-- https://github.com/neovim/neovim/blob/master/src/nvim/auevents.lua
	close_events = { "CursorMoved", "InsertLeave", "WinScrolled" },
	focusable = false,
};
lsp.handlers["textDocument/hover"] =
	lsp.with(make_toggler(lsp.handlers.hover), popover_opts)
lsp.handlers["textDocument/signatureHelp"] =
	lsp.with(make_toggler(lsp.handlers.signature_help), popover_opts)

-- fugitive

map({"n", "v"}, "<f5>", ":Gvdiffsplit<cr>")
map({"n", "v"}, "<f6>", ":Git blame<cr>")

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

-- visual-multi

vim.cmd [[
	let g:VM_default_mappings = 0
	let g:VM_maps = {}
	let g:VM_maps["Select Cursor Down"] = '<A-Down>'
	let g:VM_maps["Select Cursor Up"] = '<A-Up>'
]]

