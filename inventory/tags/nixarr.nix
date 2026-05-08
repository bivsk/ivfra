{
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.nixarr.nixosModules.default ];

  clan.core.vars.generators."nixarr" = {
    prompts."wg.conf" = {
      description = "WireGuard configuration to be used by Nixarr";
      persist = true;
      type = "multiline-hidden";
    };
  };

  nixarr = rec {
    enable = true;
    mediaDir = "/media/nixarr";
    stateDir = "${mediaDir}/.state";

    # modules
    bazarr.enable = true;
    jellyfin = {
      enable = true;
      openFirewall = true;
    };
    seerr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr.enable = true;
    radarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
    };
    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 58420;
    };

    vpn = {
      enable = true;
      wgConf = config.clan.core.vars.generators.nixarr.files."wg.conf".path;
      vpnTestService.enable = true;
      accessibleFrom = [ "10.0.0.0/24" ];
    };
  };
}
