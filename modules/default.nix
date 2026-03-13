_:
let
  module_definitions = {
    "tailscale" = import ./tailscale;
    # "vaultwarden" = import ./vaultwarden;
    "roster" = import ./roster;
  };
in
module_definitions
