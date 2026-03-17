{
  inputs,
  self,
}:
let
  modules = import "${self}/modules/default.nix" { inherit inputs; };

  clanModule = inputs.clan-core.lib.clan {
    inherit self modules;
    meta.name = "IVfra";
    inventory = import "${self}/inventory" { inherit inputs; };
    secrets.age.plugins = [ "age-plugin-yubikey" ];
    specialArgs = {
      inherit inputs;
      wrappers = inputs.wrappers.wrapperModules;
    };
  };
in
{
  inherit (clanModule.config)
    nixosConfigurations
    clanInternals
    ;
  clan = clanModule.config;

  lib = {
    machines = {
      names = builtins.attrNames (import ../inventory/core/machines.nix { });
      hasTag =
        machine: tag:
        let
          machinesDef = import ../inventory/core/machines.nix { };
        in
        builtins.elem tag (machinesDef.${machine}.tags or [ ]);
    };
    tags = {
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
    users.names = [ "four" ];
    inherit inputs;
  };
}
