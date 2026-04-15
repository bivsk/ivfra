_: {
  instances = {
    vaultwarden = {
      module.name = "vaultwarden";
      module.input = "self";
      roles = {
        client.tags.desktop = { };
        proxy.machines.baratie = { };
        server.machines.yuda = {
          settings = {
            domain = "vault.bivsk.com";
          };
        };
      };
    };
  };
}
