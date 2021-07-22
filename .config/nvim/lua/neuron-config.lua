local nf = require'plenary.scandir'.scan_dir(
  '.',
  {
    search_pattern = "neuron.dhall",
    hidden = false,
    depth = 1,
    silent = true,
  }
)

local nd = "~/.zettelkasten"

if not(nf[1] == nil) then
  nd = (nf[1]):gsub("/neuron.dhall", "")
end

require'neuron'.setup {
  virtual_titles = false,
  mappings = true,
  run = nil,
  neuron_dir = nd,
  leader = "gz",
}
