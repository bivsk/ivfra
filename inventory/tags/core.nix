{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;
  clan.core.settings.state-version.enable = true;
  clan.core.networking.forwardAgent = true;

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

      trusted-users = [ "four" ];

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
    # TODO: wrap
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
  };

  users =
    let
      sunnyHostKey = builtins.readFile (
        config.clan.core.settings.directory + "/vars/per-machine/sunny/openssh/ssh.id_ed25519.pub/value"
      );
    in
    {
      users.four = {
        group = "four";
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdipg6qr0s4he1E/k38S1wR+viUH/dycyMRYmWQQdKv bivsk@tutanota.com"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDtreSl8MBVkIh9x/NcvF0Bhg79hVIE2Jzak4rZ4tV4x JuiceSSH"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDbrHCxT2L25bccuSVtCFKmDJpKrkLdMS3vt2oAvydbI"
          sunnyHostKey
        ];
        shell = lib.mkForce pkgs.nushell; # TODO: move to nushell module/wrapped nushell
      };
      groups.four = { };
      users.root.openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJdipg6qr0s4he1E/k38S1wR+viUH/dycyMRYmWQQdKv bivsk@tutanota.com"
        sunnyHostKey
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
