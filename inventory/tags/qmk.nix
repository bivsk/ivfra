{ pkgs, ... }:

{
  hardware.keyboard.qmk.enable = true;
  services.udev.extraRules = ''
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="2e8a", ATTRS{idProduct}=="0003", , MODE:="0666", GROUP="plugdev"
  '';

  environment.systemPackages = [
    pkgs.qmk
    pkgs.qmk_hid
    pkgs.vial
  ];
}
