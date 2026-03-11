{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nautilus # fix filechooser
    thunar
    thunar-volman
    thunar-archive-plugin
    tumbler
    xfconf
    ffmpegthumbnailer
    webp-pixbuf-loader
    file-roller
  ];

  dconf.settings = {
    "org/gtk/settings/file-chooser" = {
      sort-directories-first = true;
      show-hidden = false;
    };
  };

  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "thunar.desktop" ];
  };
}
