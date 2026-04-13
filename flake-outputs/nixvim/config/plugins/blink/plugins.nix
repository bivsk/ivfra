{ config, ... }:
let
  mkBlinkPlugin =
    {
      enable ? true,
      ...
    }@args:
    {
      inherit enable;
      lazyLoad.settings.event = [
        "InsertEnter"
        "CmdlineEnter"
      ];
    }
    // (removeAttrs args [ "enable" ]);
in
{
  plugins = {
    blink-cmp-avante = mkBlinkPlugin {
      inherit (config.plugins.avante) enable;
    };
    # blink-cmp-dictionary = mkBlinkPlugin { };
    blink-cmp-git = mkBlinkPlugin { };
    blink-cmp-spell = mkBlinkPlugin { };
    blink-cmp-words = mkBlinkPlugin { };
    blink-copilot = mkBlinkPlugin { };
    blink-emoji = mkBlinkPlugin { };
    blink-ripgrep = mkBlinkPlugin { };
  };
}
