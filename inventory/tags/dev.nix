{ pkgs, ... }:
{
  programs.direnv.enable = true;
  environment.systemPackages = with pkgs; [
    bind
    comma
    dig
    ethtool
    gh
    lsof
    nixpkgs-review
    net-tools
    nmap
    socat
  ];
}
