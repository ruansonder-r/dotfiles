local name = "which-key"
local ok, pck = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

pck.setup {
  preset = "helix" -- Set preset to modern
}
