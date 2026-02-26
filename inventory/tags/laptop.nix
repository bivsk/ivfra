{ pkgs, ... }:
{
  programs.light.enable = true;

  # Faster WiFi reconnection and better power management
  networking.networkmanager.wifi.backend = "iwd";

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;

    libinput.touchpad = {
      tapping = true;
      disableWhileTyping = true;
      naturalScrolling = true;
    };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
  ];
}
