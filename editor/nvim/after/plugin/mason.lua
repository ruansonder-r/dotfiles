local name = "mason"
local ok, pck = pcall(require, name)
if not ok then
  packer_missing(name)
  return
end

pck.setup({})
