{
  description = "VaultWarden password manager server";
  interface =
    { lib, ... }:
    let
      inherit (lib) types;
    in
    {
      options = {
        allowSignups = lib.mkOption {
          type = types.bool;
          default = false;
          description = "Allow signups for new users";
        };
        extraConfig = lib.mkOption {
          type = types.attrsOf (
            types.nullOr (
              types.oneOf [
                types.bool
                types.int
                types.str
              ]
            )
          );
          default = { };
          description = "Additional configuration to be merged with services.vaultwarden.config";
        };
        domain = lib.mkOption {
          type = types.nullOr types.str;
          example = "vault.example.com";
          description = "The domain under which VaultWarden will be reachable";
        };
        environmentFile = lib.mkOption {
          type = types.coercedTo types.path lib.singleton (types.listOf types.path);
          example = "/var/lib/vaultwarden.env";
          description = "Additional environment file or files";
        };
        port = lib.mkOption {
          type = types.int;
          default = 8222;
          description = "The port to use for VaultWarden";
        };
      };
    };

  perInstance =
    {
      instanceName,
      mkExports,
      settings,
      lib,
      ...
    }:
    {
      exports = mkExports {
        endpoints.hosts = lib.singleton "yuda:${toString settings.port}";
      };

      nixosModule =
        {
          config,
          lib,
          pkgs,
          ...
        }:
        {
          clan.core = {
            # Create pg database and manage backups
            postgresql = {
              enable = true;
              users.vaultwarden = { };
              databases.vaultwarden = {
                create.options = {
                  TEMPLATE = "template0";
                  LC_COLLATE = "C";
                  LC_CTYPE = "C";
                  ENCODING = "UTF8";
                  OWNER = "vaultwarden";
                };
                restore.stopOnRestore = [ "vaultwarden" ];
              };
            };

            state.vaultwarden = {
              folders = [ "/var/lib/vaultwarden" ];
              preBackupScript = ''
                export PATH=${
                  lib.makeBinPath [
                    config.systemd.package
                  ]
                }

                systemctl stop vaultwarden.service
              '';

              postRestoreScript = ''
                export PATH=${
                  lib.makeBinPath [
                    config.systemd.package
                  ]
                }

                systemctl start vaultwarden.service
              '';
            };

            # Instance-specific admin token generator
            vars.generators."vaultwarden-${instanceName}-admin" = {
              files."admin-password" = { };
              files."admin-hash" = { };
              runtimeInputs = [
                pkgs.coreutils
                pkgs.libargon2
                pkgs.openssl
                pkgs.pwgen
              ];
              script = ''
                ADMIN_PASS=$(pwgen 16 -n1 | tr -d "\n")
                ADMIN_HASH=$(echo -n "$ADMIN_PASS" | argon2 "$(openssl rand -base64 32)" -e -id -k 65540 -t 3 -p 4)

                config="
                ADMIN_TOKEN=\"$ADMIN_HASH\"
                "
                echo -n "$ADMIN_PASS" > "$out"/admin-password
                echo -n "$config" > "$out"/admin-hash
              '';
            };
          };

          # Main Vaultwarden service
          services.vaultwarden = {
            enable = true;
            inherit (settings) domain;
            dbBackend = "postgresql";
            environmentFile =
              config.clan.core.vars.generators."vaultwarden-${instanceName}-admin".files.admin-hash.path
              |> lib.singleton
              |> (base: base ++ lib.optionals (settings ? environmentFile) settings.environmentFile); # yubikeys, etc.
            config = {
              ROCKET_PORT = toString settings.port;
              SIGNUPS_ALLOWED = settings.allowSignups;
              # SMTP_SECURITY = "force_tls";
              # SMTP_HOST =
              # SMTP_FROM =
              # SMTP_USERNAME =

              DATABASE_URL = "postgresql://"; # should be default upstream if dbBackend = pg
              INVITATIONS_ALLOWED = true;
              ROCKET_ADDRESS = "100.122.28.104"; # TODO: shouldn't hard code this
              SHOW_PASSWORD_HINT = false;
              WEBSOCKET_ENABLED = true;
            }
            // settings.extraConfig;
          };

          # Open port in firewall
          networking.firewall.allowedTCPPorts = lib.singleton settings.port;
        };
    };
}
