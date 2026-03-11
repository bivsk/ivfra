{ lib, ... }:
{
  # Make programs use XDG directories whenever supported
  home.preferXdgDirectories = true;

  xdg = {
    mimeApps.enable = true;
    userDirs = rec {
      enable = true;
      createDirectories = true;
      desktop = null;
      documents = "$HOME/docs";
      download = "$HOME/downloads";
      music = "$HOME/music";
      pictures = "$HOME/pictures";
      publicShare = null;
      videos = "$HOME/videos";
      templates = null;
      extraConfig = {
        XDG_SCREENSHOTS_DIR = lib.mkForce "${pictures}/screenshots";
        XDG_PROJECTS_DIR = lib.mkForce "$HOME/dev";
      };
    };
  };
}
