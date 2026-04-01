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
          key = "<leader>gff";
          action = "<CMD>lua Snacks.picker.git_files()<CR>";
          options.desc = "Git Files";
        }
        {
          mode = "n";
          key = "<leader>gfb";
          action = "<CMD>lua Snacks.picker.git_branches()<CR>";
          options.desc = "Git Branches";
        }
        {
          mode = "n";
          key = "<leader>gfc";
          action = "<CMD>lua Snacks.picker.git_log()<CR>";
          options.desc = "Git Commits";
        }
        {
          mode = "n";
          key = "<leader>gfs";
          action = "<CMD>lua Snacks.picker.git_status()<CR>";
          options.desc = "Git Status";
        }
        {
          mode = "n";
          key = "<leader>gfh";
          action = "<CMD>lua Snacks.picker.git_stash()<CR>";
          options.desc = "Git Stashes";
        }
        {
          mode = "n";
          key = "<leader>gfL";
          action = "<CMD>lua Snacks.picker.git_log_line()<CR>";
          options.desc = "Git Log Line";
        }
        {
          mode = "n";
          key = "<leader>gfd";
          action = "<CMD>lua Snacks.picker.git_diff()<CR>";
          options.desc = "Git Diff (Hunks)";
        }
        {
          mode = "n";
          key = "<leader>gfa";
          action = "<CMD>lua Snacks.picker.git_log_file()<CR>";
          options.desc = "Git Log File";
        }
      ];
}
