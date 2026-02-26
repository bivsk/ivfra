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
    };

    ignores = [
      "*.swp"
      "*~"
      ".direnv"
      "result*"
    ];

    programs.delta = {
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
