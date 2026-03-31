{ inputs, ... }:
let
  inherit (inputs.nixpkgs) lib;

  services = {
    nix-caches = import ./nix-caches.nix { inherit inputs; };
    ollama = import ./ollama.nix { inherit inputs; };
    sshd = import ./sshd.nix { inherit inputs; };
    tailscale = import ./tailscale.nix { inherit inputs; };
    # vaultwarden = import ./vaultwarden.nix { inherit inputs; };
  };
in
lib.foldr lib.recursiveUpdate { } (lib.attrValues services)
