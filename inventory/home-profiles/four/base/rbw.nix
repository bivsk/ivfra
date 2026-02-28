{ pkgs, ... }:
{
  programs.rbw = {
    enable = true;
    settings = {
      email = "bivsk@tutanota.com";
      lock_timeout = 3600; # 1hr
      #pinentry =
      base_url = "https://vault.bivsk.com";
    };
  };

  # Git credential helper integration
  programs.git.settings.credential.helper = "${pkgs.rbw}/bin/git-credential-rbw";
}
