M = {}

-- generic function to find a ancestor nodes in the AST
M.find_node_ancestors = function(types, node, known_ancestors)
  local ancestors = known_ancestors or {}
  if not node then
    return ancestors
  end
  if vim.tbl_contains(types, node:type()) then
    table.insert(ancestors, node)
  end
  local parent = node:parent()
  return M.find_node_ancestors(types, parent, ancestors)
end

-- generic function to find the first ancestor node in the AST
M.find_node_ancestor = function(types, node)
  local ancestors = M.find_node_ancestors(types, node)
  if #ancestors > 0 then
    return ancestors[1]
  end
  return nil
end

-- generic function to find first child of type
M.get_first_child_of_type = function(nodes, child_type)
  local children = {}
  for _, node in ipairs(nodes) do
    for child in node:iter_children() do
      if child:type() == child_type then
        table.insert(children, child)
        break
      end
    end
  end
  return children
end

-- generic function to reverse the order of a table
M.reverse = function(tbl)
  local reversed = {}
  for i = #tbl, 1, -1 do
    table.insert(reversed, tbl[i])
  end
  return reversed
end

-- ruby specific method for getting the full module name of the current node
M.get_qualified_name = function()
  local current_node = vim.treesitter.get_node()
  local node_ancestors = M.find_node_ancestors({ 'class', 'module' }, current_node)
  if not node_ancestors then
    vim.notify('no class / module found')
    return nil
  end
  local constants = M.get_first_child_of_type(node_ancestors, 'constant')
  local names = {}
  for _, constant in ipairs(constants) do
    table.insert(names, vim.treesitter.get_node_text(constant, 0))
  end
  return table.concat(M.reverse(names), '::')
end

return M
