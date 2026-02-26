{ inputs, pkgs, ... }:
{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  # Enable bluetooth
  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez-experimental;
    powerOnBoot = true;
    settings.General.Experimental = true;
  };

  # Display manager
  programs = {
    silentSDDM = {
      enable = true;
      theme = "rei";
    };
  };

  # Enable plymouth
  boot = {
    plymouth.enable = true;
    initrd.systemd.enable = true;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "systemd.show_status=auto"
    ];
  };

  # High-performance D-Bus implementation (default on Arch/Fedora)
  services.dbus.implementation = "broker";

  services = {
    libinput.enable = true;
    printing.enable = true;
  };

  environment.systemPackages = with pkgs; [
    acpi
    bluetui
    desktop-file-utils
    libnotify
    powertop
    shared-mime-info
    xdg-utils
  ];
}
