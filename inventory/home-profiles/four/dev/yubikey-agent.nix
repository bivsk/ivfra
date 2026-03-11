_: {
  services = {
    yubikey-agent.enable = true;
  };

  # Additional SSH configuration to use yubikey-agent
  programs.ssh = {
    extraConfig = ''
      # Use YubiKey for SSH authentication
      IdentityAgent ~/.cache/yubikey-agent/yubikey-agent.sock
    '';
  };
}
