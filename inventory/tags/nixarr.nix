{
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.nixarr.nixosModules.default ];

  # TODO: move this later
  security.acme = {
    acceptTerms = true;
    defaults.email = "bivsk@tutanota.com";
  };

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
    jellyseerr = {
      enable = true;
      openFirewall = true;
    };
    prowlarr.enable = true;
    radarr = {
      enable = true;
      openFirewall = true;
    };
    readarr.enable = true;
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

  # Proxies
  services.nginx = {
    enable = true;
    clientMaxBodySize = "20M"; # TODO: only jellyfin
    recommendedProxySettings = true;

    virtualHosts = {
      # jellyfin
      "watch.bivsk.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://10.0.0.2:8096";
          extraConfig = ''
            proxy_buffering off;
          '';
        };
        locations."/socket" = {
          proxyPass = "http://10.0.0.2:8096";
          proxyWebsockets = true;
        };
      };

      # jellyseerr
      "jellyseerr.bivsk.com" = {
        forceSSL = true;
        enableACME = true;
        extraConfig = ''
          proxy_set_header Referer $http_referer;
          proxy_set_header X-Real-Port $remote_port;
          proxy_set_header X-Forwarded-Ssl on;
        '';
        locations."/" = {
          proxyPass = "http://10.0.0.2:5055";
        };
      };

      # radarr
      "radarr.bivsk.com" = {
        forceSSL = true;
        enableACME = true;
        extraConfig = ''
          proxy_set_header Referer $http_referer;
          proxy_set_header X-Real-Port $remote_port;
          proxy_set_header X-Forwarded-Ssl on;
        '';
        locations."/" = {
          proxyPass = "http://10.0.0.2:7878";
        };
      };

      # sonarr
      "sonarr.bivsk.com" = {
        forceSSL = true;
        enableACME = true;
        extraConfig = ''
          proxy_set_header Referer $http_referer;
          proxy_set_header X-Real-Port $remote_port;
          proxy_set_header X-Forwarded-Ssl on;
        '';
        locations."/" = {
          proxyPass = "http://10.0.0.2:8989";
        };
      };
    };
  };
}
