{
  pkgs,
  ...
}:
{
  environment.systemPackages = [
    pkgs.jmtpfs
    pkgs.android-tools
  ];

  # TODO: make statix stop whining about this
  # users.extraGroups.adbusers.members =
  #   config.users.users |> filterAttrs (const <| getAttr "isNormalUser") |> attrNames;
}
