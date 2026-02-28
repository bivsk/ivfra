{ lib, ... }:
{
  # Make programs use XDG directories whenever supported
  home.preferXdgDirectories = true;

  xdg.userDirs = rec {
    enable = true;
    createDirectories = true;
    documents = "$HOME/docs";
    download = "$HOME/downloads";
    music = "$HOME/music";
    pictures = "$HOME/pictures";
    videos = "$HOME/videos";
    extraConfig = {
      XDG_SCREENSHOTS_DIR = lib.mkForce "${pictures}/screenshots";
      XDG_PROJECTS_DIR = lib.mkForce "$HOME/git";
    };
  };
}
