_: {
  instances = {

    # Password generation via upstream clan-core users module.
    # Groups are set here; UID, shell, and SSH keys are in tags/core.nix.
    user-four = {
      module.name = "users";
      module.input = "clan-core";
      roles.default.tags.nixos = { };
      roles.default.settings = {
        user = "four";
        prompt = true;
        groups = [
          "wheel"
          "networkmanager"
          "video"
          "audio"
          "input"
          "kvm"
        ];
      };
    };

    # Home-manager profiles per machine group.
    # Server/headless machines: base + dev
    hm-server = {
      module.name = "home-manager-profiles";
      module.input = "self";
      roles.default = {
        tags.hm-server = { };
        settings = {
          username = "four";
          profiles = [
            "base"
          ];
          profilesBasePath = ../home-profiles;
        };
      };
    };

    # Laptop machines: base + dev + noctalia + social
    hm-laptop = {
      module.name = "home-manager-profiles";
      module.input = "self";
      roles.default = {
        tags.hm-laptop = { };
        settings = {
          username = "four";
          profiles = [
            "base"
            "dev"
            "gaming"
            "niri"
            "social"
          ];
          profilesBasePath = ../home-profiles;
        };
      };
    };

    # Desktop: base + dev + noctalia + creative + social
    hm-desktop = {
      module.name = "home-manager-profiles";
      module.input = "self";
      roles.default = {
        # machines.sunny = { };
        tags.hm-desktop = { };
        settings = {
          username = "four";
          profiles = [
            "base"
            "dev"
            "gaming"
            "niri"
            "social"
          ];
          profilesBasePath = ../home-profiles;
        };
      };
    };

  };
}
