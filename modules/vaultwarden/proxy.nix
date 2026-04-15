{ clanLib, ... }:
{
  description = "VaultWarden reverse proxy";
  perInstance =
    { exports, ... }:
    {
      nixosModule =
        { lib, ... }:
        let
          vwExports =
            clanLib.selectExports (scope: scope.serviceName == "vaultwarden") exports
            |> lib.attrValues
            |> builtins.head;
        in
        {
          services.nginx = {
            enable = true;
            upstreams.vaultwarden.servers."${builtins.head vwExports.endpoints.hosts}" = { };
            # TODO: fix
            virtualHosts."vault.bivsk.com" = {
              enableACME = true;
              forceSSL = true;
              extraConfig = ''
                client_max_body_size 128M;
              '';
              locations = {
                "/" = {
                  proxyPass = "http://vaultwarden";
                };
                "= /notifications/anonymous-hub" = {
                  proxyPass = "http://vaultwarden";
                  proxyWebsockets = true;
                };
                "= /notifications/hub" = {
                  proxyPass = "http://vaultwarden";
                  proxyWebsockets = true;
                };
              };
            };
          };
        };
    };
}
