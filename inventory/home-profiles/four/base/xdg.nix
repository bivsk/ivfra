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
      music = null;
      pictures = "$HOME/pictures";
      projects = "$HOME/dev";
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
