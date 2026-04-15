{
  description = "VaultWarden client";
  perInstance = {
    nixosModule =
      { pkgs, ... }:
      {
        environment.systemPackages = [ pkgs.bitwarden-desktop ];
      };
  };
}
