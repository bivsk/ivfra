_: {
  machines = {
    baratie = {
      name = "baratie";
      tags = [
        "core"
        "kanidm"
        "nixarr-nginx"
        "tailnet-bivsk"
        "hm-server"
      ];
      deploy = {
        targetHost = "root@watch.bivsk.com";
        buildHost = "root@192.168.0.22";
      };
    };

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
        "neovim"
        "niri"
        "password-manager"
        "stylix"
        "tailnet-bivsk"
        "hm-laptop"
      ];
      deploy = {
        targetHost = "root@192.168.0.29";
        buildHost = "root@192.168.0.22";
      };
    };

    sunny = {
      name = "sunny";
      tags = [
        # "kanidm-server"
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
        "neovim"
        "niri"
        "nixarr"
        "password-manager"
        "qmk"
        "stylix"
        "tailnet-bivsk"
        "hm-desktop"
      ];
      deploy = {
        targetHost = "root@192.168.0.22";
        buildHost = "";
      };
    };

    yuda = {
      name = "yuda";
      tags = [
        "core"
        "tailnet-bivsk"
        "hm-server"
      ];
      deploy = {
        targetHost = "root@192.168.0.14";
        buildHost = "root@192.168.0.22";
      };
    };
  };
}
