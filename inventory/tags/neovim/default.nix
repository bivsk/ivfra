{
  self,
  config,
  pkgs,
  ...
}:
let
  defaultNixvim = self.packages.${pkgs.stdenv.hostPlatform.system}.nvim;
  nixvimPkg = defaultNixvim.extend {
    # find clan managed api keys
    plugins.avante.settings = {
      providers.claude.api_key_name = "cmd: cat ${config.clan.core.vars.generators.avante.files.anthropic.path}";
    };
  };
in
{
  # API keys
  clan.core.vars.generators.avante = {
    share = true;
    files.anthropic = {
      owner = "four";
      group = "four";
    };
    prompts.anthropic = {
      description = "Anthropic API key to be used with avante.nvim";
      persist = true;
      type = "hidden";
    };
  };
  environment.systemPackages = [ nixvimPkg ];

}
