vim.cmd [[packadd packer.nvim]]

function on_attach(client, bufnr)
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
    -- nmap('gr', buf('references'))
    nmap('<localleader>f', buf('formatting'))
end

return require('packer').startup(function()

  use 'wbthomason/packer.nvim'

  use 'LionC/nest.nvim'

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

  use { 'nvim-telescope/telescope-ui-select.nvim' }

  use {
    'nvim-telescope/telescope.nvim',
    requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-file-browser.nvim' } },
    config = function()
      local previewers = require("telescope.previewers")

      local new_maker = function(filepath, bufnr, opts)
        opts = opts or {}

        filepath = vim.fn.expand(filepath)
        vim.loop.fs_stat(filepath, function(_, stat)
          if not stat then return end
          if stat.size > 100000 then
            return
          else
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          end
        end)
      end

      require('telescope').setup({
        defaults = {
          buffer_previewer_maker = new_maker,
          mappings = {
            i = {
              ["<esc>"] = require('telescope.actions').close
            }
          }
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown {}
          }
        }
      })

      require('telescope').load_extension('fzf')
      require('telescope').load_extension('ui-select')
      require('telescope').load_extension('file_browser')

      vim.api.nvim_set_keymap('n', '<leader>pf', ':Telescope find_files<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pg', ':Telescope live_grep<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>bb', ':Telescope buffers<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>ff', ':Telescope file_browser<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<leader>pi', ':Telescope quickfix<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', 'gr', ':Telescope lsp_references<CR>', { silent = true, noremap = true })
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

      lsp.rust_analyzer.setup { capabilities = capabilities, on_attach = on_attach }
      lsp.tsserver.setup { on_attach = on_attach }
      lsp.intelephense.setup { on_attach = on_attach }
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
  -- use { 
  --   'TimUntersberger/neogit', 
  --   requires = {
  --     'nvim-lua/plenary.nvim',
  --     'sindrets/diffview.nvim'
  --   },
  --   config = function()
  --     local neogit = require('neogit')
  --     neogit.setup({
  --       integrations = {
  --         diffview = true
  --       }
  --     })
  --     neogit.config.use_magit_keybindings()
  --   end
  -- }

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

  -- this seems to work, but doesn't see the WCL backend as a project because it doesn't use maven/gradle
  use {
    'mfussenegger/nvim-jdtls',
    config = function()
      function _jdtls_connect()
        local project_root = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew', 'build.xml'})

        local config = {
          cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-jar', '/home/emallson/.local/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
            '-configuration', '/home/emallson/.local/jdtls/config_linux',
            '-data', '/home/emallson/.cache/jdtls-workspace/' .. project_root
          },
          root_dir = project_root,
          settings = {
            java = {}
          },
          on_attach = function(client, bufnr) 
            on_attach(client, bufnr)
            require('jdtls.setup').add_commands()
            require('jdtls').setup_dap({ hotcodereplace='auto' }) 
          end,
          init_options = {
            bundles = {
              vim.fn.glob("/home/emallson/Code/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
            }
          }
        }

        require('jdtls').start_or_attach(config)
      end

      vim.cmd[[
        augroup jdtls_lsp
        autocmd!
        autocmd FileType java lua _jdtls_connect()
        augroup end
      ]]
    end
  }

  use 'tpope/vim-sleuth'

  use {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require('dap')
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = {'/home/emallson/Code/vscode-php-debug/out/phpDebug.js'}
      }

      dap.configurations.php = {{
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003,
        pathMappings = {
          ['/var/www/html'] = '${workspaceFolder}'
        },
      }}

      local nest = require('nest')
      nest.applyKeymaps {
        { '<leader>', {
          'd', {
            { 'b', dap.toggle_breakpoint },
            { 'c', dap.continue },
            { 's', {{ 'o', dap.step_over }, { 's', dap.step_into }}},
            { 'r', dap.repl.open }
          }
        }}
      }
    end
  }

  use {
    'rcarriga/nvim-dap-ui', 
    requires = {'mfussenegger/nvim-dap'}, 
    config = function() 
      local dapui = require('dapui')
      dapui.setup() 

      local nest = require('nest')

      nest.applyKeymaps {
        { '<leader>', { 'd', { 'd', dapui.toggle }}}
      }
    end
  }

  use 'jwalton512/vim-blade'

  use '~/Code/rainbow-identifiers'

  use { 
    'ggandor/lightspeed.nvim', 
    config = function() 
      vim.g.lightspeed_no_default_keymaps = true
      local ls = require('lightspeed')
      ls.setup({ ignore_case = true, repeat_ft_with_target_char = true })

      local bind = function(key, fn)
        vim.api.nvim_set_keymap('n', key, '<Plug>Lightspeed_' .. fn, { silent = true })
      end
      bind('j', 's')
      bind('J', 'S')
      bind('x', 'x')
      bind('X', 'X')
      bind('f', 'f')
      bind('F', 'F')

      bind('gj', 'gs')
      bind('gJ', 'gS')
      bind('l', 'omni_s')
      bind('gl', 'omni_gs')
    end 
  }

  use 'tpope/vim-repeat'

  use {
    'folke/trouble.nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function() 
      require('trouble').setup {}
      vim.api.nvim_set_keymap('n', '<leader>cl', '<cmd>Trouble<cr>', { silent = true, noremap = true })
    end
  }
end)
