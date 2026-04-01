{
  config,
  lib,
  ...
}:
{
  plugins = {
    snacks = {
      settings = {
        scratch.enabled = true;
      };
    };

  };

  keymaps =
    lib.mkIf
      (
        config.plugins.snacks.enable
        && lib.hasAttr "scratch" config.plugins.snacks.settings
        && config.plugins.snacks.settings.scratch.enabled
      )
      [
        {
          mode = "n";
          key = "<leader>nn";
          action = "<CMD>lua Snacks.scratch()<CR>";
          options.desc = "New Scratch Buffer";
        }
        {
          mode = "n";
          key = "<leader>ns";
          action = "<CMD>lua Snacks.scratch.select()<CR>";
          options.desc = "Select Scratch Buffer";
        }
      ];
}
