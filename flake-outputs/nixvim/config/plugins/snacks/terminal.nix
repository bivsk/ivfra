{ config, lib, ... }:
{
  plugins.snacks.settings = {
    terminal.enabled = true;
  };

  keymaps = lib.mkIf config.plugins.snacks.settings.terminal.enabled [
    {
      mode = "n";
      key = "<C-/>";
      action = "<CMD>lua Snacks.terminal.toggle()<CR>";
      options.desc = "Toggle Terminal";
    }
    {
      mode = "t";
      key = "<C-/>";
      action = "<CMD>lua Snacks.terminal.toggle()<CR>";
      options.desc = "Toggle Terminal";
    }
    {
      mode = "n";
      key = "<leader>ut";
      action = "<CMD>lua Snacks.terminal.toggle()<CR>";
      options.desc = "Toggle Terminal";
    }
  ];
}
