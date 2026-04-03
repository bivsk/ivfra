{ config, lib, ... }:
{
  plugins.blink-indent = {
    # blink-indent documentation
    # See: https://github.com/saghen/blink.indent
    enable = true;

    lazyLoad.settings = {
      event = [
        "BufReadPost"
        "BufNewFile"
      ];
    };
  };

  keymaps = lib.optionals config.plugins.blink-indent.enable [
    {
      mode = "n";
      key = "<leader>ui";
      action.__raw = ''
        function()
          local indent = require('blink.indent')
          indent.enable(not indent.is_enabled())
          vim.notify(string.format("Indent Guides %s", bool2str(indent.is_enabled())), "info")
        end
      '';
      options.desc = "Indent Guides toggle";
    }
  ];
}
