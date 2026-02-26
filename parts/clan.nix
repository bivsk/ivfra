{
  inputs,
  self,
  ...
}:
{
  flake =
    let
      # Import modules directly
      modules = import "${self}/modules/default.nix" { inherit inputs; };

      # Build clan
      clanModule = inputs.clan-core.lib.clan {
        meta.name = "IVfra";

        inherit self;
        inherit modules;
        specialArgs = {
          inherit inputs;
          wrappers = inputs.wrappers.wrapperModules;
        };

        inventory = import "${self}/inventory" { inherit inputs; };
      };
    in
    {
      # Expose clan outputs
      inherit (clanModule.config) nixosConfigurations clanInternals;
      clan = clanModule.config;
    };
}
