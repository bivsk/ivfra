{ pkgs, ... }:
{
  # Enable hardware wallets
  hardware.ledger.enable = true;
  services.trezord.enable = true;

  # Install wallets
  home-manager.sharedModules = [
    {
      home.packages = with pkgs; [
        ledger-live-desktop
        monero-cli
        trezor-suite
      ];
    }
  ];
}
