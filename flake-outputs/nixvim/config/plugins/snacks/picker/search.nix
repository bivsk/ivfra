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
          key = "<leader><space>";
          action = "<CMD>lua Snacks.picker.smart()<CR>";
          options.desc = "Smart Find Files";
        }
        {
          mode = "n";
          key = "<leader>:";
          action = "<CMD>lua Snacks.picker.command_history()<CR>";
          options.desc = "Command History";
        }
        {
          mode = "n";
          key = "<leader>fb";
          action = "<CMD>lua Snacks.picker.buffers()<CR>";
          options.desc = "Find buffers";
        }
        {
          mode = "n";
          key = "<leader>fe";
          action = "<CMD>lua Snacks.explorer()<CR>";
          options.desc = "File Explorer";
        }
        {
          mode = "n";
          key = "<leader>ff";
          action = "<CMD>lua Snacks.picker.files()<CR>";
          options.desc = "Find files";
        }
        {
          mode = "n";
          key = "<leader>fFA";
          action = "<CMD>lua Snacks.picker.files({hidden = true, ignored = true})<CR>";
          options.desc = "Find files (All files)";
        }
        {
          mode = "n";
          key = "<leader>fo";
          action = "<CMD>lua Snacks.picker.recent()<CR>";
          options.desc = "Find old files";
        }
        {
          mode = "n";
          key = "<leader>fO";
          action = "<CMD>lua Snacks.picker.smart()<CR>";
          options.desc = "Find Smart (Frecency)";
        }
        {
          mode = "n";
          key = "<leader>fp";
          action = "<CMD>lua Snacks.picker.projects()<CR>";
          options.desc = "Find projects";
        }
        {
          mode = "n";
          key = "<leader>fq";
          action = "<CMD>lua Snacks.picker.qflist()<CR>";
          options.desc = "Find quickfix";
        }
        {
          mode = "n";
          key = "<leader>fw";
          action = "<CMD>lua Snacks.picker.grep()<CR>";
          options.desc = "Live grep";
        }
        {
          mode = "n";
          key = "<leader>fW";
          action = "<CMD>lua Snacks.picker.grep({hidden = true, ignored = true})<CR>";
          options.desc = "Live grep (All files)";
        }
        {
          mode = "n";
          key = "<leader>f/";
          action = "<CMD>lua Snacks.picker.lines()<CR>";
          options.desc = "Fuzzy find in current buffer";
        }
        {
          mode = "n";
          key = "<leader>f?";
          action = "<CMD>lua Snacks.picker.grep_buffers()<CR>";
          options.desc = "Fuzzy find in open buffers";
        }
        {
          mode = "n";
          key = "<leader>f<CR>";
          action = "<CMD>lua Snacks.picker.resume()<CR>";
          options.desc = "Resume find";
        }
        {
          mode = "n";
          key = "<leader>fZ";
          action = "<CMD>lua Snacks.picker.search_history()<CR>";
          options.desc = "Search History";
        }
        {
          mode = "n";
          key = "<leader>fz";
          action = "<CMD>lua Snacks.picker.zoxide()<CR>";
          options.desc = "Find Zoxide";
        }
        {
          mode = [
            "n"
            "x"
          ];
          key = "<leader>sw";
          action = "<CMD>lua Snacks.picker.grep_word()<CR>";
          options.desc = "Search Word (visual or cursor)";
        }
      ];
}
