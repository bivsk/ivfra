{ pkgs, ... }:
{
  home.packages = [
    pkgs.android-tools
    pkgs.jmtpfs
  ];

  # TODO: make statix stop whining about this
  # users.extraGroups.adbusers.members =
  #   config.users.users |> filterAttrs (const <| getAttr "isNormalUser") |> attrNames;
}
