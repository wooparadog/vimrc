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

    -- Column widths based on display width for proper alignment
    local mode_w = 1
    local lhs_w = 1
    for _, item in ipairs(unique_items) do
      mode_w = math.max(mode_w, vim.fn.strdisplaywidth(item.mode))
      lhs_w = math.max(lhs_w, vim.fn.strdisplaywidth(item.lhs))
    end

    local function pad_right(str, width)
      return str .. string.rep(" ", math.max(0, width - vim.fn.strdisplaywidth(str)))
    end

    table.insert(lines, "## " .. cat)
    table.insert(lines, string.rep("-", 40))

    for _, item in ipairs(unique_items) do
      local mode_cell = pad_right(item.mode, mode_w)
      local lhs_cell = pad_right(item.lhs, lhs_w)
      table.insert(lines, "  " .. mode_cell .. " " .. lhs_cell .. " " .. item.desc)
    end
    table.insert(lines, "")
  end

  -- Create a floating window in the current buffer
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "buftype", "nofile")
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  vim.api.nvim_buf_set_option(buf, "swapfile", false)
  vim.api.nvim_buf_set_option(buf, "modifiable", false)

  local max_w = 0
  for _, line in ipairs(lines) do
    max_w = math.max(max_w, vim.fn.strdisplaywidth(line))
  end
  local max_h = #lines

  local margin = 2
  local width = math.min(max_w + margin, math.max(40, vim.o.columns - 4))
  local height = math.min(max_h, math.max(10, vim.o.lines - 4))
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    row = row,
    col = col,
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  })

  vim.api.nvim_buf_set_keymap(buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_win_set_option(win, "cursorline", true)
  vim.api.nvim_win_set_option(win, "wrap", false)
  vim.api.nvim_win_set_cursor(win, { 1, 0 })
end

-- Create the :Keymaps command
vim.api.nvim_create_user_command("Keymaps", function(opts)
  M.show(opts.bang)
end, { bang = true, desc = "Show keymaps (! for all, default: with description only)" })

return M
