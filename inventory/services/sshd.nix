_: {
  instances = {
    sshd = {
      module.name = "sshd";
      roles.server.tags.all = { };
      roles.client.tags.all = { };
    };
  };
}
