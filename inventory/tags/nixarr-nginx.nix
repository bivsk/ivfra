{
  # TODO: move this later
  security.acme = {
    acceptTerms = true;
    defaults.email = "bivsk@tutanota.com";
  };

  # Proxies
  services.nginx = {
    enable = true;
    # clientMaxBodySize = "20M";
    recommendedProxySettings = true;

    virtualHosts = {
      # jellyfin
      "watch.bivsk.com" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://sunny:8096";
          extraConfig = ''
            proxy_buffering off;
            client_max_body_size 20M;
          '';
        };
        locations."/socket" = {
          proxyPass = "http://sunny:8096";
          proxyWebsockets = true;
        };
      };

      # seerr
      "seerr.bivsk.com" = {
        forceSSL = true;
        enableACME = true;
        extraConfig = ''
          proxy_set_header Referer $http_referer;
          proxy_set_header X-Real-Port $remote_port;
          proxy_set_header X-Forwarded-Ssl on;
        '';
        locations."/" = {
          proxyPass = "http://sunny:5055";
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
          proxyPass = "http://sunny:7878";
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
          proxyPass = "http://sunny:8989";
        };
      };
    };
  };
}
