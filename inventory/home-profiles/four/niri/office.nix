{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Typst
    typst

    # Development and formatting tools
    typstyle # formatter
    typst-live # hot reloading during development
    typstwriter # editor

    # Useful Typst packages for document creation
    typstPackages.cetz # drawing and diagrams
    typstPackages.algo # algorithm typesetting
    typstPackages.tbl # advanced table layouts
    typstPackages.unify # number and unit formatting
    typstPackages.ilm # versatile document layout
    typstPackages.may # simple document layout

    # Misc
    libreoffice # office suite
    tradingview # market analysis
  ];

  # Setup file associations for Typst files
  xdg.mimeApps.defaultApplications = {
    "text/x-typst" = "typstwriter.desktop";
  };
}
