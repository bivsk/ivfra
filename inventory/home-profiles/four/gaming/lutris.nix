{ lib, pkgs, ... }:
let
  brokenVersion = "2.6.13";
  currentVersion = pkgs.openldap.version;
in
{
  programs.lutris = {
    enable = true;
    package =
      lib.throwIf (currentVersion != brokenVersion)
        ''
          Re-check whether disabling i686 tests is still required:
            https://github.com/NixOS/nixpkgs/issues/513245

          If upstream has not fixed, bump `brokenVersion` to ${currentVersion}.
          If fixed, revert to default lutris package with tests enabled.
        ''
        (
          pkgs.lutris.override {
            # Intercept buildFHSEnv to modify target packages
            buildFHSEnv =
              args:
              pkgs.buildFHSEnv (
                args
                // {
                  multiPkgs =
                    envPkgs:
                    let
                      # Fetch original package list
                      originalPkgs = args.multiPkgs envPkgs;

                      # Disable tests for openldap
                      customLdap = envPkgs.openldap.overrideAttrs (_: {
                        doCheck = false;
                      });
                    in
                    # Replace broken openldap with the custom one
                    builtins.filter (p: (p.pname or "") != "openldap") originalPkgs ++ [ customLdap ];
                }
              );
          }
        );

    extraPackages = [
      pkgs.gamemode
      pkgs.gamescope
      pkgs.mangohud
    ];

    winePackages = [
      pkgs.wineWow64Packages.staging
      pkgs.wineWow64Packages.waylandFull
      pkgs.winetricks
    ];

    protonPackages = [ pkgs.proton-ge-bin ];
  };
}
