-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
vim.lsp.config.emmet_ls = {
  filetypes = {
    "css",
    "eruby",
    "html",
    "htmldjango",
    "javascriptreact",
    "less",
    "pug",
    "sass",
    "scss",
    "typescriptreact",
    "htmlangular",
    "svelte",
    "blade",
  },
}
require("conform").setup({
  formatters_by_ft = {
    svelte = { "prettier" },
    blade = { "blade-formatter", "tlint" },
  },
})
