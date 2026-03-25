{
  inputs,
  lib,
  pkgs,
  ...
}:
let
  wrappedNiri =
    (inputs.wrappers.wrapperModules.niri.apply {
      inherit pkgs;
      settings = {
        hotkey-overlay.skip-at-startup = true;
        clipboard.disable-primary = true;
        prefer-no-csd = true;
        screenshot-path = "~/pictures/screenshots/%Y-%m-%dT%H:%M:%S.png";
        xwayland-satellite.path = "${lib.getExe pkgs.xwayland-satellite-unstable}";

        input = {
          keyboard = {
            numlock = true;
            repeat-delay = 400;
            repeat-rate = 30;
          };
          touchpad = {
            tap = [ ];
            natural-scroll = [ ];
            # middle-emulation = [ ];
          };
        };

        overview.zoom = 0.7;

        layout = {
          empty-workspace-above-first = [ ];
        };

        spawn-at-startup = [
          "noctalia-shell"
          "${pkgs.polkit_gnome}/bin/polkit-gnome-authentication-agent-1"
          "${pkgs.networkmanagerapplet}/bin/nm-applet"
          "${pkgs.blueman}/bin/blueman-applet"
          [
            "${pkgs.wl-clipboard}/bin/wl-paste"
            "--watch"
            "${pkgs.cliphist}/bin/cliphist"
            "store"
          ]
        ];

        window-rules = [
          # rounded corners for all windows
          {
            geometry-corner-radius = 12;
            clip-to-geometry = true;
          }
        ];

        binds =
          {
            "Mod+Shift+Return".spawn = "footclient";
            "Mod+Space".spawn = "fuzzel";
            "Mod+Shift+Slash".show-hotkey-overlay = [ ];
            "Ctrl+Alt+Delete".quit = [ ];

            "Mod+BracketLeft".consume-or-expel-window-left = [ ];
            "Mod+BracketRight".consume-or-expel-window-right = [ ];
            "Mod+Comma".consume-window-into-column = [ ];
            "Mod+Period".expel-window-from-column = [ ];

            "Mod+R".switch-preset-column-width = [ ];
            "Mod+F".maximize-column = [ ];
            "Mod+Shift+F".fullscreen-window = [ ];
            "Mod+M".maximize-window-to-edges = [ ];
            "Mod+C".center-column = [ ];
            "Mod+Ctrl+C".center-visible-columns = [ ]; # ?
            "Mod+V".toggle-window-floating = [ ];
            "Mod+Shift+V".switch-focus-between-floating-and-tiling = [ ];
            "Mod+W".toggle-column-tabbed-display = [ ];

            "Mod+Shift+C" = {
              close-window = [ ];
              _attrs = {
                repeat = false;
              };
            };
            "Mod+O" = {
              toggle-overview = [ ];
              _attrs = {
                repeat = false;
              };
            };

            "Mod+H".focus-column-left = [ ];
            "Mod+L".focus-column-right = [ ];
            "Mod+Ctrl+H".move-column-left = [ ];
            "Mod+Ctrl+L".move-column-right = [ ];
            "Mod+A".focus-column-first = [ ];
            "Mod+E".focus-column-last = [ ];
            "Mod+Shift+A".move-column-to-first = [ ];
            "Mod+Shift+E".move-column-to-last = [ ];
            "Mod+K".focus-workspace-up = [ ];
            "Mod+J".focus-workspace-down = [ ];
            "Mod+Ctrl+K".move-column-to-workspace-up = [ ];
            "Mod+Ctrl+J".move-column-to-workspace-down = [ ];
            "Mod+Shift+K".move-workspace-up = [ ];
            "Mod+Shift+J".move-workspace-down = [ ];

            # Mouse
            # TODO: add cooldown-ms to rate-limit
            "Mod+WheelScrollDown".focus-workspace-down = [ ];
            "Mod+WheelScrollUp".focus-workspace-up = [ ];
            "Mod+Ctrl+WheelScrollDown".move-column-to-workspace-down = [ ];
            "Mod+Ctrl+WheelScrollUp".move-column-to-workspace-up = [ ];
            # TODO: END
            "Mod+WheelScrollRight".focus-column-right = [ ];
            "Mod+WheelScrollLeft".focus-column-left = [ ];
            "Mod+Ctrl+WheelScrollRight".move-column-right = [ ];
            "Mod+Ctrl+WheelScrollLeft".move-column-left = [ ];
            # Emulate horizontal scrolling
            "Mod+Shift+WheelScrollDown".focus-column-right = [ ];
            "Mod+Shift+WheelScrollUp".focus-column-left = [ ];
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = [ ];
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = [ ];

            # TODO: inhibiting

            # Volume
            # TODO: allow when locked
            "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
            "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

            # Backlight
            # TODO: allow when locked
            "XF86MonBrightnessUp".spawn-sh = "brightnessctl set +10%";
            "XF86MonBrightnessDown".spawn-sh = "brightnessctl set 10%-";

            # Media
            # TODO: allow when locked
            "XF86AudioPlay".spawn-sh = "playerctl play-pause";
            "XF86AudioStop".spawn-sh = "playerctl stop";
            "XF86AudioPrev".spawn-sh = "playerctl previous";
            "XF86AudioNext".spawn-sh = "playerctl next";

            # Screenshots
            "Mod+Print".screenshot = [ ];
            "Print".screenshot-screen = [ ];
            "Alt+Print".screenshot-window = [ ];
          }
          # MOD+N = focus-workspace N, MOD+Ctrl+N = move-column-to-workspace N
          |> (
            base:
            let
              config = [
                {
                  mod = "";
                  action = "focus-workspace";
                }
                {
                  mod = "Ctrl+";
                  action = "move-column-to-workspace";
                }
              ];
              makeAttrs =
                cfg:
                lib.range 1 9
                |> map (n: {
                  name = "Mod+${cfg.mod}${toString n}";
                  value = {
                    "${cfg.action}" = n;
                  };
                })
                |> builtins.listToAttrs;
            in
            base // (builtins.foldl' (acc: cfg: acc // makeAttrs cfg) { } config)
          );
      };
    }).wrapper;
in
{
  home.packages = [
    wrappedNiri
    pkgs.xdg-desktop-portal-gtk
    pkgs.xdg-desktop-portal-gnome
    pkgs.nautilus
    pkgs.waypipe
  ];

  # Override the niri service to use the wrapped niri binary
  systemd.user.services.niri = {
    Unit = {
      Description = "A scrollable-tiling Wayland compositor";
      BindsTo = "graphical-session.target";
      Before = "graphical-session.target";
      Wants = [
        "graphical-session-pre.target"
        "xdg-desktop-autostart.target"
      ];
      After = "graphical-session-pre.target";
      # Prevent restarting the service on configuration changes
      X-RestartIfChanged = false;
      X-StopIfChanged = false;
    };
    Service = {
      Slice = "session.slice";
      Type = "notify";
      ExecStart = "${wrappedNiri}/bin/niri --session";
    };
  };

  # XDG portals
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "gtk" ];
        "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      };
      niri = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      };
    };
  };

  # Prefer dark mode for portal UI settings
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = lib.mkDefault "prefer-dark";
    };
  };
}
