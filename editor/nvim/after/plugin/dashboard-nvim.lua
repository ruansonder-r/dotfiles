vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    local status, dashboard = pcall(require, 'dashboard')
    if not status then
      packer_missing('Dashboard')
      return
    end

    dashboard.setup {
      -- config
      theme = 'hyper',
      config = {
        project = {
          limit = 8,                         -- Number of recent projects to display
          enable = true,                     -- Whether to enable the project list
          icon = '󰏓 ',                     -- Icon displayed before 'Recent Projects'
          icon_hl = 'DashboardRecentProjectIcon', -- Highlight group for the icon
          action = 'Telescope find_files cwd=', -- Action to open project files
          label = 'Favourites',       -- Label for the section
          paths = {
            '~/projects/brAIn',
          }
        },
        header = {
          '' -- custom tile goes here
        },
        week_header = {
          enable = true,
        },
        shortcut = {
          -- { desc = '󰊳 Update', group = '@property', action = 'Lazy update', key = 'u' },
          {
            desc = '󰊳 Update Plugins',
            group = 'DiagnosticHint',
            action = 'PackerSync',
            key = 'u',
          },
          {
            desc = 'Packer Status',
            group = 'DiagnosticHint',
            action = 'PackerStatus',
            key = 's'
          },
          {
            desc = ' check health',
            group = 'Number',
            action = 'checkhealth',
            key = 'd',
          },
        },
        footer = {
        }
      },
    }
  end
})

-- Custom mapping to open dashboard with <leader>q
vim.api.nvim_set_keymap('n', '<leader>q', ':Dashboard<CR>', { noremap = true, silent = true })

-- Show a tip notification in the dashboard
vim.cmd("FetchTip")
