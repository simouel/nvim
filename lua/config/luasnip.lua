require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_snipmate").load({ path = { "~/.config/nvim/my-snippets" } }) -- Load snippets from my-snippets folder
-- If path is not specified, luasnip will look for the `snippets` directory in rtp (for custom-snippet probably
-- `~/.config/nvim/snippets`).
