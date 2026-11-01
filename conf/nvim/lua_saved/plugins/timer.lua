return {
  {
    "nvzone/timerly",
    dependencies = {
      "nvzone/volt",
    },
    keys = {
      {
        "<leader>m",
        ":TimerlyToggle<cr>",
        desc = "Start a timer",
      },
    },
  },
  -- another timer
  {
    "ravsii/timers.nvim",
    version = "*", -- use latest stable release
    -- See below, empty is fine
    opts = {
      -- Save timers across reloads / sessions.
      persistent = true,
    },
    keys = {
      { "<leader>T", "", desc = "+timers" },
      {
        "<leader>Ta",
        function()
          require("timers.ui").active_timers()
        end,
        desc = "Active timers",
      },
      {
        "<leader>Td",
        function()
          require("timers.ui").dashboard()
        end,
        desc = "Dashboard",
      },
      {
        "<leader>Tn",
        function()
          require("timers.ui").create_timer()
        end,
        desc = "New timer",
      },
      {
        "<leader>Tc",
        function()
          require("timers.ui").cancel()
        end,
        desc = "Cancel a timer",
      },
      {
        "<leader>TC",
        function()
          require("timers.ui").cancel_all()
        end,
        desc = "Cancel all timers",
      },
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        -- other secions
        lualine_z = {
          {
            function()
              return require("timers.integrations.lualine").closest_timer()
            end,
          },
          -- date is not really needed when already in tmux
          -- {
          --   function()
          --     return " " .. os.date("%R")
          --   end,
          -- },
        },
      },
    },
  },
}
