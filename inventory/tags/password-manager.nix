{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # YubiKey management tools
    yubikey-manager # CLI tool (ykman command)
    yubioath-flutter # GUI for YubiKey
    yubikey-personalization # Additional YubiKey tools
    yubico-pam # System login with YubiKey
  ];

  # Enable smart card daemon
  services.pcscd.enable = true;

  # Add udev rules for YubiKey (non-root access)
  services.udev.packages = [
    pkgs.yubikey-personalization
  ];
}
