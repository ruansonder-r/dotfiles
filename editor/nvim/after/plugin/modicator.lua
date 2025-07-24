local name = "modicator"
local ok, pck = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

pck.setup({
  -- Warn if any required option is missing. May emit false positives if some
  -- other plugin modifies them, which in that case you can just ignore
  show_warnings = false,
  highlights = {
    -- Default options for bold/italic
    defaults = {
      bold = false,
      italic = false,
    },
    -- Use `CursorLine`'s background color for `CursorLineNr`'s background
    use_cursorline_background = false,
  },
  integration = {
    lualine = {
      enabled = false,
      -- Letter of lualine section to use (if `nil`, gets detected automatically)
      mode_section = nil,
      -- Whether to use lualine's mode highlight's foreground or background
      highlight = 'bg',
    },
  },
})

-- see feline for repitition of colours
local one_monokai = {
  fg = "#c6d0f5",      -- Text (Lavender)
  bg = "#1e1e2e",      -- Base (Dark blue-gray)
  green = "#a6e3a1",   -- Green (Soft mint)
  yellow = "#f9e2af",  -- Yellow (Pastel yellow)
  purple = "#cba6f7",  -- Mauve (Purple)
  orange = "#fab387",  -- Peach (Soft orange)
  peanut = "#f5c2e7",  -- Pink (Rosewater)
  red = "#f38ba8",     -- Red (Salmon pink)
  aqua = "#89b4fa",    -- Blue (Light blue)
  darkblue = "#1e1e2e", -- Same as background
  dark_red = "#b02e3a", -- Maroon (Stronger red)
}

-- Set highlight groups for different modes
vim.api.nvim_set_hl(0, 'NormalMode', { fg = one_monokai.green, bg = one_monokai.bg })       -- Normal mode
vim.api.nvim_set_hl(0, 'InsertMode', { fg = one_monokai.yellow, bg = one_monokai.bg })       -- Insert mode
vim.api.nvim_set_hl(0, 'VisualMode', { fg = one_monokai.purple, bg = one_monokai.bg })       -- Visual mode
vim.api.nvim_set_hl(0, 'CommandMode', { fg = one_monokai.aqua, bg = one_monokai.bg })        -- Command mode
vim.api.nvim_set_hl(0, 'ReplaceMode', { fg = one_monokai.red, bg = one_monokai.bg })         -- Replace mode
vim.api.nvim_set_hl(0, 'SelectMode', { fg = one_monokai.orange, bg = one_monokai.bg })       -- Select mode
vim.api.nvim_set_hl(0, 'TerminalMode', { fg = one_monokai.peanut, bg = one_monokai.bg })     -- Terminal mode
vim.api.nvim_set_hl(0, 'TerminalNormalMode', { fg = one_monokai.green, bg = one_monokai.bg }) -- Terminal Normal mode
