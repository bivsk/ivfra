_: {
  instances = {
    ollama = {
      module.name = "ollama";
      module.input = "self";
      roles.default.machines.sunny.settings = {
        host = "0.0.0.0";
        models = [ "qwen3.5:9b" ];
      };
    };
  };
}
