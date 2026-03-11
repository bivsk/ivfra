{ inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
  ];

  networking.hostName = "merry";

  programs.silentSDDM.settings = {
    "General".scale = "2.0";
  };

  services = {
    fprintd.enable = true;

    logind.settings.Login.HandlePowerKey = "lock"; # default is poweroff
  };

  security = {
    pam.services = {
      sudo.fprintAuth = true;

      # Disable fingerprint authentification for SDDM
      # If enabled, both password AND fingerprints are required
      login.fprintAuth = false;
    };
  };
}
