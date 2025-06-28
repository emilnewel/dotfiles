-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd("BufWinEnter", { -- Changed from BufNewFile
  group = csFileGroup,
  pattern = "*.cs", -- Only trigger for .cs files
  callback = function(args)
    -- Check if the buffer is empty and modifiable
    -- args.buf is the buffer number for the event
    if
      vim.bo[args.buf].modifiable
      and vim.api.nvim_buf_line_count(args.buf) == 1
      and vim.api.nvim_buf_get_lines(args.buf, 0, 1, false)[1] == ""
    then
      -- Buffer is empty, proceed with template insertion

      -- Get the full path of the buffer
      local filePath = vim.api.nvim_buf_get_name(args.buf)
      if filePath == "" then
        return -- Exit if path is empty
      end

      -- Get the filename without extension
      local className = vim.fn.fnamemodify(filePath, ":t:r")
      if className == "" then
        className = "MyClass" -- Fallback
      end

      -- Get the directory containing the file
      local fileDir = vim.fn.fnamemodify(filePath, ":h")

      -- Find the nearest .csproj file
      local csprojFiles = vim.fs.find("*.csproj", {
        upward = true,
        stop = vim.env.HOME,
        path = fileDir,
        type = "file",
        limit = 1,
      })

      local namespaceName = "DefaultNamespace" -- Fallback

      if #csprojFiles > 0 then
        local csprojPath = csprojFiles[1]
        local projectRootDir = vim.fn.fnamemodify(csprojPath, ":h")
        local projectName = vim.fn.fnamemodify(csprojPath, ":t:r")

        -- Calculate relative path (handle potential trailing slash)
        local relativePath = vim.fs.normalize(fileDir):sub(#vim.fs.normalize(projectRootDir) + 2)

        if relativePath ~= "" then
          local namespaceParts = vim.split(relativePath, "[\\/]")
          namespaceName = projectName .. "." .. table.concat(namespaceParts, ".")
        else
          namespaceName = projectName
        end
      end

      -- Define the code template
      local template = {
        "namespace " .. namespaceName .. ";",
        "",
        "public class " .. className,
        "{",
        "    ", -- Cursor position
        "}",
        "",
      }

      -- Insert the template into the buffer
      vim.api.nvim_buf_set_lines(args.buf, 0, 0, false, template)

      -- Move cursor inside the class definition
      vim.api.nvim_win_set_cursor(0, { 5, 4 }) -- (Assuming the window is the current one)
    end
  end,
})

print("CSharp file template autocommand loaded (using BufWinEnter).")
