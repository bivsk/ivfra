{ pkgs, ... }:
{
  # Enable hardware wallets
  hardware.ledger.enable = true;
  services.trezord.enable = true;

  # Install wallets
  environment.systemPackages = with pkgs; [
    ledger-live-desktop
    monero-cli
    trezor-suite
  ];
}
