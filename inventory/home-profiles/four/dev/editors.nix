{ lib, pkgs, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [ "nix" ];
    extraPackages = with pkgs; [
      nixd
      nil
      ruff
    ];

    mutableUserSettings = false;
    mutableUserKeymaps = false;
    mutableUserTasks = false;
    mutableUserDebug = false;

    userSettings = {
      auto_update = false;
      vim_mode = true;

      lsp = {
        nil.binary = {
          path = lib.getExe pkgs.nil;
        };
        nixd.binary = {
          path = lib.getExe pkgs.nixd;
        };
      };

      context_servers = {
        nixos = {
          command = "nix";
          args = [
            "run"
            "github:utensils/mcp-nixos"
            "--"
          ];
        };
      };
    };
  };
}
