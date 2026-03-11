{
  config,
  ...
}:
{
  clan.core.vars.generators."hercules-ci-agent" = {
    files.token = {
      owner = "hercules-ci-agent";
      group = "hercules-ci-agent";
      mode = "0400";
    };
    files."binaryCaches.json" = {
      owner = "hercules-ci-agent";
      group = "hercules-ci-agent";
      mode = "0400";
    };
    prompts.token = {
      description = "HerculesCI cluster join token";
      display = {
        group = "HerculesCI";
        helperText = "Generate a token from the HerculesCI dashboard.";
      };
      persist = true;
      type = "hidden";
    };
    prompts."binaryCaches.json" = {
      description = "HerculesCI binary cache configuration";
      display = {
        group = "HerculesCI";
        helperText = "See the HerculesCI dashboard for help generating a configuration.";
      };
      persist = true;
      type = "multiline-hidden";
    };
  };

  services.hercules-ci-agent = {
    enable = true;
    settings = {
      binaryCachesPath =
        config.clan.core.vars.generators.hercules-ci-agent.files."binaryCaches.json".path;
      clusterJoinTokenPath = config.clan.core.vars.generators.hercules-ci-agent.files.token.path;
    };
  };
}
