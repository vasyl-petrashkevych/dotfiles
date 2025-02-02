vim.cmd("autocmd!")
-- Encoding
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard

-- Spelling
vim.opt.spelllang = "en_us"
vim.opt.spell = true

vim.g.loaded_netrw = 1 -- disable netrw
vim.g.loaded_netrwPlugin = 1 --  disable netrw
--
vim.opt.completeopt = { "menuone", "noselect" } -- mostly just for cmp
vim.opt.mouse = "a" -- allow the mouse to be used in neovim
vim.opt.incsearch = true -- make search act like search in modern browsers
vim.wo.number = true -- Show Line numbers
vim.opt.termguicolors = true -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000 -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true -- enable persistent undo
vim.opt.updatetime = 100 -- faster completion (4000ms default)
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = false -- convert tabs to spaces-
vim.wo.relativenumber = true
vim.opt.backupskip = { "/tmp/*", "/private/tmp/*" }
vim.opt.smartindent = true -- make indenting smarter again
vim.opt.inccommand = "split"
vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.wrap = false -- No Wrap lines
vim.opt.backspace = { "start", "eol", "indent" }
vim.opt.path:append({ "**" }) -- Finding files - Search down into subfolders
vim.opt.wildignore:append({ "*/node_modules/*, */vendor/*" })
vim.opt.signcolumn = "yes"
vim.opt.listchars = { tab = "—-—", space = "·" }
vim.opt.list = true

-- Add asterisks in block comments
vim.opt.formatoptions:append({ "r" })

-- Highlights
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

-- highlight yanked text for 200ms using the "Visual" highlight group

-- Change the Diagnostic symbols in the sign column (gutter)
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end
