{
  lib,
  pkgs,
  ...
}:
{
  programs.niri = {
    settings = {
      hotkey-overlay.skip-at-startup = true;
      clipboard.disable-primary = true;
      prefer-no-csd = true;
      screenshot-path = "~/pictures/screenshots/%Y-%m-%dT%H:%M:%S.png";
      xwayland-satellite.path = "${lib.getExe pkgs.xwayland-satellite-unstable}";

      input.keyboard = {
        numlock = true;
        repeat-delay = 400;
        repeat-rate = 30;
      };

      binds = {
        "Mod+Shift+Return".action.spawn = "footclient";
        "Mod+Space".action.spawn = "fuzzel";
        "Mod+Shift+Slash".action.show-hotkey-overlay = [ ];

        # Core
        "Ctrl+Alt+Delete".action.quit = [ ];
        # TODO: make a fn
        "Mod+1".action.focus-workspace = 1;
        "Mod+2".action.focus-workspace = 2;
        "Mod+3".action.focus-workspace = 3;
        "Mod+4".action.focus-workspace = 4;
        "Mod+5".action.focus-workspace = 5;
        "Mod+6".action.focus-workspace = 6;
        "Mod+7".action.focus-workspace = 7;
        "Mod+8".action.focus-workspace = 8;
        "Mod+9".action.focus-workspace = 9;
        # TODO: see if move-window-to-workspace is better
        "Mod+Ctrl+1".action.move-column-to-workspace = 1;
        "Mod+Ctrl+2".action.move-column-to-workspace = 2;
        "Mod+Ctrl+3".action.move-column-to-workspace = 3;
        "Mod+Ctrl+4".action.move-column-to-workspace = 4;
        "Mod+Ctrl+5".action.move-column-to-workspace = 5;
        "Mod+Ctrl+6".action.move-column-to-workspace = 6;
        "Mod+Ctrl+7".action.move-column-to-workspace = 7;
        "Mod+Ctrl+8".action.move-column-to-workspace = 8;
        "Mod+Ctrl+9".action.move-column-to-workspace = 9;

        "Mod+BracketLeft".action.consume-or-expel-window-left = [ ];
        "Mod+BracketRight".action.consume-or-expel-window-right = [ ];
        "Mod+Comma".action.consume-window-into-column = [ ];
        "Mod+Period".action.expel-window-from-column = [ ];

        "Mod+R".action.switch-preset-column-width = [ ];
        "Mod+F".action.maximize-column = [ ];
        "Mod+Shift+F".action.fullscreen-window = [ ];
        "Mod+M".action.maximize-window-to-edges = [ ];
        "Mod+C".action.center-column = [ ];
        "Mod+Ctrl+C".action.center-visible-columns = [ ]; # ?
        "Mod+V".action.toggle-window-floating = [ ];
        "Mod+Shift+V".action.switch-focus-between-floating-and-tiling = [ ];
        "Mod+W".action.toggle-column-tabbed-display = [ ];

        "Mod+Shift+C".action.close-window = [ ]; # TODO: repeat=false
        "Mod+O".action.toggle-overview = [ ]; # TODO: repeat=false
        "Mod+H".action.focus-column-left = [ ];
        "Mod+J".action.focus-window-down = [ ];
        "Mod+K".action.focus-window-up = [ ];
        "Mod+L".action.focus-column-right = [ ];
        "Mod+Ctrl+H".action.move-column-left = [ ];
        "Mod+Ctrl+J".action.move-window-down = [ ];
        "Mod+Ctrl+K".action.move-window-up = [ ];
        "Mod+Ctrl+L".action.move-column-right = [ ];
        "Mod+A".action.focus-column-first = [ ];
        "Mod+E".action.focus-column-last = [ ];
        "Mod+Shift+A".action.move-column-to-first = [ ];
        "Mod+Shift+E".action.move-column-to-last = [ ];
        "Mod+U".action.focus-workspace-up = [ ];
        "Mod+D".action.focus-workspace-down = [ ];
        "Mod+Ctrl+U".action.move-column-to-workspace-up = [ ];
        "Mod+Ctrl+D".action.move-column-to-workspace-down = [ ];
        "Mod+Shift+U".action.move-workspace-up = [ ];
        "Mod+Shift+D".action.move-workspace-down = [ ];

        # Mouse
        # TODO: add cooldown-ms to rate-limit
        "Mod+WheelScrollDown".action.focus-workspace-down = [ ];
        "Mod+WheelScrollUp".action.focus-workspace-up = [ ];
        "Mod+Ctrl+WheelScrollDown".action.move-column-to-workspace-down = [ ];
        "Mod+Ctrl+WheelScrollUp".action.move-column-to-workspace-up = [ ];
        # TODO: END
        "Mod+WheelScrollRight".action.focus-column-right = [ ];
        "Mod+WheelScrollLeft".action.focus-column-left = [ ];
        "Mod+Ctrl+WheelScrollRight".action.move-column-right = [ ];
        "Mod+Ctrl+WheelScrollLeft".action.move-column-left = [ ];
        # Emulate horizontal scrolling
        "Mod+Shift+WheelScrollDown".action.focus-column-right = [ ];
        "Mod+Shift+WheelScrollUp".action.focus-column-left = [ ];
        "Mod+Ctrl+Shift+WheelScrollDown".action.move-column-right = [ ];
        "Mod+Ctrl+Shift+WheelScrollUp".action.move-column-left = [ ];

        # TODO: inhibiting

        # Volume
        # TODO: allow when locked
        "XF86AudioRaiseVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
        "XF86AudioLowerVolume".action.spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        "XF86AudioMute".action.spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

        # Backlight
        # TODO: allow when locked
        "XF86MonBrightnessUp".action.spawn-sh = "brightnessctl set +10%";
        "XF86MonBrightnessDown".action.spawn-sh = "brightnessctl set 10%-";

        # Media
        # TODO: allow when locked
        "XF86AudioPlay".action.spawn-sh = "playerctl play-pause";
        "XF86AudioStop".action.spawn-sh = "playerctl stop";
        "XF86AudioPrev".action.spawn-sh = "playerctl previous";
        "XF86AudioNext".action.spawn-sh = "playerctl next";

        # Screenshots
        "Mod+Print".action.screenshot = [ ];
        "Print".action.screenshot-screen = [ ];
        "Alt+Print".action.screenshot-window = [ ];
      };
    };
  };
}
