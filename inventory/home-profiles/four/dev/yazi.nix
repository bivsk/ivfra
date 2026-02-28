{ lib, pkgs, ... }:
{
  programs.yazi = {
    enable = true;
    enableNushellIntegration = true;

    shellWrapperName = "y";
    settings = {
      mgr.show_hidden = true;
      open.rules = [
        {
          mime = "*";
          use = "open";
        }
      ];
      opener.open = [
        {
          run = ''${lib.getExe' pkgs.xdg-utils "xdg-open"} "$@"'';
          desc = "Open";
        }
      ];
    };
  };
}
