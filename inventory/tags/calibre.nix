# TODO: maybe move to clan service
let
  calibreDir = "/media/nixarr/library/books/.calibre";
  port = 4545;
in
{
  services.calibre-server = {
    enable = true;
    port = port;
    auth = {
      enable = true;
      # TODO: make this better
      mode = "basic";
      userDb = "${calibreDir}/users.sqlite";
    };
    libraries = [ calibreDir ];
  };

  networking.firewall.allowedTCPPorts = [ port ];
}
