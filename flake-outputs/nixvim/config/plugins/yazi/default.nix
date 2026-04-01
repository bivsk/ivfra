{
  plugins = {
    yazi = {
      # yazi.nvim documentation
      # See: https://github.com/mikavilpas/yazi.nvim
      enable = true;

      lazyLoad.settings.cmd = [ "Yazi" ];
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>e";
      action = "<CMD>Yazi<CR>";
      options.desc = "Yazi (current file)";
    }
    {
      mode = "n";
      key = "<leader>E";
      action = "<CMD>Yazi toggle<CR>";
      options.desc = "Yazi (toggle)";
    }
  ];
}
