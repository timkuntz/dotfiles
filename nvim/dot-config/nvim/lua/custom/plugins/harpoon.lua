return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    'nvim-lua/plenary.nvim',
    'https://github.com/lubyk/yaml'
  },
  dev = false,
  enabled = true,
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    save_on_toggle = true,
  },
  -- lua print('hello')
  config = function()
    local harpoon = require("harpoon")
    -- harpoon:setup()

    harpoon:setup({
      default = {
        select = function(list_item, list, options)
          if string.sub(list_item.value, 1, 2) == "* " then
            -- P(yaml.load('harpoon.yaml'))
            local list_name = string.sub(list_item.value, 3, -1)
            require'harpoon'.ui:close_menu()
            require'harpoon'.ui:toggle_quick_menu(require'harpoon':list(list_name))
          else
            -- stack overflow - how to call original function?
            require'harpoon.config'.get_default_config().default.select(list_item, list, options)
          end
        end,
        -- display = function(list_item)
        --   return list_item.display_value
        -- end,
        -- create_list_item = function(config, name)
        --   P("calling default create")
        --   return require'harpoon'.config.default.create_list_item(config, name)
        --   -- return {
        --   --   value = name,
        --   --   context = {
        --   --     row = 0,
        --   --     col = 0,
        --   --   },
        --   -- }
        -- end,
        -- foo = "bar",
        -- add = function(_, manual_entry)
        --   P(manual_entry)
        --   local default_item = harpoon:list().config.add(manual_entry)
        --   P(default_item)
        --   return {
        --     value = manual_entry or "foo",
        --     context = {
        --       bar = "baz"
        --     }
        --   }
        -- end
      }
    })

    -- harpoon:setup({
    --   -- Setting up custom behavior for a list named "cmd"
    --   opts = {
    --   cmd = {
    --
    --     -- When you call list:add() this function is called and the return
    --     -- value will be put in the list at the end.
    --     --
    --     -- which means same behavior for prepend except where in the list the
    --     -- return value is added
    --     --
    --     -- @param possible_value string only passed in when you alter the ui manual
    --     add = function(_)
    --       P("i am in add")
    --       -- get the current line idx
    --       local idx = vim.fn.line(".")
    --
    --       -- read the current line
    --       local xcmd = vim.api.nvim_buf_get_lines(0, idx - 1, idx, false)[1]
    --       if xcmd == nil then
    --         return nil
    --       end
    --
    --       return {
    --         value = xcmd,
    --         context = { "foo" },
    --       }
    --     end,
    --
    --     -- This function gets invoked with the options being passed in from
    --     -- list:select(index, <...options...>)
    --     -- @param list_item {value: any, context: any}
    --     -- @param list { ... }
    --     -- @param option any
    --     select = function(list_item, _, _)
    --       -- WOAH, IS THIS HTMX LEVEL XSS ATTACK??
    --       vim.cmd(list_item.value)
    --     end
    --   }
    --   }
    -- })

    harpoon:extend({
      UI_CREATE = function(cx)
        vim.keymap.set("n", "<C-v>", function()
          harpoon.ui:select_menu_item({ vsplit = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-x>", function()
          harpoon.ui:select_menu_item({ split = true })
        end, { buffer = cx.bufnr })

        vim.keymap.set("n", "<C-t>", function()
          harpoon.ui:select_menu_item({ tabedit = true })
        end, { buffer = cx.bufnr })
      end,
    })

    -- require("telescope").load_extension('harpoon')
  end,
  keys = function()
    local keys = {
      { "<C-j><C-j>", function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list()) end, desc = "Harpoon UI" },
      { "<C-k><C-k>", function() require'harpoon':list():add() end, desc = "Harpoon add file" },

      { "<C-u><C-u>", function() require'harpoon'.ui:toggle_quick_menu(require'harpoon':list('custom')) end, desc = "Harpoon UI" },
      { "<C-i><C-i>", function() require'harpoon':list('custom'):add() end, desc = "Harpoon add file" },

      { "<C-h><C-h>", function() require'harpoon':list():prev() end, desc = "Harpoon prev file" },
      { "<C-l><C-l>", function() require'harpoon':list():next() end, desc = "Harpoon next file" },
    }

    for i = 1, 5 do
      table.insert(keys, { "<leader>" .. i, function() require("harpoon"):list():select(i) end, desc = "Harpoon to File " .. i })
    end
    return keys
  end,
}

