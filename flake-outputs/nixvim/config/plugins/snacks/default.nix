{
  imports = [
    ./bigfile.nix
    ./bufdelete.nix
    ./dim.nix
    ./gh.nix
    ./gitbrowse.nix
    ./lazygit.nix
    ./picker.nix
    ./profiler.nix
    ./rename.nix
    ./scope.nix
    ./scratch.nix
    ./terminal.nix
    ./toggle.nix
    ./zen.nix
  ];

  plugins.snacks = {
    # snacks.nvim documentation
    # See: https://github.com/folke/snacks.nvim
    enable = true;

    settings = {
      indent.enabled = true;
      input.enabled = true;
      scroll.enabled = true;
      statuscolumn = {
        enabled = true;
        folds = {
          open = true;
          git_hl = true;
        };
      };
      quickfile.enabled = true;
      styles = {
        input = {
          relative = "cursor";
          row = -4;
          col = 0;
        };
      };
    };
  };
}
