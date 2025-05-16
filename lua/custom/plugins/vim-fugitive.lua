return {
  'tpope/vim-fugitive',
  lazy = false,
  cmd = { 'G', 'Git' }, -- Remove desc from here, it should be in keys
  keys = {
    { '<leader>g', '<Nop>', desc = 'Git' },
    -- Status and overview
    { '<leader>gs', ':Git<CR>', desc = 'Git status' },
    { '<leader>gS', ':tab Git<CR>', desc = 'Git status in new tab' },

    -- Staging and committing
    { '<leader>ga', ':Git add %<CR>', desc = 'Git add current file' },
    { '<leader>gA', ':Git add .<CR>', desc = 'Git add all' },
    { '<leader>gu', ':Git restore --staged %<CR>', desc = 'Git unstage current file' },

    -- Committing
    { '<leader>gc', ':Git commit<CR>', desc = 'Git commit' },
    { '<leader>gca', ':Git commit --amend<CR>', desc = 'Git commit amend' },
    { '<leader>gcm', ":Git commit -m '", desc = 'Git commit with message' },

    -- Checking changes
    { '<leader>gd', ':Gdiffsplit<CR>', desc = 'Git diff split' },
    { '<leader>gD', ':Git diff<CR>', desc = 'Git diff' },
    { '<leader>gp', ':Git push<CR>', desc = 'Git push' },
    { '<leader>gP', ':Git pull<CR>', desc = 'Git pull' },

    -- History and inspection
    { '<leader>gb', ':Git blame<CR>', desc = 'Git blame' },
    { '<leader>gl', ':Git log<CR>', desc = 'Git log' },
    { '<leader>gL', ':Git log --oneline<CR>', desc = 'Git log (oneline)' },

    -- Interactive operations
    { '<leader>gi', ':Git add -p %<CR>', desc = 'Git add interactive (current file)' },
    { '<leader>gI', ':Git add -p<CR>', desc = 'Git add interactive (all)' },

    -- Branch operations
    { '<leader>gch', ':Git checkout ', desc = 'Git checkout' },
    { '<leader>gb', ':Git branch<CR>', desc = 'Git branches' },
    { '<leader>gm', ':Git merge ', desc = 'Git merge' },

    -- Browse files at current commit
    { '<leader>gB', ':GBrowse<CR>', desc = 'Git browse online' },
    { '<leader>gcp', ':Gcommitpr<CR>', desc = 'Git commit with preview' },
  },
  config = function()
    -- Configure split directions for predictability
    vim.opt.splitright = true -- Vertical splits open to the right
    vim.opt.splitbelow = true -- Horizontal splits open below

    -- Clean 3-pane commit preview
    vim.api.nvim_create_user_command('Gcommitpr', function()
      -- Vertical split for commit message
      vim.cmd 'vertical Git diff --staged'
      -- Show staged diff in bottom-right pane
      vim.cmd 'horizontal Git commit'
    end, {})
  end,
}
