local config = {

  -- Configure AstroNvim updates
  updater = {
    remote = "origin", -- remote to use
    channel = "stable", -- "stable" or "nightly"
    version = "latest", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    branch = "main", -- branch name (NIGHTLY ONLY)
    commit = nil, -- commit hash (NIGHTLY ONLY)
    pin_plugins = nil, -- nil, true, false (nil will pin plugins on stable only)
    skip_prompts = false, -- skip prompts about breaking changes
    show_changelog = true, -- show the changelog after performing an update
  },

  -- Set colorscheme
  colorscheme = "default_theme",

  -- set vim options here (vim.<first_key>.<second_key> =  value)
  options = {
    opt = {
      relativenumber = false, -- sets vim.opt.relativenumber
      list = true, 
      listchars = "tab:-->,trail:·,extends:·,nbsp:·,space:·",
      tabstop = 4,
    },
    g = {
      mapleader = " ", -- sets vim.g.mapleader
    },
  },

  -- Default theme configuration
  default_theme = {
    diagnostics_style = { italic = true },
    -- Modify the color table
    colors = {
      fg = "#abb2bf",
    },
    plugins = { -- enable or disable extra plugin highlighting
      aerial = true,
      beacon = false,
      bufferline = true,
      dashboard = true,
      highlighturl = true,
      hop = false,
      indent_blankline = true,
      lightspeed = false,
      ["neo-tree"] = true,
      notify = true,
      ["nvim-tree"] = false,
      ["nvim-web-devicons"] = true,
      rainbow = true,
      symbols_outline = false,
      telescope = true,
      vimwiki = false,
      ["which-key"] = true,
    },
  },


  -- Configure plugins
  plugins = {
    -- Add plugins, the packer syntax without the "use"
    init = {
      -- You can disable default plugins as follows:
      -- ["goolord/alpha-nvim"] = { disable = true },

      -- You can also add new plugins here as well:
      -- { "andweeb/presence.nvim" },
      -- {
      --   "ray-x/lsp_signature.nvim",
      --   event = "BufRead",
      --   config = function()
      --     require("lsp_signature").setup()
      --   end,
      -- },
    },

    ["neo-tree"] = {
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
        }
      }
    },

    telescope = {
      defaults = {
        file_ignore_patterns = {
          "node_modules",
        },
      },
    },
  },

  mappings = {
    n = {
      ["<F3>"] = { "<CMD>nohl<CR>", desc = "Remove highlights" },
      ["<F5>"] = { 
        function() 
        if vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "modified") then
          vim.api.nvim_command('write')
        end

          astronvim.toggle_term_cmd({
            cmd = "make run",
            direction = "vertical",
            close_on_exit = false,
          }) 
        end, 
        desc = "ToggleTerm Run make" 
      },
    },
    i = {
      ["<C-s>"] = { "<esc><CMD>w!<CR>", desc = "Save file" }
    }
  },

  -- This function is run last
  -- good place to configuring augroups/autocommands and custom filetypes
  polish = function()

    -- Set key binding
    -- Set autocommands
    vim.api.nvim_create_augroup('Misc', {clear = true})
    vim.api.nvim_create_autocmd("BufWritePost", {
      group = "Misc",
      desc = "Format the current file",
      pattern = "*.go",
      callback = function()
        vim.api.nvim_command("cexpr system('gofmt -e -w ' . expand('%'))")
        vim.api.nvim_command("edit")
      end,
    })

    -- Set up custom filetypes
    -- vim.filetype.add {
    --   extension = {
    --     foo = "fooscript",
    --   },
    --   filename = {
    --     ["Foofile"] = "fooscript",
    --   },
    --   pattern = {
    --     ["~/%.config/foo/.*"] = "fooscript",
    --   },
    -- }
  end,
}

return config
