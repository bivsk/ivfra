{
  inputs = {
    adios-flake.url = "github:Mic92/adios-flake";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    clan-core = {
      url = "git+https://git.clan.lol/clan/clan-core?ref=main";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "dedupe-flake-parts";
        systems.follows = "dedupe-systems";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    determinate = {
      url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nix.inputs.flake-parts.follows = "dedupe-flake-parts";
        nix.inputs.git-hooks-nix.follows = "";
      };
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "dedupe-flake-parts";
    };

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    statix = {
      url = "github:molybdenumsoftware/statix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "dedupe-flake-parts";
      };
    };

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "dedupe-flake-parts";
        systems.follows = "dedupe-systems";
        nur.follows = "nur";
      };
    };

    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "dedupe-flake-parts";
    };

    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:amaanq/helium-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mcp-servers-nix = {
      url = "github:natsukium/mcp-servers-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixarr = {
      url = "github:nix-media-server/nixarr";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-openclaw = {
      url = "github:openclaw/nix-openclaw";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        nix-steipete-tools.inputs.nixpkgs.follows = "nixpkgs";
        flake-utils.inputs.systems.follows = "dedupe-systems";
      };
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "dedupe-flake-parts";
        systems.follows = "dedupe-systems";
      };
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        noctalia-qs.inputs.treefmt-nix.follows = "treefmt-nix";
        noctalia-qs.inputs.systems.follows = "dedupe-systems";
      };
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "dedupe-systems";
        flake-parts.follows = "dedupe-flake-parts";
      };
    };

    p2poolix = {
      url = "github:bivsk/p2poolix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hercules-ci-effects.follows = "hercules-ci-effects";
    };

    silentSDDM = {
      url = "github:uiriansan/SilentSDDM";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    wrappers = {
      url = "github:Lassulus/wrappers";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # inputs used solely for deduplication
    dedupe-flake-parts.url = "github:hercules-ci/flake-parts";
    dedupe-systems.url = "github:nix-systems/default";
  };

  outputs =
    inputs@{ adios-flake, ... }:
    adios-flake.lib.mkFlake {
      inherit inputs;
      inherit (inputs) self;
      systems = [ "x86_64-linux" ];

      modules = [
        ./flake-outputs/dev-env.nix
        ./flake-outputs/nixvim
      ];

      flake =
        # Evaluate clan outside of mkFlake since it produces system-agnostic outputs.
        import ./flake-outputs/clan.nix {
          inherit inputs;
          inherit (inputs) self;
        };
      # // (import ./flake-outputs/effects.nix { inherit inputs; });
    };
}
