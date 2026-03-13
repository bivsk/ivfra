_: {
  machines = {
    baratie = {
      name = "baratie";
      tags = [
        "core"
        "nixarr-nginx"
        "tailnet-bivsk"
      ];
      deploy = {
        # targetHost = "root@watch.bivsk.com";
        buildHost = "root@sunny";
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
        "niri"
        "password-manager"
        "stylix"
        "tailnet-bivsk"
      ];
      deploy = {
        # targetHost = "root@192.168.0.29";
        buildHost = "";
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
        "niri"
        "nixarr"
        "password-manager"
        "stylix"
        "tailnet-bivsk"
      ];
      deploy = {
        targetHost = "root@127.0.0.1";
        buildHost = "";
      };
    };
  };
}
