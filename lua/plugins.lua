function get_config(name)
	return string.format('require("config/%s")', name)
end
return require("packer").startup(function()
	use({ "wbthomason/packer.nvim" })
	use({
		"L3MON4D3/LuaSnip",
	})
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"hrsh7th/vim-vsnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-vsnip",
			"hrsh7th/cmp-calc",
		},
		config = get_config("completion"),
	})
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "ggandor/lightspeed.nvim" })
	use({
		"nvim-telescope/telescope.nvim",
		requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
	})
	use({ "williamboman/mason.nvim", config = get_config("mason") })
	use({ "williamboman/mason-lspconfig.nvim" })
	use({ "neovim/nvim-lspconfig" })
	--use({ 'kyazdani42/nvim-web-devicons' })
	--use({
	--	"romgrk/barbar.nvim",
	--	requires = { "kyazdani42/nvim-web-devicons" },
	--})
	use({ "olimorris/onedarkpro.nvim", config = get_config("onedark") })

	--	use { 'tpope/vim-fugitive'}
	--use({ "ms-jpq/chadtree" })
	use({
		"nvim-tree/nvim-tree.lua",
		requires = {
			"nvim-tree/nvim-web-devicons", -- optional, for file icons
		},
		tag = "nightly", -- optional, updated every week. (see issue #1193)
		config = get_config("nvim-tree"),
	})
	use({ "akinsho/nvim-toggleterm.lua" })
	use({ "mfussenegger/nvim-dap", config = get_config("dap") })
	use({ "mfussenegger/nvim-dap-python" })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" }, config = get_config("dap-ui") })
	use({ "mfussenegger/nvim-dap-python" })
	use({ "theHamsta/nvim-dap-virtual-text", config = get_config("nvim-dap-text") })
	use({ "jparise/vim-graphql" })
	use({
		"hoob3rt/lualine.nvim",
		requires = { "kyazdani42/nvim-web-devicons", opt = true },
	})
	use({ "nvim-treesitter/nvim-treesitter" })
	use({ "mhartington/formatter.nvim", config = get_config("formatter") })
	--    use {'nvim-lua/lsp-status.nvim'}
	--    use {'glepnir/dashboard-nvim'}
	--    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
	--    use {'sindrets/diffview.nvim', branch = 'feat/file-history' }
	use({ "akinsho/git-conflict.nvim", config = get_config("git-conflict") })
	use({
		"lewis6991/gitsigns.nvim",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("gitsigns").setup()
		end,
	})
	--
	--    use {
	--      "puremourning/vimspector",
	--      cmd = { "VimspectorInstall", "VimspectorUpdate" },
	--      fn = { "vimspector#Launch()", "vimspector#ToggleBreakpoint", "vimspector#Continue" },
	--      config = function()
	--        require("../config.vimspector").setup()
	--      end,
	--    }
	use({ "windwp/nvim-ts-autotag", config = get_config("ts-autotag") })
	--    use {
	--      'chipsenkbeil/distant.nvim',
	--      config = function()
	--        require('distant').setup {
	--          -- Applies Chip's personal settings to every machine you connect to
	--          --
	--          -- 1. Ensures that distant servers terminate with no connections
	--          -- 2. Provides navigation bindings for remote directories
	--          -- 3. Provides keybinding to jump into a remote file's parent directory
	--          ['*'] = require('distant.settings').chip_default()
	--        }
	--      end
	--    }
	--    use {'tpope/vim-fugitive'}
	--    use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
end)
