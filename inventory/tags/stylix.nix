{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  theme = "kanagawa"; # https://github.com/tinted-theming/schemes/tree/spec-0.11/base16/
in
{
  imports = [ inputs.stylix.nixosModules.stylix ];

  # fonts.fontconfig.enable = true;
  # Enable Stylix
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    fonts = {
      sansSerif = lib.mkDefault {
        package = pkgs.lexend;
        name = "Lexend";
      };

      serif = lib.mkDefault config.stylix.fonts.sansSerif;

      monospace = {
        package = pkgs.nerd-fonts.comic-shanns-mono;
        name = "ComicShannsMono Nerd Font";
      };

      emoji = {
        package = pkgs.noto-fonts-color-emoji;
        name = "Noto Color Emoji";
      };
    };

    icons = {
      enable = true;
      package = pkgs.tela-icon-theme;
      light = "Tela";
      dark = "Tela";
    };

    opacity = lib.genAttrs [ "applications" "desktop" "popups" "terminal" ] (_n: 0.85);
  };
}
