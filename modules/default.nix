_:
let
  module_definitions = {
    "home-manager-profiles" = import ./home-manager-profiles;
    "tailscale" = import ./tailscale;
    # "vaultwarden" = import ./vaultwarden;
  };
in
module_definitions
