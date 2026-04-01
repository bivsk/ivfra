{
  config,
  lib,
  ...
}:
{
  keymaps =
    lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      [
        {
          mode = "n";
          key = "<leader>fa";
          action = "<CMD>lua Snacks.picker.autocmds()<CR>";
          options.desc = "Find autocmds";
        }
        {
          mode = "n";
          key = "<leader>fc";
          action = "<CMD>lua Snacks.picker.commands()<CR>";
          options.desc = "Find commands";
        }
        {
          mode = "n";
          key = "<leader>fC";
          action.__raw = ''
            function()
              require("snacks.picker").files {
                prompt_title = "Config Files",
                cwd = vim.fn.stdpath("config"),
              }
            end
          '';
          options = {
            desc = "Find config files";
            silent = true;
          };
        }
        {
          mode = "n";
          key = "<leader>fh";
          action = "<CMD>lua Snacks.picker.help()<CR>";
          options.desc = "Find help tags";
        }
        {
          mode = "n";
          key = "<leader>fk";
          action = "<CMD>lua Snacks.picker.keymaps()<CR>";
          options.desc = "Find keymaps";
        }
        {
          mode = "n";
          key = "<leader>fL";
          action.__raw = ''
            function()
              Snacks.picker.files({
                dirs = { vim.fn.stdpath("state") },
                ft = "log",
                hidden = true,
                ignored = true,
                title = "Neovim Logs",
              })
            end
          '';
          options.desc = "Find Neovim Logs";
        }
        {
          mode = "n";
          key = "<leader>fm";
          action = "<CMD>lua Snacks.picker.man()<CR>";
          options.desc = "Find man pages";
        }
        {
          mode = "n";
          key = "<leader>fr";
          action = "<CMD>lua Snacks.picker.registers()<CR>";
          options.desc = "Find registers";
        }
        {
          mode = "n";
          key = "<leader>fu";
          action = "<CMD>lua Snacks.picker.undo()<CR>";
          options.desc = "Undo History";
        }
        {
          mode = "n";
          key = "<leader>f'";
          action = "<CMD>lua Snacks.picker.marks()<CR>";
          options.desc = "Find marks";
        }
        {
          mode = "n";
          key = "<leader>fj";
          action = "<CMD>lua Snacks.picker.jumps()<CR>";
          options.desc = "Find jumps";
        }
        {
          mode = "n";
          key = "<leader>X";
          action = "<CMD>lua Snacks.profiler.toggle()<CR>";
          options.desc = "Toggle Neovim profiler";
        }
      ];
}
