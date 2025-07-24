-- Check if the plugin is available before configuring
local ok, indent = pcall(require, "ibl")
if not ok then
  packer_missing('indent-blankline')
  return
end

indent.setup()
