return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "leoluz/nvim-dap-go",
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
      "nvim-neotest/nvim-nio",
      "williamboman/mason.nvim",
    },
    config = function()
      local dap = require "dap"
      local ui = require "dapui"

      require("dapui").setup()
      require("dap-go").setup()

      require("flutter-tools").setup {}

      --[[
      require("nvim-dap-virtual-text").setup {
        -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
        display_callback = function(variable)
          local name = string.lower(variable.name)
          local value = string.lower(variable.value)
          if name:match "secret" or name:match "api" or value:match "secret" or value:match "api" then
            return "*****"
          end

          if #variable.value > 15 then
            return " " .. string.sub(variable.value, 1, 15) .. "... "
          end

          return " " .. variable.value
        end,
      }
--]]
      -- Handled by nvim-dap-go
      -- dap.adapters.go = {
      --   type = "server",
      --   port = "${port}",
      --   executable = {
      --     command = "dlv",
      --     args = { "dap", "-l", "127.0.0.1:${port}" },
      --   },
      -- }

      vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)
      vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

      -- Eval var under cursor
      vim.keymap.set("n", "<space>?", function()
        require("dapui").eval(nil, { enter = true })
      end)

      vim.keymap.set("n", "<F1>", dap.continue)
      vim.keymap.set("n", "<F2>", dap.step_into)
      vim.keymap.set("n", "<F3>", dap.step_over)
      vim.keymap.set("n", "<F4>", dap.step_out)
      vim.keymap.set("n", "<F5>", dap.step_back)
      vim.keymap.set("n", "<F10>", dap.restart)

      dap.listeners.before.attach.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        ui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        ui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        ui.close()
      end

      --[[
      dap.adapters.dart = {
        type = "executable",
        command = "node",
        args = { os.getenv "HOME" .. "/.vscode/extensions/dart-code.flutter/.dart-server/DartDebug.js", "flutter" },
      }

      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter App",
          program = "${workspaceFolder}/lib/main.dart",
          cwd = "${workspaceFolder}",
        },
      }
      --]]

      dap.adapters.godot = {
        type = "server",
        host = "127.0.0.1",
        port = "6006",
      }

      -- Unity Debug

      dap.adapters.unity = function(clbk, config)
        -- options passed to unity-debug-adapter.exe

        -- when connecting to a running Unity Editor, the TCP address of the listening
        -- connection is localhost
        -- on Linux, use: ss -tlp | grep 'Unity' to find the debugger connection
        vim.ui.input({ prompt = "address [127.0.0.1]: ", default = "127.0.0.1" }, function(result)
          config.address = result
        end)
        -- then prompt the user for which port the DA should connect to
        vim.ui.input({ prompt = "port: " }, function(result)
          config.port = tonumber(result)
        end)
        clbk {
          type = "executable",
          -- adjust mono path - do NOT use Unity's integrated MonoBleedingEdge
          command = "mono",
          -- adjust unity-debug-adapter.exe path
          args = {
            -- get and install Unity debug adapter from:
            -- https://github.com/walcht/unity-dap
            -- then adjust the following path to where the installed executable is
            "/home/potato/Projects/other/unity-dap/unity-debug-adapter/obj/Release/unity-debug-adapter.exe",
            -- optional log level argument: trace | debug | info | warn | error | critical | none
            "--log-level=error",
            -- optional path to log file (logs to stderr in case this is not provided)
            -- "--log-file=<path_to_log_file_txt>",
          },
        }
      end

      -- make sure NOT to override other C# DAP configurations
      if dap.configurations.cs == nil then
        dap.configurations.cs = {}
      end

      table.insert(dap.configurations.cs, {
        name = "Unity Editor/Player Instance [Mono]",
        type = "unity",
        request = "attach",
      })

      -- End Unity Debug
    end,
  },
}
