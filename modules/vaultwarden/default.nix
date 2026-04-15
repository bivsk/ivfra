{ clanLib, ... }:
{
  _class = "clan.service";
  manifest = {
    name = "vaultwarden";
    categories = [
      "Office"
      "Utility"
    ];
    readme = "VaultWarden password manager for secure credential storage";
    exports.out = [ "endpoints" ];
  };

  roles = {
    client = import ./client.nix;
    proxy = import ./proxy.nix { inherit clanLib; };
    server = import ./server.nix;
  };
}
