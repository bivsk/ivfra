{
  lib,
  pkgs,
  ...
}:
{
  # nixd documentation
  # See: https://github.com/nix-community/nixd
  lsp.servers.nixd = {
    enable = true;

    config.settings.nixd = {
      formatting = {
        command = [ "${lib.meta.getExe pkgs.nixfmt}" ];
      };
    };
  };
}
