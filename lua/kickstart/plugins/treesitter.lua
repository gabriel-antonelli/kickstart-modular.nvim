return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = 'main',
    config = function()
      -- Na branch 'main', usamos o instalador diretamente
      local configs = require 'nvim-treesitter.install'

      -- Configurações de instalação
      configs.prefer_git = true

      -- Para garantir que os parsers sejam instalados
      -- O comando TSInstall ainda funciona manualmente
    end,
    -- Como a branch main não tem mais o módulo .configs,
    -- passamos as opções de instalação e deixamos o highlight nativo agir
    opts = {
      ensure_installed = { 'bash', 'c', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc' },
      auto_install = true,
    },
  },
}
