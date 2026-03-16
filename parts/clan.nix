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
        inherit self modules;
        meta.name = "IVfra";

        inventory = import "${self}/inventory" { inherit inputs; };

        secrets.age.plugins = [
          "age-plugin-yubikey"
        ];
        specialArgs = {
          inherit inputs;
          wrappers = inputs.wrappers.wrapperModules;
        };
      };
    in
    {
      # Expose clan outputs
      inherit (clanModule.config) nixosConfigurations clanInternals;
      clan = clanModule.config;
    };
}
