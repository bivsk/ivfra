_: {
  # using gnome-keyring
  services.ssh-agent.enable = false;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    extraConfig = "";

    matchBlocks = {
      "*" = {
        addKeysToAgent = "yes";
        compression = true;
        forwardAgent = true;
      };
    };
  };
}
