-- Check if the plugin is available before configuring
local npairs_ok, npairs = pcall(require, "nvim-autopairs")
if not npairs_ok then
  packer_missing('autopairs')
  return
end

npairs.setup()
-- npairs.setup({
--   fast_wrap = {
--     map = '<C-a>',
--     chars = { '{', '[', '(', '"', "'" },
--     pattern = [=[[%'%"%>%]%)%}%,]]=],
--     end_key = '$',
--     before_key = 'b',
--     after_key = 'e',
--     cursor_pos_before = true,
--     keys = 'qwertyuiopzxcvbnmasdfghjkl',
--     manual_position = true,
--     highlight = 'Search',
--     highlight_grey = 'Comment',
--   },
-- })
