{ lib, ... }:
let
  inherit (builtins) readDir;
  inherit (lib.attrsets) foldlAttrs;
  inherit (lib.lists) optional;
  by-name = ./plugins;
in
{
  imports =
    (foldlAttrs (
      prev: name: type:
      prev ++ optional (type == "directory") (by-name + "/${name}")
    ) [ ] (readDir by-name))
    ++ [
      ./autocommands.nix
      ./dependencies.nix
      ./ft.nix
      ./keymap.nix
      ./lsp.nix
      ./lua.nix
      ./options.nix
    ];
}
