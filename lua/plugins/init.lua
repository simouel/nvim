return require('packer').startup(function() 
	use { 'wbthomason/packer.nvim' }
	use { 'neovim/nvim-lspconfig' }
	use { 'glepnir/lspsaga.nvim' }
	use { 'hrsh7th/nvim-compe' }
	use { 'morhetz/gruvbox'}
	use { 'ms-jpq/chadtree'}
    use { 'hrsh7th/vim-vsnip'}
    use { 'soywod/himalaya', rtp = 'vim'}
    use { 'akinsho/nvim-toggleterm.lua'}
    use { 'ggandor/lightspeed.nvim'}
    --use { 'phaazon/hop.nvim'}
    use {
      'hoob3rt/lualine.nvim',
      requires = {'kyazdani42/nvim-web-devicons', opt = true}
    }

    use {
      'nvim-telescope/telescope.nvim',
      requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use {'mhartington/formatter.nvim'}
    use {'nvim-lua/lsp-status.nvim'}
    use {'glepnir/dashboard-nvim'}
    use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
    use {'sindrets/diffview.nvim', branch = 'feat/file-history' }
    use {
      'lewis6991/gitsigns.nvim',
      requires = {
        'nvim-lua/plenary.nvim'
      },
      config = function()
        require('gitsigns').setup()
      end
    }
    use {'windwp/nvim-ts-autotag'}
--    use {'tpope/vim-fugitive'}
--    use {"lukas-reineke/indent-blankline.nvim", branch = "lua"}
end)
