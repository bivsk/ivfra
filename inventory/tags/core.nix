{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  clan.core.settings.state-version.enable = true;

  # Use determinate nix
  # https://determinate.systems/nix/
  imports = [ inputs.determinate.nixosModules.default ];

  # Common nix settings
  nix = {
    channel.enable = false;
    optimise.automatic = true;

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
      persistent = true;
    };

    settings = {
      # Replace duplicate files in store with hard links
      auto-optimise-store = true;

      # Enable flakes and pipe-operators
      experimental-features = [ "pipe-operators" ];

      # Fallback to building from source if binary substitute fails
      fallback = true;

      # Increase number of parallel TCP connections
      http-connections = 0; # no limit

      # Prevent garbage collection from altering nix-direnv shells
      keep-outputs = true;
      keep-derivations = true;

      trusted-users = [
        "root"
        "four"
      ];

      # Make legacy nix commands use XDG base dirs
      use-xdg-base-directories = true;

      # Ignore dirty git trees
      warn-dirty = false;
    };
  };

  # Use tmpfs for /tmp, but
  # Redirect Nix builds to /var/tmp to avoid OOM on large builds
  boot.tmp.useTmpfs = true;
  systemd.services.nix-daemon.environment.TMPDIR = "/var/tmp";

  boot.loader.grub = {
    enable = true;
    device = lib.mkDefault "nodev";
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  environment.systemPackages = with pkgs; [
    # shell/ps
    file
    killall
    pstree
    tree

    # networking
    curl
    rsync
    wireguard-tools

    # misc
    pciutils
    unzip
    usbutils
    zip
  ];

  networking = {
    networkmanager.enable = true;
    nftables.enable = true;
    useNetworkd = false;
  };

  services = {
    avahi = {
      enable = true;
      openFirewall = true;
    };

    # Yubikey
    pcscd.enable = true;
    udev.packages = [ pkgs.yubikey-personalization ];

    # Enable SSH Agent forwarding on the server side
    openssh.settings.AllowAgentForwarding = true;

    # IRQ balancing for better multi-core performance
    irqbalance.enable = true;
  };

  programs = {
    htop = {
      enable = true;
      settings = {
        show_program_path = 0;
        show_cpu_temperature = 1;
        column_meters_0 = "LeftCPUs2 GPU Memory Swap ZFSARC";
        column_meter_modes_0 = "1 1 1 1 2";
        column_meters_1 = "RightCPUs2 Tasks LoadAverage Uptime Hostname";
        column_meter_modes_1 = "1 2 2 2 2";
      };
    };

    nano.enable = false;
    neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;
      defaultEditor = true;
    };
  };

  users = {
    users.four = {
      group = "four";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdipg6qr0s4he1E/k38S1wR+viUH/dycyMRYmWQQdKv bivsk@tutanota.com"
      ];
    };
    groups.four = { };
    users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdipg6qr0s4he1E/k38S1wR+viUH/dycyMRYmWQQdKv bivsk@tutanota.com"
    ];
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };
}
