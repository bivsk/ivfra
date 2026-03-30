{ inputs, pkgs, ... }:
{
  imports = [ inputs.silentSDDM.nixosModules.default ];

  # Plymouth boot logo
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

  environment.systemPackages = with pkgs; [
    acpi
    bluetui
    desktop-file-utils
    libnotify
    powertop
    shared-mime-info
    xdg-utils
  ];

  # Bluetooth
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

  services = {
    # High-performance D-Bus implementation (default on Arch/Fedora)
    dbus.implementation = "broker";

    fwupd.enable = true;
    libinput.enable = true;
    printing.enable = true;

    mullvad-vpn = {
      enable = true;
      package = pkgs.mullvad-vpn;
    };

    # Caps Lock -> Esc on tap, Ctrl on hold
    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        settings.main.capslock = "overload(control, esc)";
      };
    };
  };

  security = {
    pam.services.login.enableGnomeKeyring = true;
  };

  # Provide a fallback portal
  # xdg.portal = {
  #   enable = true;
  #   configPackages = [ pkgs.xdg-desktop-portal-gtk ];
  # };
}
