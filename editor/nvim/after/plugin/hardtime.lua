local name = "hardtime"
local ok, pckg = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

pckg.setup({
  disabled_filetypes = {"netrw", "mason", "harpoon", "packer", "dashboard"}
})
