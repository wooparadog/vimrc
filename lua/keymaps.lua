-- Keymaps viewer utility
-- Shows keymaps with descriptions grouped by category

local M = {}

-- Parse category from description like "[Category] Description"
local function parse_category(desc)
  if not desc then return nil, desc end
  local cat, rest = desc:match("^%[([^%]]+)%]%s*(.*)$")
  return cat, rest or desc
end

-- Show keymaps grouped by category
-- show_all: if true, show all mappings; if false, only show those with desc
function M.show(show_all)
  local modes = {
    { name = "Normal", mode = "n" },
    { name = "Visual", mode = "v" },
    { name = "Insert", mode = "i" },
    { name = "Select", mode = "s" },
    { name = "Terminal", mode = "t" },
    { name = "Command-line", mode = "c" },
    { name = "Visual/Select", mode = "x" },
  }

  -- Collect all keymaps grouped by category
  local categories = {}
  local category_order = {}

  for _, m in ipairs(modes) do
    local maps = vim.api.nvim_get_keymap(m.mode)

    for _, map in ipairs(maps) do
      if show_all or (map.desc and map.desc ~= "") then
        local cat, desc = parse_category(map.desc)
        cat = cat or "Other"
        desc = desc or map.rhs or ""

        if not categories[cat] then
          categories[cat] = {}
          table.insert(category_order, cat)
        end

        table.insert(categories[cat], {
          mode = m.name:sub(1, 1),  -- First letter of mode name
          lhs = map.lhs or "",
          desc = desc,
        })
      end
    end
  end

  -- Sort category order (but keep "Other" at the end)
  table.sort(category_order, function(a, b)
    if a == "Other" then return false end
    if b == "Other" then return true end
    return a < b
  end)

  -- Build output lines
  local lines = {}
  local title = show_all and "# Keymaps (all)" or "# Keymaps"
  table.insert(lines, title)
  table.insert(lines, "")

  for _, cat in ipairs(category_order) do
    local items = categories[cat]

    -- Sort by lhs within category
    table.sort(items, function(a, b)
      if a.lhs == b.lhs then return a.mode < b.mode end
      return a.lhs < b.lhs
    end)

    -- Deduplicate (same lhs+desc in different modes)
    local seen = {}
    local unique_items = {}
    for _, item in ipairs(items) do
      local key = item.lhs .. "|" .. item.desc
      if seen[key] then
        -- Append mode to existing entry
        seen[key].mode = seen[key].mode .. "/" .. item.mode
      else
        seen[key] = item
        table.insert(unique_items, item)
      end
    end

    table.insert(lines, "## " .. cat)
    table.insert(lines, string.rep("-", 40))

    for _, item in ipairs(unique_items) do
      table.insert(lines, string.format("  %-4s %-16s %s", item.mode, item.lhs, item.desc))
    end
    table.insert(lines, "")
  end

  vim.cmd("new")
  vim.bo.buftype = "nofile"
  vim.bo.bufhidden = "wipe"
  vim.bo.swapfile = false
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.modifiable = false
  vim.cmd("normal! gg")
end

-- Create the :Keymaps command
vim.api.nvim_create_user_command("Keymaps", function(opts)
  M.show(opts.bang)
end, { bang = true, desc = "Show keymaps (! for all, default: with description only)" })

return M
