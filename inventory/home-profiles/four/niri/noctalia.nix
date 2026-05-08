{ inputs, ... }:
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    settings = {
      general = {
        allowPasswordWithFprintd = true;
        # avatarImage = "";
        showChangelogOnStartup = false;
        telemetryEnabled = false;
      };
      location = {
        autoLocate = true;
        useFahrenheit = true;
      };
      appLauncher = {
        showCategories = false;
        terminalCommand = "footclient";
        enableClipPreview = true;
        enableClipboardChips = true;
        enableClipboardHistory = true;
        enableClipboardSmartIcons = true;
      };
      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = true;
        forced = false;
        nightTemp = "3000";
      };
      plugins = {
        autoUpdate = true;
        notifyUpdates = true;
      };
      idle = {
        enabled = true;
        fadeDuration = 5;
        lockTimeout = 1200;
        screenOffTimeout = 600;
        suspendTimeout = 1800;
      };
      bar = {
        density = "compact";
        mouseWheelAction = "workspace";
        mouseWheelWrap = false;
        rightClickAction = "controlCenter";
        rightClickFollowMouse = true;
        position = "left";
        showCapsule = false;
        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            {
              defaultSettings = {
                autoStartBreaks = true;
                autoStartWork = true;
                longBreakDuration = 15;
                sessionsBeforeLongBreak = 4;
                shortBreakDuration = 5;
                workDuration = 25;
              };
              id = "plugin:pomodoro";
            }
          ];
          center = [
            {
              hideUnoccupied = false;
              id = "Workspace";
              labelMode = "none";
            }
          ];
          right = [
            {
              defaultSettings = {
                compactMode = false;
                defaultPeerAction = "copy-id";
                hideDisconnected = false;
                hideMullvadExitNodes = false;
                # loginServer = "";
                pingCount = 5;
                refreshInterval = 15000;
                showIpAddress = true;
                showPeerCount = true;
                sshUsername = "four"; # TODO: use a var?
                taildropDownloadDir = "~/Downloads";
                taildropEnabled = true;
              };
              id = "plugin:tailscale";
            }
            {
              id = "Bluetooth";
            }
            {
              id = "Network";
            }
            {
              alwaysShowPercentage = false;
              id = "Battery";
              warningThreshold = 30;
            }
            {
              formatVertical = "HH mm";
              id = "Clock";
              useMonospacedFont = true;
              usePrimaryColor = true;
            }
          ];
        };
      };
    };
  };
}
