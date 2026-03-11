{ pkgs, ... }:
{
  home.shellAliases = {
    # Safety nets
    cp = "cp -ir";
    mv = "mv -i";
    rm = "rm -i";

    # Navigation
    ".." = "cd ..";
    "..." = "cd ../..";
    "...." = "cd ../../..";

    # Git
    g = "git";
    gs = "git status";
    ga = "git add";
    gaa = "git add --all";
    gc = "git commit";
    gcm = "git commit --message";
    gll = "git pull";
    gp = "git push";
    gl = "git log --oneline --graph";

    # Wrap better defaults
    grep = "grep --color=auto";

    # TODO: not compatible with nushell
    # df = "df --human-readable";
    # du = "du --human-readable";

    # General
    c = "clear";
    v = "validate";
    cmu = "clan machines update";
    # cu = "clan machines update $hostname";
    # cul = "clan machines update $hostname --target-host localhost";
  };

  # Enable Nushell
  programs.nushell = {
    enable = true;
  };

  # Misc. shell programs
  programs = {
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide = {
      enable = true;
      enableNushellIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };

  home.packages = with pkgs; [
    eza
    fastfetch
    fzf
    jq
  ];
}
