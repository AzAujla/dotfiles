return {
  "nvimdev/dashboard-nvim",
  lazy = false,
  opts = function()
    local logo = [[

                                                                 
Y8b Y8b Y888P         888                                        
 Y8b Y8b Y8P   ,e e,  888  e88'888  e88 88e  888 888 8e   ,e e,  
  Y8b Y8b Y   d88 88b 888 d888  '8 d888 888b 888 888 88b d88 88b 
   Y8b Y8b    888   , 888 Y888   , Y888 888P 888 888 888 888   , 
    Y8P Y      "YeeP" 888  "88,e8'  "88 88"  888 888 888  "YeeP" 
                                                                 
            e Y8b                                                
           d8b Y8b    8P d8P  ,e e,   ,e e,  888 888 8e          
          d888b Y8b   P d8P  d88 88b d88 88b 888 888 88b         
         d888888888b   d8P d 888   , 888   , 888 888 888         
        d8888888b Y8b d8P d8  "YeeP"  "YeeP" 888 888 888         
                                                                 
  ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"

    local opts = {
      theme = "doom",
      hide = {
        -- this is taken care of by lualine
        -- enabling this messes up the actual laststatus setting after loading a file
        statusline = false,
      },
      config = {
        header = vim.split(logo, "\n"),
      -- stylua: ignore
      center = {
        { action = 'lua LazyVim.pick()()',                           desc = " Find File",       icon = " ", key = "f" },
        { action = "ene | startinsert",                              desc = " New File",        icon = " ", key = "n" },
        { action = 'lua LazyVim.pick("oldfiles")()',                 desc = " Recent Files",    icon = " ", key = "r" },
        { action = 'lua LazyVim.pick("live_grep")()',                desc = " Find Text",       icon = " ", key = "g" },
        { action = 'lua LazyVim.pick.config_files()()',              desc = " Config",          icon = " ", key = "c" },
        { action = 'lua require("persistence").load()',              desc = " Restore Session", icon = " ", key = "s" },
        { action = "LazyExtras",                                     desc = " Lazy Extras",     icon = " ", key = "x" },
        { action = "Lazy",                                           desc = " Lazy",            icon = "󰒲 ", key = "l" },
        { action = function() vim.api.nvim_input("<cmd>qa<cr>") end, desc = " Quit",            icon = " ", key = "q" },
      },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- open dashboard after closing lazy
    if vim.o.filetype == "lazy" then
      vim.api.nvim_create_autocmd("WinClosed", {
        pattern = tostring(vim.api.nvim_get_current_win()),
        once = true,
        callback = function()
          vim.schedule(function()
            vim.api.nvim_exec_autocmds("UIEnter", { group = "dashboard" })
          end)
        end,
      })
    end

    return opts
  end,
}

-- Old ASCIIs
--    $$$$$$\                             $$\
--   $$  __$$\                            \__|
--   $$ /  $$ |$$$$$$$$\       $$\    $$\ $$\ $$$$$$\$$$$\
--   $$$$$$$$ |\____$$  |      \$$\  $$  |$$ |$$  _$$  _$$\
--   $$  __$$ |  $$$$ _/        \$$\$$  / $$ |$$ / $$ / $$ |
--   $$ |  $$ | $$  _/           \$$$  /  $$ |$$ | $$ | $$ |
--   $$ |  $$ |$$$$$$$$\          \$  /   $$ |$$ | $$ | $$ |
--   \__|  \__|\________|          \_/    \__|\__| \__| \__|
