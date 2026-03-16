_: {
  networking = {
    hostName = "baratie";
    fqdn = "bivsk.net";

    firewall.allowedTCPPorts = [
      80
      443
    ];
  };
}
