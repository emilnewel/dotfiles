vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.tabstop=2
vim.opt.softtabstop=2
vim.opt.shiftwidth=2
vim.opt.expandtab=true
vim.opt.hlsearch=false
vim.opt.incsearch=true

vim.opt.smartindent=true

vim.opt.wrap=false

vim.g.mapleader = " "
vim.o.shell="pwsh.exe"

vim.opt.ignorecase = true
vim.opt.path:append { '**' }
vim.opt.wildignore:append { '*/node_modules/*' } 
