{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  # Search and file tools
  programs = {
    fd = {
      enable = true;
      hidden = true;
      ignores = [
        ".git/"
        ".cache/"
        "*.bak"
      ];
    };
    ripgrep = {
      enable = true;
      arguments = [
        "--line-number"
        "--smart-case"
      ];
    };
  };

  # Documentation
  programs = {
    # tldr
    tealdeer = {
      enable = true;
      settings = {
        display.compact = false;
        display.use_pager = true;
        updates.auto_update = true;
      };
    };
    info.enable = true;
  };

  # Nix search
  programs = {
    nix-search-tv.enable = true;
    television.enable = true;
  };

  # Lazygit
  programs.lazygit.enable = true;
  home.shellAliases = {
    lg = "lazygit";
  };

  home.packages =
    with pkgs;
    [
      # Files
      glow
      unzip

      # Nix
      deadnix
      dix
      nixos-generators
      nix-output-monitor
      nix-prefetch
      nix-search-tv

      # AI
      claude-code

      # Network
      traceroute
      wget

      # Code quality
      shellcheck
      ruff
      mypy

      # Misc.
      ast-grep
      gdb
      tokei
    ]
    ++ lib.singleton inputs.statix.packages.${pkgs.stdenv.hostPlatform.system}.default;
}
