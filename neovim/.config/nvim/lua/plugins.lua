vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  use 'p00f/nvim-ts-rainbow'

  use {
    'folke/twilight.nvim',
    config = function()
      require('twilight').setup {
        dimming = { alpha = 0.7 },
      }
    end
  }

  use 'andreypopp/vim-colors-plain'

  use 'rafcamlet/nvim-luapad'

  use {
    'Olical/conjure',
    config = function()
      vim.cmd[[
      augroup conjure_set_state_key
      autocmd!
      autocmd BufEnter *.clj execute "ConjureClientState clj"
      autocmd BufEnter *.cljs execute "ConjureClientState cljs"
      autocmd BufEnter *.cljc execute "ConjureClientState clj"
      augroup END
      ]]
    end
  }
  use {
    'tpope/vim-commentary',
    config = function()
    end
  }
  use 'tpope/vim-surround'

  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'make'
  }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }},
    config = function()
      require('telescope').setup({
        defaults = {
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close
            }
          }
        }
      })

      require('telescope').load_extension('fzf')
      vim.api.nvim_set_keymap('n', '<leader>pf', ':Telescope find_files<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pg', ':Telescope live_grep<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope file_browser<CR>', { silent = true, noremap = true })
    end
  }

  -- use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
  -- use {
  --   'junegunn/fzf.vim', 
  --   config = function() 
  --     local kopt = { noremap = true, silent = true }
  --     vim.api.nvim_set_keymap('n', '<leader>pf', ':Files<CR>', kopt)
  --     vim.api.nvim_set_keymap('n', '<leader>pg', ':Rg ', kopt)
  --     vim.api.nvim_set_keymap('n', '<leader>bb', ':Buffers<CR>', kopt)
  --   end
  -- }

  use 'PaterJason/cmp-conjure'
  use {
    'hrsh7th/nvim-cmp',
    requires = {'neovim/nvim-lspconfig', 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'L3MON4D3/LuaSnip'},
    config = function()
      local cmp = require('cmp')
      cmp.setup({
        sources = cmp.config.sources({ { name = 'nvim_lsp' }, { name = 'conjure' } }),
        mapping = {
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        },
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end
        }
      })
      local cap = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
      local lsp = require('lspconfig')

      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf(name) return '<cmd>lua vim.lsp.buf.' .. name .. '()<CR>' end

        local opts = { noremap = true, silent = true }

        local function nmap(key, cmd) buf_set_keymap('n', key, cmd, opts) end

        nmap('gD', buf('declaration'))
        nmap('gd', buf('definition'))
        nmap('K', buf('hover'))
        nmap('gi', buf('implementation'))
        nmap('<C-k>', buf('signature_help'))
        nmap('<localleader>rr', buf('rename'))
        nmap('<localleader>a', buf('code_action'))
        nmap('gr', buf('references'))
        nmap('<localleader>f', buf('formatting'))
      end

      lsp.rust_analyzer.setup { capabilities = capabilities, on_attach = on_attach }
      lsp.tsserver.setup { on_attach = on_attach }
      lsp.phpactor.setup{ on_attach = on_attach }
    end
  }

  use {
    'windwp/nvim-autopairs',
    config = function() 
      local npairs = require('nvim-autopairs')
      npairs.setup({
        check_ts = true
      })

      npairs.add_rules(require('nvim-autopairs.rules.endwise-lua'))
    end
  }

  use {
    'windwp/nvim-ts-autotag',
    config = function() 
      require('nvim-ts-autotag').setup()
    end
  }

  use { 
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({ options = { theme = 'ayu_light' }}) 
    end 
  }
  use 'tpope/vim-fugitive'
  use { 
    'TimUntersberger/neogit', 
    requires = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim'
    },
    config = function()
      local neogit = require('neogit')
      neogit.setup({
        integrations = {
          diffview = true
        }
      })
      neogit.config.use_magit_keybindings()
    end
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup({
        plugins = {
          presets = {
            operators = false,
          }
        }
      })
    end
  }

  use 'nvim-treesitter/playground'

  use {
    'sbdchd/neoformat', 
    config = function()
      vim.cmd[[
      augroup fmt
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
      augroup END
      ]]
    end
  }

  use '~/Code/rainbow-identifiers'
end)
