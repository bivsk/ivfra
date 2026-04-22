{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    attrNames
    const
    filterAttrs
    getAttr
    ;

  inherit (config.home-manager.users.four) xdg;
in
{
  programs = {
    direnv.enable = true;

    nh = {
      enable = true;
      flake = "${xdg.userDirs.projects}/${config.clan.core.settings.name}";
    };
  };

  environment.systemPackages = [
    pkgs.bind
    pkgs.comma
    pkgs.dig
    pkgs.ethtool
    pkgs.gh
    pkgs.lsof
    pkgs.nixpkgs-review
    pkgs.net-tools
    pkgs.nmap
    pkgs.socat

    # android
    pkgs.android-tools
    pkgs.jmtpfs
  ];

  users.extraGroups.adbusers.members =
    config.users.users |> filterAttrs (const <| getAttr "isNormalUser") |> attrNames;
}
