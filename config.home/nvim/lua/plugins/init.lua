return {
  'tpope/vim-fugitive',
  'scrooloose/nerdtree',
  'xuyuanp/nerdtree-git-plugin',
  {
    'neoclide/coc.nvim',
    branch = 'release',
    setup = function()
      vim.cmd('CocDisable')
    end
  },
  { 'nvim-treesitter/nvim-treesitter', branch = 'main', lazy = false, build = ':TSUpdate' },

  'int3/vim-extradite',
  {
    'rbong/vim-flog',
    lazy = true,
    cmd = { 'Flog', 'Flogsplit', 'Floggit' },
    dependencies = { 'tpope/vim-fugitive' }
  },
  'airblade/vim-gitgutter',
  'chrisbra/vim-diff-enhanced',
  'fei6409/log-highlight.nvim',
  'comatory/gh-co.nvim',

  'tpope/vim-rhubarb',
  'tpope/vim-repeat',
  'tpope/vim-surround',
  'tpope/vim-unimpaired',
  'tpope/vim-eunuch',

  'tomtom/tcomment_vim',
  'embear/vim-localvimrc',
  'lambdalisue/suda.vim',

  'dense-analysis/ale',
  'gcorne/vim-sass-lint',

  'mhinz/vim-startify',

  'bling/vim-airline',
  'vim-airline/vim-airline-themes',
  'rakr/vim-one',
  'YorickPeterse/happy_hacking.vim',
  'jansenfuller/crayon',
  'vim-scripts/wombat256.vim',
  'dikiaap/minimalist',
  'w0ng/vim-hybrid',
  'morhetz/gruvbox',
  'sainnhe/everforest',
  'Skullamortis/forest.nvim',

  'chiel92/vim-autoformat',
  'terryma/vim-multiple-cursors',
  'nvim-lua/plenary.nvim',
  {
    'nvim-telescope/telescope.nvim', tag = 'v0.2.2',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { "nvim-telescope/telescope-ui-select.nvim" },
    },
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
        },
      })
      require("telescope").load_extension("ui-select")
    end,
  },
  {
		'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {},
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },

  { 'alexghergh/nvim-tmux-navigation', config = function()
      require'nvim-tmux-navigation'.setup {
          disable_when_zoomed = true, -- defaults to false
          keybindings = {
              left = "<C-h>",
              down = "<C-j>",
              up = "<C-k>",
              right = "<C-l>",
          }
      }
  end
  },
  'christoomey/vim-tmux-navigator',
  'mileszs/ack.vim',
  'brooth/far.vim',
  'chrisbra/csv.vim',
  'vim-test/vim-test',

  -- TypeScript
  'herringtondarkholme/yats.vim',

  { 'ntpeters/vim-better-whitespace', init = function()
    vim.g.better_whitespace_operator = 'cs'
  end
  },
  { 'jiangmiao/auto-pairs', config = function()
    -- auto-pairs can't wrap mdnotes' Lua <CR> mapping; init pairs without the <CR> wrapper in markdown
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function() vim.fn.AutoPairsInit() end,
    })
  end
  },
  'stephenway/postcss.vim',

  --docs
  {
    'emmanueltouzery/apidocs.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter', 'nvim-telescope/telescope.nvim'
    },
    cmd = { 'ApidocsSearch', 'ApidocsInstall', 'ApidocsOpen', 'ApidocsSelect', 'ApidocsUninstall' },
    config = function()
      require('apidocs').setup{}
    end,
    keys = {
      {
        "<leader>ta",
        "<CMD>ApidocsSearch<CR>",
        desc = "Search API Documentation",
      },
    },

  },


  -- debugging
  'mfussenegger/nvim-dap',

  -- snippets
  'SirVer/ultisnips',

  -- ReactJS
   'pangloss/vim-javascript',
   'mxw/vim-jsx',

  -- Python
  'puremourning/vimspector',
  'alfredodeza/pytest.vim',

  -- Ruby
  'vim-ruby/vim-ruby',

  -- markdown
  {
    "ymic9963/mdnotes.nvim",
    opts = {
      auto_list_renumber = false,
    },
  },
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      -- You can choose one of the following pickers
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'echasnovski/mini.pick',
    },
  },

  -- yaml
  'pedrohdz/vim-yaml-folds',

  -- diff
  'lambdalisue/vim-unified-diff',

  -- code-reviews
  'AndrewRadev/diffurcate.vim',
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = "telescope",
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>gb",
        "<CMD>Octo pr browser<CR>",
        desc = "Open PR in browser",
      },
      {
        "<leader>gd",
        "<CMD>Octo discussion list<CR>",
        desc = "List GitHub Discussions",
      },
      {
        "<leader>gi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>gr",
        "<CMD>Octo search review-requested:@me is:pr is:open review:required<CR>",
        desc = "List PR Waiting My Review",
      },
      {
        "<leader>gR",
        "<CMD>Octo search is:pr is:open -review:approved reviewed-by:@me<CR>",
        desc = "List open PR reviewed by @me",
      },
      {
        "<leader>gm",
        "<CMD>Octo search author:@me is:pr is:open<CR>",
        desc = "List open PRs authored by @me",
      },
      {
        "<leader>gn",
        "<CMD>Octo notification list<CR>",
        desc = "List GitHub Notifications",
      },
      {
        "<leader>gp",
        "<CMD>Octo pr list<CR>",
        desc = "List GitHub PullRequests",
      },
      {
        "<leader>gs",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "Search GitHub",
      },
      {
        "<localleader>n",
        ":call feedkeys('<localleader><space>]u', 'x')<CR>",
        desc = "toggle viewed and move next",
      }
    },
    config = function()
      require("octo").setup({
        pull_requests = {
          order_by = {
            field = "UPDATED_AT",
            direction = "DESC",
          },
        },
        mappings = {
          pull_request = {
            approve_pr = { lhs = "<localleader>qa", desc = "Approve PR" },
            copy_sha = { lhs = "<localleader>ys", desc = "copy commit SHA to system clipboard" },
          },
          submit_win = {
            approve_review = { lhs = "<localleader>a", desc = "approve review", mode = "n" },
          },
          review_diff = {
            copy_sha = { lhs = "<localleader>ys", desc = "copy commit SHA to system clipboard" },
          },
        },
      })
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },

  -- testing code review plugins
  { "gh-tui-tools/gh-review.nvim" }, -- still not sure if I like this one, seems to early to tell
  {
    "0xKitsune/pr.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = function()
      require("pr").setup()
    end,
  },

  {
    "ldelossa/gh.nvim",
    dependencies = {
      {
      "ldelossa/litee.nvim",
      config = function()
        require("litee.lib").setup()
      end,
      },
    },
    config = function()
      require("litee.gh").setup()
    end,
  },

  -- AI assist
  { 'github/copilot.vim',
    init = function()
      vim.keymap.set('i', '<C-M>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        script = true,
        replace_keycodes = false
      })
      vim.keymap.set('i', '<C-f>', '<Plug>(copilot-accept-word)')
      vim.keymap.set('i', '<C-Q>', '<Plug>(copilot-dismiss)')
      vim.g.copilot_no_tab_map = true
    end
  },
  { 'CopilotC-Nvim/CopilotChat.nvim',
    opts = {
      model = 'claude-opus-4-8',
      mappings = {
        reset = {
          normal = '<C-r>',
          insert = '<C-r>',
        },
      },
      trusted_tools = { 'file', 'glob', 'grep' },
    },
    init = function()
      vim.keymap.set('n', '<leader>cc', '<CMD>CopilotChat<CR>', { desc = "Open Copilot Chat" })
    end,
  },

  -- lsp
  { 'neovim/nvim-lspconfig', },

  -- lua support with lsp and completion
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  -- optional cmp completion source for require statements and module annotations
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      local cmp = require('cmp')
      cmp.setup({
        snippet = {
          expand = function(args)
            vim.fn["UltiSnips#Anon"](args.body)
          end,
        },
        completion = {
          completeopt = 'menu,menuone,noinsert,noselect',
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i'}),
          ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i'}),
          ['<C-n>'] = cmp.mapping({
            c = function()
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    vim.api.nvim_feedkeys(t('<Down>'), 'n', true)
                end
            end,
            i = function(fallback)
                print("C-n pressed")
                if cmp.visible() then
                    cmp.select_next_item()
                else
                    fallback()
                end
            end
          }),
          ['<C-p>'] = cmp.mapping({
              c = function()
                  if cmp.visible() then
                      cmp.select_prev_item()
                  else
                      vim.api.nvim_feedkeys(t('<Up>'), 'n', true)
                  end
              end,
              i = function(fallback)
                  if cmp.visible() then
                      cmp.select_prev_item()
                  else
                      fallback()
                  end
              end
          }),
        }),
        sources = cmp.config.sources({
          { name = "lazydev", group_index = 0 }, -- set group index to 0 to skip loading LuaLS completions
          { name = "nvim_lsp" },
          { name = "ultisnips" },
          { name = "buffer" },
          { name = "path" },
        }),

      })

      cmp.setup.filetype({ "typescript", "typescript.tsx", "typescriptreact", "javascript", "javascript.jsx" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 100 },    -- Primary, highest priority
          { name = "ultisnips", priority = 90 },     -- Snippets
          { name = "path", priority = 80 },         -- File paths
          { name = "buffer", priority = 50 },       -- Buffer text (lowest)
        }),
        -- Faster sorting (important!)
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            -- Reorder: frequency/locality over alphabetical
            cmp.config.compare.locality,
            cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
      })
    end,
  },
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
}
