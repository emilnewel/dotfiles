local is_status_ok, alpha = pcall(require, "alpha")

if not is_status_ok then
  print("alpha plugin not found")
  return
end

local dashboard = require("alpha.themes.dashboard")

dashboard.section.buttons.val = {
  dashboard.button("e", "New file", "<cmd>enew<CR>"),
  dashboard.button("<C-p>", "  Find file", "<cmd>Telescope find_files hidden=true no_ignore=true<CR>"),
  dashboard.button("<C-r>", "  Recently opened files", "<cmd>Telescope oldfiles<cr>"),
  dashboard.button("<leader> fa", "  Find word",  "<cmd>Telescope live_grep<cr>"),
}

alpha.setup(dashboard.config)
