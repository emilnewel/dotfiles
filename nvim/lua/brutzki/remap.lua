local nnoremap = require('brutzki.keymap').nnoremap

-- Open terminal in neovim
nnoremap("<A-t>", "<cmd>:term<CR>i")

-- Telescope
nnoremap("<C-p>", "<cmd>Telescope find_files<CR>")
nnoremap("<leader>fa", "<cmd>Telescope live_grep<CR>")
nnoremap("<C-r>", "<cmd>Telescope oldfiles<CR>")

-- Select all
nnoremap('<C-a>', 'gg<S-v>G')

-- Pane management
nnoremap('ss', ':split<Return><C-w>w')
nnoremap('sv', ':vsplit<Return><C-w>w')

nnoremap('<leader><leader>', '<C-w>w')

nnoremap('<leader><left>', '<C-w>h')
nnoremap('<leader><right>', '<C-w>l')
nnoremap('<leader><down>', '<C-w>j')
nnoremap('<leader><up>', '<C-w>k')

nnoremap('<leader>h', '<C-w>h')
nnoremap('<leader>l', '<C-w>l')
nnoremap('<leader>j', '<C-w>j')
nnoremap('<leader>k', '<C-w>k')

-- Mason/LSP
nnoremap('<leader>mm', '<cmd>Mason<CR>')

nnoremap('<C-j>', '<cmd>Lspsaga diagnostic_jump_next<CR>')
nnoremap('K', '<cmd>Lspsaga hover_doc<CR>')
-- nnoremap('gd', '<cmd>Lspsaga lsp_finder<CR>')
nnoremap('<C-k>', '<cmd>Lspsaga signature_help<CR>')
nnoremap('gp', '<cmd>Lspsaga preview_definition<CR>')
nnoremap('gr', '<cmd>Lspsaga rename<CR>')
