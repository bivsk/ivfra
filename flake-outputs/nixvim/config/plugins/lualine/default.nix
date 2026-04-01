let
  cond.__raw = ''
    function()
      local cache = {}
      return function()
        local bufnr = vim.api.nvim_get_current_buf()
        if cache[bufnr] == nil then
          local buf_size = vim.api.nvim_buf_get_offset(bufnr, vim.api.nvim_buf_line_count(bufnr))
          cache[bufnr] = buf_size < 1024 * 1024 -- 1MB limit
          -- Clear cache on buffer unload
          vim.api.nvim_create_autocmd("BufUnload", {
            buffer = bufnr,
            callback = function() cache[bufnr] = nil end,
          })
        end
        return cache[bufnr]
      end
    end
  '';
in
{
  plugins.lualine = {
    # lualine.nvim documentation
    # See: https://github.com/nvim-lualine/lualine.nvim
    enable = true;

    lazyLoad.settings = {
      event = [
        "VimEnter"
        "BufReadPost"
        "BufNewFile"
      ];
    };

    settings = {
      options = {
        disabled_filetypes = {
          __unkeyed-1 = "startify";
          __unkeyed-2 = "neo-tree";
          __unkeyed-4 = "ministarter";
          __unkeyed-5 = "Avante";
          __unkeyed-6 = "AvanteInput";
          __unkeyed-7 = "trouble";
          __unkeyed-8 = "dapui_scopes";
          __unkeyed-9 = "dapui_breakpoints";
          __unkeyed-10 = "dapui_stacks";
          __unkeyed-11 = "dapui_watches";
          __unkeyed-12 = "dapui_console";
          __unkeyed-13 = "dashboard";
          __unkeyed-14 = "snacks_dashboard";
          __unkeyed-15 = "AvanteSelectedFiles";
          winbar = [
            "aerial"
            "dap-repl"
            "dap-view"
            "dap-view-term"
            "neotest-summary"
            "opencode_terminal"
            "sidekick_terminal"
            "snacks_terminal"
          ];
        };

        globalstatus = true;
      };

      # +-------------------------------------------------+
      # | A | B | C                             X | Y | Z |
      # +-------------------------------------------------+
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [ "branch" ];
        lualine_c = [
          "filename"
          "diff"
        ];

        lualine_x = [
          { __raw = "Snacks.profiler.status()"; }
          {
            __unkeyed-1 = "diagnostics";
            # TODO: figure out how this works
            # It's triplicating number count
            # sources = [
            #   "nvim_lsp"
            #   "nvim_diagnostic"
            #   "nvim_workspace_diagnostic"
            # ];
            diagnostics_color = {
              error = {
                fg = "#ed8796";
              };
              warn = {
                fg = "#eed49f";
              };
              info = {
                fg = "#8aadf4";
              };
              hint = {
                fg = "#a6da95";
              };
            };
            colored = true;
          }
          {
            __unkeyed-1.__raw = ''
              function()
                local ok, lint = pcall(require, "lint")
                if not ok then
                  return ""
                end
                local running = lint.get_running()
                if #running == 0 then
                  return ""
                end
                return "󱉶 " .. table.concat(running, ", ")
              end
            '';
            cond.__raw = ''
              function()
                return vim.bo.buftype == ""
              end
            '';
          }
          # Show active language server
          {
            __unkeyed-1.__raw = ''
              function()
                  local msg = ""
                  local buf_ft = vim.bo.filetype
                  local clients = vim.lsp.get_clients()
                  if next(clients) == nil then
                      return msg
                  end
                  for _, client in ipairs(clients) do
                      local filetypes = client.config.filetypes
                      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
                          return client.name
                      end
                  end
                  return msg
              end
            '';
            icon = "";
            color.fg = "#ffffff";
          }
          # "encoding"
          "fileformat"
          "filetype"
        ];

        lualine_z = [
          {
            __unkeyed-1 = "location";
            inherit cond;
          }
        ];
      };
    };
  };
}
