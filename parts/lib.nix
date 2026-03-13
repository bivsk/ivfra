# Shared library utilities for ivfra
# Provides common functions and helpers used across the flake
{ inputs, ... }:
{
  flake.lib = {
    # Machine configuration helpers
    machines = {
      # Get all machine names from clan configuration
      names = builtins.attrNames (import ../inventory/core/machines.nix { });

      # Check if a machine has a specific tag
      hasTag =
        machine: tag:
        let
          machines = import ../inventory/core/machines.nix { };
        in
        builtins.elem tag (machines.${machine}.tags or [ ]);
    };

    # Tag utilities
    tags = {
      # Get all available tags
      all =
        let
          tagDir = ../inventory/tags;
          contents = builtins.readDir tagDir;
          nixFiles = builtins.filter (name: builtins.match ".*\\.nix" name != null && name != "default.nix") (
            builtins.attrNames contents
          );
        in
        map (name: builtins.replaceStrings [ ".nix" ] [ "" ] name) nixFiles;
    };

    # User/roster utilities
    users = {
      names = [ "four" ];
    };

    # Flake input passthrough for downstream use
    inherit inputs;
  };
}
