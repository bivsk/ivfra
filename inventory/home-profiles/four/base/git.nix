{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "bivsk";
        email = "bivsk@tutanota.com";
      };
      init.defaultBranch = "master";
      pull.rebase = true;
      push.autoSetupRemote = true;
      core.editor = "nvim";

      aliases = {
        o = "checkout";
        c = "commit";
        cm = "commit --message";
        s = "status";
        b = "branch";
        h = "log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short";
        t = "cat-file -t"; # show type, not content
        d = "cat-file -p"; # pretty print
      };
    };

    ignores = [
      "*.swp"
      "*~"
      ".direnv"
      "result*"
    ];
  };

  programs = {
    delta = {
      enable = true;
      enableGitIntegration = true;
      options = {
        navigate = true;
        light = false;
        sideBySide = true;
        line-numbers = true;
      };
    };
  };
}
