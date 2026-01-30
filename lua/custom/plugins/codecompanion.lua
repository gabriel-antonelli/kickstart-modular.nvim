return {
  'olimorris/codecompanion.nvim',
  version = '^18.0.0',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-telescope/telescope.nvim',
    { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
  },

  opts = function()
    return {
      adapters = {
        copilot = function()
          return require('codecompanion.adapters').extend('copilot', {
            schema = {
              model = {
                default = 'gpt-4o',
              },
            },
          })
        end,
      },

      strategies = {
        chat = {
          adapter = 'copilot',
          roles = {
            llm = ' Assistant',
            user = ' You',
          },
        },
        inline = {
          adapter = 'copilot',
        },
        agent = {
          adapter = 'copilot',
          tools = {
            ['editor'] = {
              enabled = true,
            },
            ['cmd_runner'] = {
              enabled = true,
            },
            ['rag'] = {
              enabled = true,
            },
          },
        },
      },

      display = {
        action_palette = {
          width = 95,
          height = 25,
          prompt = ' CodeCompanion ',
          provider = 'default',
          opts = {
            show_default_actions = true,
            show_default_prompt_library = true,
          },
        },
        chat = {
          window = {
            layout = 'vertical',
            width = 0.45,
            height = 0.95,
            border = 'rounded',
          },
          intro_message = ' Welcome! How can I help you code today?',
          show_settings = false,
          show_token_count = true,
        },
        diff = {
          enabled = true,
        },
      },

      prompt_library = {
        ['Direct Edit'] = {
          strategy = 'chat',
          description = ' Direct edits to current buffer',
          opts = {
            index = 13,
            is_default = true,
            modes = { 'v', 'n' },
            short_name = 'edit',
            auto_submit = false,
          },
          prompts = {
            {
              role = 'system',
              content = 'You are a code editor. Make the requested changes and return ONLY the modified code, nothing else.',
              opts = {
                visible = false,
              },
            },
            {
              role = 'user',
              content = '@{insert_edit_into_file} #{buffer}',
              opts = {
                contains_code = true,
              },
            },
          },
        },
        ['Explain Code'] = {
          strategy = 'chat',
          description = ' Explain what the selected code does',
          opts = {
            index = 1,
            is_default = true,
            modes = { 'v' },
            short_name = 'explain',
            auto_submit = false,
          },
          prompts = {
            {
              role = 'system',
              content = 'You are an expert programmer. Explain code clearly and concisely.',
              opts = {
                visible = false,
              },
            },
            {
              role = 'user',
              content = 'Please explain this code:\n\n```\n#{selection}\n```',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Code Review'] = {
          strategy = 'chat',
          description = ' Review code for quality and best practices',
          opts = {
            index = 2,
            is_default = true,
            modes = { 'v' },
            short_name = 'review',
          },
          prompts = {
            {
              role = 'system',
              content = 'You are a senior software engineer. Review code for quality, bugs, performance, and best practices.',
              opts = {
                visible = false,
              },
            },
            {
              role = 'user',
              content = 'Please review this code and provide specific feedback:\n\n```\n#{selection}\n```',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Fix Bugs'] = {
          strategy = 'chat',
          description = ' Fix bugs and issues in code',
          opts = {
            index = 3,
            is_default = true,
            modes = { 'v' },
            short_name = 'fix',
          },
          prompts = {
            {
              role = 'user',
              content = 'Find and fix any bugs in this code:\n\n```\n#{selection}\n```\n\nExplain what was wrong and how you fixed it.',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Generate Tests'] = {
          strategy = 'chat',
          description = ' Generate unit tests for code',
          opts = {
            index = 4,
            is_default = true,
            modes = { 'v' },
            short_name = 'tests',
          },
          prompts = {
            {
              role = 'system',
              content = 'You are an expert at writing comprehensive unit tests.',
              opts = {
                visible = false,
              },
            },
            {
              role = 'user',
              content = 'Generate comprehensive unit tests for this code:\n\n```\n#{selection}\n```',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Optimize'] = {
          strategy = 'chat',
          description = ' Optimize code for performance',
          opts = {
            index = 5,
            is_default = true,
            modes = { 'v' },
            short_name = 'optimize',
          },
          prompts = {
            {
              role = 'user',
              content = 'Optimize this code for better performance:\n\n```\n#{selection}\n```\n\nExplain the improvements.',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Refactor'] = {
          strategy = 'chat',
          description = ' Refactor code for better structure',
          opts = {
            index = 6,
            is_default = true,
            modes = { 'v' },
            short_name = 'refactor',
          },
          prompts = {
            {
              role = 'user',
              content = 'Refactor this code to improve readability and maintainability:\n\n```\n#{selection}\n```',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Add Comments'] = {
          strategy = 'inline',
          description = ' Add helpful comments to code',
          opts = {
            index = 7,
            modes = { 'v' },
            short_name = 'comment',
          },
          prompts = {
            {
              role = 'user',
              content = 'Add clear, helpful comments to this code:\n\n```\n#{selection}\n```\n\nReturn only the code with comments.',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Add Docstring'] = {
          strategy = 'inline',
          description = ' Generate documentation for functions',
          opts = {
            index = 8,
            modes = { 'v' },
            short_name = 'docs',
          },
          prompts = {
            {
              role = 'user',
              content = 'Add a comprehensive docstring/documentation to this code:\n\n```\n#{selection}\n```',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Debug Help'] = {
          strategy = 'chat',
          description = ' Help debug problematic code',
          opts = {
            index = 9,
            is_default = true,
            modes = { 'v' },
            short_name = 'debug',
          },
          prompts = {
            {
              role = 'user',
              content = 'Help me debug this code:\n\n```\n#{selection}\n```\n\nIdentify potential issues and suggest debugging strategies.',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Simplify'] = {
          strategy = 'inline',
          description = ' Simplify complex code',
          opts = {
            index = 10,
            modes = { 'v' },
            short_name = 'simplify',
          },
          prompts = {
            {
              role = 'user',
              content = 'Simplify this code while maintaining functionality:\n\n```\n#{selection}\n```',
              opts = {
                contains_code = true,
              },
            },
          },
        },

        ['Ask Question'] = {
          strategy = 'chat',
          description = ' Ask a question about programming',
          opts = {
            index = 11,
            is_default = true,
            modes = { 'n', 'v' },
            short_name = 'ask',
            user_prompt = true,
          },
          prompts = {
            {
              role = 'system',
              content = 'You are a helpful programming assistant.',
              opts = {
                visible = false,
              },
            },
          },
        },

        ['Custom Request'] = {
          strategy = 'chat',
          description = ' Custom prompt with code context',
          opts = {
            index = 12,
            modes = { 'n', 'v' },
            short_name = 'custom',
            user_prompt = true,
          },
          prompts = {
            {
              role = 'user',
              content = function(context)
                if context.selection then
                  return string.format('Here is some code:\n\n```\n%s\n```\n\n', context.selection)
                end
                return ''
              end,
            },
          },
        },
      },

      log_level = 'INFO',
      send_code = true,
    }
  end,

  config = function(_, opts)
    require('codecompanion').setup(opts)

    vim.cmd [[cab cc CodeCompanion]]
    vim.cmd [[cab cca CodeCompanionActions]]
    vim.cmd [[cab ccc CodeCompanionChat]]
  end,

  keys = {
    {
      '<leader>ad',
      function()
        require('codecompanion').prompt 'edit'
      end,
      desc = 'Direct Edit Buffer',
      mode = { 'n', 'v' },
    },
    {
      '<leader>a',
      '<cmd>CodeCompanionActions<cr>',
      desc = ' AI Actions',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ac',
      '<cmd>CodeCompanionChat Toggle<cr>',
      desc = 'Toggle Chat',
      mode = { 'n', 'v' },
    },
    {
      '<leader>aC',
      '<cmd>CodeCompanionChat Add<cr>',
      desc = 'Add to Chat',
      mode = 'v',
    },
    {
      '<leader>ai',
      '<cmd>CodeCompanion<cr>',
      desc = 'Inline Assist',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ae',
      function()
        require('codecompanion').prompt 'explain'
      end,
      desc = 'Explain Code',
      mode = 'v',
    },
    {
      '<leader>ar',
      function()
        require('codecompanion').prompt 'review'
      end,
      desc = 'Review Code',
      mode = 'v',
    },
    {
      '<leader>af',
      function()
        require('codecompanion').prompt 'fix'
      end,
      desc = 'Fix Code',
      mode = 'v',
    },
    {
      '<leader>at',
      function()
        require('codecompanion').prompt 'tests'
      end,
      desc = 'Generate Tests',
      mode = 'v',
    },
    {
      '<leader>ao',
      function()
        require('codecompanion').prompt 'optimize'
      end,
      desc = 'Optimize Code',
      mode = 'v',
    },
  },
}
