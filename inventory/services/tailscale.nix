_: {
  instances = {

    "tailnet" = {
      module.name = "tailscale";
      module.input = "self";
      roles.peer = {
        tags."tailnet-bivsk" = { };
        settings = {
          enableSSH = true;
          exitNode = false;
          enableHostAliases = true;
        };
      };
    };

  };
}
