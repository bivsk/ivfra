{
  pkgs,
  inputs',
  ...
}:
let
  inherit (pkgs.stdenv.hostPlatform) system;
  nixvimLib = inputs'.nixvim.lib;
  nixvimModule = {
    inherit system;
    module = import ./config;
  };
  nvim = inputs'.nixvim.makeNixvimWithModule nixvimModule;
in
{
  checks = {
    nixvim = nixvimLib.${system}.check.mkTestDerivationFromNixvimModule nixvimModule;
  };
  packages.nvim = nvim;
}
