vim.cmd("autocmd!")
local opt = vim.opt

-- Encoding
vim.scriptencoding = "utf-8"
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.clipboard = "unnamedplus" -- Sync with system clipboard

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
opt.termguicolors = true

-- Spelling
opt.spelllang = "en_us"
opt.spell = true

vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1 --  disable netrw
--
opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
opt.mouse = "a" -- allow the mouse to be used in neovim
opt.incsearch = true -- make search act like search in modern browsers
opt.number = true -- Show Line numbers
opt.termguicolors = true -- set term gui colors (most terminals support this)
opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
opt.undofile = true -- enable persistent undo
opt.updatetime = 100 -- faster completion (4000ms default)
opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
opt.expandtab = false -- convert tabs to spaces-
opt.relativenumber = true
opt.backupskip = { "/tmp/*", "/private/tmp/*" }
opt.smartindent = true -- make indenting smarter again
opt.inccommand = "split"
opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
opt.smarttab = true
opt.breakindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.wrap = false -- No Wrap lines
opt.backspace = { "start", "eol", "indent" }
opt.path:append({ "**" }) -- Finding files - Search down into subfolders
opt.wildignore:append({ "*/node_modules/*, */vendor/*" })
opt.signcolumn = "yes"
opt.listchars = { tab = "—-—", space = "·" }
opt.list = true

-- Add asterisks in block comments
opt.formatoptions:append({ "r" })

-- Highlights
opt.cursorline = true
opt.termguicolors = true
opt.winblend = 0
opt.wildoptions = "pum"
opt.pumblend = 5
opt.background = "dark"

-- highlight yanked text for 200ms using the "Visual" highlight group

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
