{
  plugins.showkeys = {
    # showkeys.nvim documentation
    # See: https://github.com/nvzone/showkeys
    enable = true;

    lazyLoad.settings.cmd = [ "ShowkeysToggle" ];

    settings = {
      position = "top-right";
      timeout = 2;
      maxkeys = 5;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>usk";
      action = "<cmd>ShowkeysToggle<CR>";
      options.desc = "Toggle showkeys";
    }
  ];
}
