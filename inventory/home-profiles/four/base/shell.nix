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
    cat = "bat -pp"; # plain and no pager
    grep = "grep --color=auto";
    df = "df --human-readable";
    du = "du --human-readable";

    # General
    c = "clear";
    v = "validate";
    cmu = "clan machines update";
    cu = "clan machines update $hostname";
    cul = "clan machines update $hostname --target-host localhost";
  };

  programs.nushell = {
    enable = true;
  };

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "never";
        style = "numbers,changes,header";
      };
    };
  };

  home.packages = with pkgs; [
    eza
    fzf
    jq
  ];
}
