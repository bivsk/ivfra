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
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILYzh3yIsSTOYXkJMFHBKzkakoDfonm3/RED5rqMqhIO britton@framework"
      ];
      defaultPosition = "owner";
      # defaultShell = "fish";
    };
  };

  roster-machines = {
    # ========== Britton Machines ===========
    # merry = {
    #   users = {
    #     four = {
    #       homeManager = {
    #         enable = true;
    #         profiles = [
    #           "base"
    #           "dev"
    #           # "hyprland"
    #           # "hypr-laptop"
    #           # "niri"
    #           # "social"
    #         ];
    #       };
    #     };
    #   };
    #   homeManagerOptions = {
    #     sharedModules = [
    #       # {
    #       #   wayland.windowManager.hyprland.settings.monitor = [
    #       #     "eDP-1,2880x1920@120,auto,2"
    #       #     "DP-3,preferred,auto,1,mirror,eDP-1"
    #       #   ];
    #       # }
    #     ];
    #   };
    # };
    sunny = {
      users = {
        four = {
          homeManager = {
            enable = true;
            profiles = [
              "base"
              # "dev"
              # "hyprland"
              # "niri"
              # "creative"
              # "social"
            ];
          };
        };
      };
      # homeManagerOptions = {
      #   sharedModules = [
      #     {
      #       wayland.windowManager.hyprland.settings = {
      #         monitor = [
      #           ",preferred,auto,1.5"
      #         ];
      #         xwayland = {
      #           force_zero_scaling = true;
      #         };
      #       };
      #     }
      #   ];
      # };
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
