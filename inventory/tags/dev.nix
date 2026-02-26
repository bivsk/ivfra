{ pkgs, ... }:
{
  programs.direnv.enable = true;
  environment.systemPackages = with pkgs; [
    bind
    claude-code
    comma
    dig
    ethtool
    gh
    lsof
    nixpkgs-review
    net-tools
    nix-output-monitor
    nmap
    socat
    traceroute
  ];
}
