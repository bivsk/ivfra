# Development environment: formatter, pre-commit, and dev shells.
{
  pkgs,
  lib,
  self,
  inputs',
  ...
}:
let
  treefmtEval = inputs'.treefmt-nix.lib.evalModule pkgs {
    programs = {
      # Nix — priority: deadnix (1) → statix (2) → nixfmt (3)
      # deadnix removes unused code, statix catches anti-patterns, nixfmt formats.
      deadnix.enable = true;
      deadnix.priority = 1;

      statix.enable = true;
      statix.priority = 2;

      nixfmt = {
        enable = true;
        package = pkgs.nixfmt;
        priority = 3;
      };

      # Shell
      shellcheck.enable = true;
      shfmt.enable = true;

      # Python
      mypy.enable = true;
      ruff = {
        check = true;
        format = true;
      };

      # Rust
      rustfmt.enable = true;

      # C/C++
      clang-format.enable = true;

      # Web / data
      prettier = {
        enable = true;
        includes = [
          "*.cjs"
          "*.css"
          "*.html"
          "*.js"
          "*.json"
          "*.json5"
          "*.jsx"
          "*.md"
          "*.mdx"
          "*.mjs"
          "*.scss"
          "*.ts"
          "*.tsx"
          "*.vue"
          "*.yaml"
          "*.yml"
        ];
      };
    };

    settings = {
      global.excludes = [
        "*.png"
        "*.svg"
        "package-lock.json"
        "*.jpeg"
        "*.gitignore"
        "*.md"
        "*.toml"
        "*.pub"
        "*.priv"
        "*.age"
        "*.lock"

        # ignore symlink
        ".pre-commit-config.yaml"
        "*/sops/secrets/*"
        "vars/*"
        "**/node_modules/*"
        "**/.mypy_cache/*"

        # machine-generated
        "*/facter.json"
        "inventory.json"
      ];

      formatter = {
        # Shell: format .sh files and .envrc
        shfmt.includes = [
          "*.sh"
          "*.envrc"
        ];
        shellcheck.includes = [
          "*.sh"
        ];
      };
    };

    programs.mypy.directories = { };
  };

  treefmtWrapper = treefmtEval.config.build.wrapper;

  # --- pre-commit ---
  # Use pre-commit-hooks-nix's module system directly (no flake-parts wrapper)
  preCommitSrc = inputs'.pre-commit-hooks-nix;

  preCommitEval =
    (lib.evalModules {
      modules = [
        "${preCommitSrc}/modules/all-modules.nix"
        {
          config = {
            rootSrc = self.outPath;
            package = pkgs.pre-commit;
            tools = import "${preCommitSrc}/nix/call-tools.nix" pkgs;
            hooks = {
              treefmt = {
                enable = true;
                package = treefmtWrapper;
                pass_filenames = false;
              };
              statix.enable = true;
              deadnix.enable = true;
            };
            excludes = [
              "^vars/"
              "^sops/"
              "\\.age$"
              "\\.png$|\\.jpg$|\\.svg$"
              "flake\\.lock$"
              "^archive/"
            ];
          };
        }
      ];
      specialArgs = {
        inherit pkgs;
      };
    }).config;

in
{
  # treefmt formatter output
  formatter = treefmtWrapper;

  # pre-commit check
  checks.pre-commit = preCommitEval.run;

  devShells = {
    # Full development environment
    default = pkgs.mkShell {
      packages = [
        inputs'.clan-core.clan-cli
        preCommitEval.package
        pkgs.kanidmWithSecretProvisioning_1_9
      ]
      ++ [
        pkgs.nix-output-monitor
        (pkgs.writeShellScriptBin "nix-prefetch-sri" ''
          if [ -z "$1" ]; then
            echo "Usage: nix-prefetch-sri <url>"
            exit 1
          fi
          ${pkgs.curl}/bin/curl -sL "$1" | ${pkgs.nix}/bin/nix hash file --sri /dev/stdin
        '')
        (pkgs.writeShellScriptBin "build" ''
          if [ -z "$1" ]; then
            echo "Usage: build <machine-name>"
            exit 1
          fi
          if command -v nom &> /dev/null; then
            nom build .#nixosConfigurations.$1.config.system.build.toplevel
          else
            nix build .#nixosConfigurations.$1.config.system.build.toplevel
          fi
        '')
        (pkgs.writeShellScriptBin "validate" ''
          echo "Running nix fmt..."
          nix fmt && echo "Running pre-commit checks..." && pre-commit run --all-files
        '')
      ];

      shellHook = ''
        echo "Clan Infrastructure Development Shell"
        echo "Available commands:"
        echo "  clan             - Clan CLI for infrastructure management"
        echo "  build            - Build a machine configuration (test locally)"
        echo "  validate         - Run nix fmt and pre-commit checks"
        echo "  nix-prefetch-sri - Get SRI hash for a URL"
        echo ""

        ${preCommitEval.installationScript}
      '';
    };

    # Minimal shell with just clan CLI
    minimal = pkgs.mkShell {
      packages = [
        inputs'.clan-core.clan-cli
      ];

      shellHook = ''
        echo "Minimal Clan Shell"
        echo "Available: clan"
      '';
    };
  };
}
