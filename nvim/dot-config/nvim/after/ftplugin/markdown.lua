local function file_exists(file_path)
    local stat = vim.loop.fs_stat(file_path)
    return stat ~= nil
end

local function edit_file(link)
  if not file_exists(link) then
    Snacks.notify.info('File does not exist: ' .. link)
    return
  end
  vim.cmd('edit ' .. link)
end

local function extract_links(line)
    local matches = {}
    for match in string.gmatch(line, "(%[.-%]%(.-%))") do
        local _, _, text, link = match:find("%[(.-)%]%((.-)%)")
        table.insert(matches, {link = link, text = text})
    end
    return matches
end

local function select_link(matches)
  require'fzf-lua'.fzf_exec(
    function(fzf_cb)
      for i, v in ipairs(matches) do
        fzf_cb(i .. ' ' .. v.text)
      end
      fzf_cb() -- EOF
    end,
    {
      actions = {
        ['default'] = function(selected, _)
          local _, _, index = selected[1]:find("(%d+)")
          edit_file(matches[tonumber(index)].link)
        end,
      }
    })
end

vim.keymap.set('n', '<CR>', function()
  local line = vim.fn.getline('.')
  local matches = extract_links(line)
  if #matches == 0 then
    Snacks.notify.info('No markdown link(s) found on line')
  elseif #matches == 1 then
    edit_file(matches[1].link)
  elseif #matches > 1 then
    select_link(matches)
  end
end, { buffer = 0 })

