{
  inputs',
  system,
  ...
}:
let
  nixvimLib = inputs'.nixvim.lib;
  nixvimModule = {
    pkgs = import inputs'.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    module = import ./config;
  };
  nvim = inputs'.nixvim.makeNixvimWithModule nixvimModule;
in
{
  checks = {
    nixvim = nixvimLib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;
  };
  nixvimModules.default = nixvimModule;
  packages.nvim = nvim;
}
