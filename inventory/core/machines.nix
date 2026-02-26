_: {
  machines = {
    merry = {
      name = "merry";
      tags = [
        "amdgpu"
        "core"
        # "crypto"
        "desktop"
        # "dev"
        # "laptop"
        # "media"
        # "password-manager"
        # "stylix"
      ];
      deploy = {
        targetHost = "root@127.0.0.1";
        buildHost = "";
      };
    };

    sunny = {
      name = "sunny";
      tags = [
        "amdgpu"
        "android"
        "core"
        "cross"
        "crypto"
        "desktop"
        "dev"
        "docker"
        "media"
        # "password-manager"
        "stylix"
      ];
      deploy = {
        targetHost = "root@sunny";
        buildHost = "";
      };
    };
  };
}
