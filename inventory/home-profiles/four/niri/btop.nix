{ pkgs, ... }:
{
  programs.btop = {
    enable = true;
    package = pkgs.btop-rocm;
    settings = {
      vim_keys = true;
      update_ms = 1000;
    };
  };
}
