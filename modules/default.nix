_:
let
  module_definitions = {
    "home-manager-profiles" = import ./home-manager-profiles;
    "ollama" = import ./ollama;
    "tailscale" = import ./tailscale;
    "vaultwarden" = import ./vaultwarden;
  };
in
module_definitions
