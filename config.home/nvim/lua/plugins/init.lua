return {
'tpope/vim-fugitive',
'scrooloose/nerdtree',
'xuyuanp/nerdtree-git-plugin',
'kien/ctrlp.vim',
{ 'neoclide/coc.nvim', branch = 'release', },
{ 'nvim-treesitter/nvim-treesitter', branch = 'master', lazy = false, build = ':TSUpdate' },

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
'sunaku/vim-dasht',

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
{ 'nvim-telescope/telescope.nvim', tag = 'v0.2.0',
  dependencies = { 'nvim-lua/plenary.nvim' }
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
'jiangmiao/auto-pairs',
'stephenway/postcss.vim',

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

-- yaml
'pedrohdz/vim-yaml-folds',

-- diff
'lambdalisue/vim-unified-diff',

-- code-reviews
'AndrewRadev/diffurcate.vim',

-- AI assist
{ 'github/copilot.vim', config = function()
  vim.keymap.set('i', '<C-m>', 'copilot#Accept("\\<CR>")', {
    expr = true,
    replace_keycodes = false
  })
  vim.keymap.set('i', '<C-L>', '<Plug>(copilot-accept-word)')
  vim.keymap.set('i', '<C-Q>', '<Plug>(copilot-dismiss)')
  vim.g.copilot_no_tab_map = true
end
},
'nvim-lua/plenary.nvim',
'CopilotC-Nvim/CopilotChat.nvim',
}
