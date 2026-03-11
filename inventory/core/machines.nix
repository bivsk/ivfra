_: {
  machines = {
    merry = {
      name = "merry";
      tags = [
        "amdgpu"
        "core"
        "crypto"
        "desktop"
        "dev"
        "gaming"
        "laptop"
        "media"
        "niri"
        "password-manager"
        "stylix"
      ];
      deploy = {
        targetHost = "root@merry";
        buildHost = "";
      };
    };

    sunny = {
      name = "sunny";
      tags = [
        "amdgpu"
        "calibre"
        "core"
        "cross"
        "crypto"
        "desktop"
        "dev"
        "docker"
        "gaming"
        "hercules-ci-agent"
        "media"
        "niri"
        "nixarr"
        "password-manager"
        "stylix"
      ];
      deploy = {
        targetHost = "root@127.0.0.1";
        buildHost = "";
      };
    };
  };
}
