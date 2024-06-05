return {
  {
    "mfussenegger/nvim-dap",
    recommended = true,
    desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

    dependencies = {

      -- fancy UI for the debugger
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
          vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0 })
          vim.api.nvim_set_hl(0, "DapLogPoint", { ctermbg = 0 })
          vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0 })
          local dap_breakpoint = {
            error = {
              text = "🔴",
              texthl = "DapBreakpoint",
              linehl = "DapBreakpoint",
              numhl = "DapBreakpoint",
            },
            condition = {
              text = "🟰",
              texthl = "DapBreakpoint",
              linehl = "DapBreakpoint",
              numhl = "DapBreakpoint",
            },
            rejected = {
              text = "🚫",
              texthl = "DapBreakpoint",
              linehl = "DapBreakpoint",
              numhl = "DapBreakpoint",
            },
            logpoint = {
              text = "⚠️",
              texthl = "DapLogPoint",
              linehl = "DapLogPoint",
              numhl = "DapLogPoint",
            },
            stoppoint = {
              text = "➡️",
              texthl = "DapStopped",
              linehl = "DapStopped",
              numhl = "DapStopped",
            },
          }
          vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
          vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
          vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
          vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
          vim.fn.sign_define("DapStopped", dap_breakpoint.stoppoint)

          -- return {
          --   enabled = true, -- enable this plugin (the default)
          --   enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
          --   highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
          --   highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
          --   show_stop_reason = true, -- show stop reason when stopped for exceptions
          --   commented = false, -- prefix virtual text with comment string
          --   only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
          --   all_references = false, -- show virtual text on all all references of the variable (not only definitions)
          --   filter_references_pattern = "<module", -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
          --   -- Experimental Features:
          --   virt_text_pos = "eol", -- position of virtual text, see `:h nvim_buf_set_extmark()`
          --   all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
          --   virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
          --   virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
          -- }
        end,
      },

      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },

      -- which key integration
      {
        "folke/which-key.nvim",
        optional = true,
        opts = {
          defaults = {
            ["<leader>d"] = { name = "+debug" },
          },
        },
      },

      -- mason.nvim integration
      {
        "jay-babu/mason-nvim-dap.nvim",
        dependencies = "mason.nvim",
        cmd = { "DapInstall", "DapUninstall" },
        opts = {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
          },
        },
      },

      -- VsCode launch.json parser
      {
        "folke/neoconf.nvim",
      },
    },

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Launch/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

    config = function()
      local dap = require("dap")
      -- https://github.com/mfussenegger/nvim-dap/wiki/C-C---Rust-(via--codelldb)
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          -- whereis code lldb
          command = "codelldb",
          args = { "--port", "${port}" },
        },
      }

      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Attach to process",
          type = "codelldb",
          request = "attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end,

    -- config = function()
    --   local Config = require("lazyvim.config")
    --   vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
    --
    --   for name, sign in pairs(Config.icons.dap) do
    --     sign = type(sign) == "table" and sign or { sign }
    --     vim.fn.sign_define(
    --       "Dap" .. name,
    --       { text = sign[1], texthl = sign[2] or "DiagnosticInfo", linehl = sign[3], numhl = sign[3] }
    --     )
    --   end
    --
    --   -- setup dap config by VsCode launch.json file
    --   local vscode = require("dap.ext.vscode")
    --   local _filetypes = require("mason-nvim-dap.mappings.filetypes")
    --   local filetypes = vim.tbl_deep_extend("force", _filetypes, {
    --     ["node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
    --     ["pwa-node"] = { "javascriptreact", "typescriptreact", "typescript", "javascript" },
    --   })
    --   local json = require("plenary.json")
    --   vscode.json_decode = function(str)
    --     return vim.json.decode(json.json_strip_comments(str))
    --   end
    --   vscode.load_launchjs(nil, filetypes)
    -- end,
  },
}
