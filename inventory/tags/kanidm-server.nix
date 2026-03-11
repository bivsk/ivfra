{ pkgs, ... }:
{
  services.kanidm = {
    package = pkgs.kanidm_1_9;
    enableServer = true;
  };
}
