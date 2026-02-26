# Exportable flake modules for reuse in other flakes
# These can be imported by downstream consumers
_: {
  flake.flakeModules = {
    # Analysis tools module - provides acl, vars, tags, roster commands
    analysis-tools = ../parts/sops-viz.nix;

    # Pre-commit configuration module
    pre-commit = ../parts/pre-commit.nix;

    # Formatter configuration module
    formatter = ../parts/formatter.nix;
  };
}
