 

local mappings = {}

-- folder containing your individual map files
local dir = vim.fn.stdpath("config") .. "/lua/mattman/maps"

-- get all *.lua files
local files = vim.fn.globpath(dir, "*.lua", false, true)

for _, file in ipairs(files) do
  local name = vim.fn.fnamemodify(file, ":t:r")

  -- avoid loading this loader itself if it's inside the same folder
  if name ~= "init" and name ~= "maps" then
    local ok, module = pcall(require, "mattman.maps." .. name)
    if ok and type(module) == "table" then
      -- append returned maps directly
      for _, m in ipairs(module) do
        table.insert(mappings, m)
      end
    else
      print("Failed loading keymap file: " .. name)
    end
  end
end

-- dump EVERYTHING to which-key
local wk = require("which-key")
wk.add(mappings)




