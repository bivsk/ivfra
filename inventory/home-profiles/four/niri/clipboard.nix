{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Clipboard utils
    wl-clipboard
    wl-clip-persist
    cliphist
  ];
}
