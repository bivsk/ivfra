_:
let
  roster-users = {
    four = {
      description = "Four";
      defaultUid = 1000;
      defaultGroups = [
        "networkmanager"
        "video"
        "audio"
        "input"
        "kvm"
      ];
      sshAuthorizedKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPgHRgDdmenFi5SH02Rrja7iICXUAQQJqdQACPLY9S/1 four@robin"
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdipg6qr0s4he1E/k38S1wR+viUH/dycyMRYmWQQdKv bivsk@tutanota.com"
      ];
      defaultPosition = "owner";
      defaultShell = "bash";
    };
  };

  roster-machines = {
    merry = {
      users = {
        four = {
          homeManager = {
            enable = true;
            profiles = [
              "base"
              "dev"
              "gaming"
              "niri"
              "social"
            ];
          };
        };
      };
      homeManagerOptions = {
        sharedModules = [
          # {
          #   wayland.windowManager.hyprland.settings.monitor = [
          #     "eDP-1,2880x1920@120,auto,2"
          #     "DP-3,preferred,auto,1,mirror,eDP-1"
          #   ];
          # }
        ];
      };
    };
    sunny = {
      users = {
        four = {
          homeManager = {
            enable = true;
            profiles = [
              "base"
              "dev"
              "gaming"
              "niri"
              "social"
            ];
          };
        };
      };
      homeManagerOptions = {
        sharedModules = [ ];
      };
    };
  };
in
{
  instances = {
    roster = {
      module = {
        name = "roster";
        input = "self";
      };
      roles.default.tags.all = { };
      roles.default.settings = {
        users = roster-users;
        machines = roster-machines;
        homeProfilesPath = ../home-profiles;
        homeManagerOptions = {
          backupFileExtension = "bak";
        };
      };
    };
  };
}
