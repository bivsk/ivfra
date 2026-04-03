{
  ...
}:
{
  imports = [
    # ./animate.nix
    # ./bufremove.nix
    # ./clue.nix
    # ./cursorword.nix
    # ./diff.nix
    # ./files.nix
    ./fuzzy.nix
    ./git.nix
    ./hipatterns.nix
    # ./indentscope.nix
    ./map.nix
    ./move.nix
    # ./notify.nix
    ./operators.nix
    ./pairs.nix
    # ./sessions.nix
    ./splitjoin.nix
    ./starter.nix
    ./surround.nix
    ./trailspace.nix
  ];

  # mini.nvim documentation
  # See: https://github.com/echasnovski/mini.nvim
  plugins = {
    mini-ai = {
      enable = true;
      settings = {
        custom_textobjects = {
          f = {
            __raw = "require('mini.ai').gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' })";
          };
          c = {
            __raw = "require('mini.ai').gen_spec.treesitter({ a = '@class.outer', i = '@class.inner' })";
          };
        };
      };
    };

    mini-align.enable = true;

    mini-basics.enable = true;

    mini-bracketed = {
      enable = true;
      settings = {
        file.suffix = "";
        comment.suffix = "";
      };
    };

    mini-icons = {
      enable = true;
      mockDevIcons = true;
    };

    mini-snippets = {
      enable = true;
      settings = {
        mappings = {
          expand = "<C-l>";
          jump_next = "<C-j>";
          jump_prev = "<C-k>";
          stop = "<C-c>";
        };
        snippets = {
          __unkeyed-1.__raw = "require('mini.snippets').gen_loader.from_lang()";
        };
      };
    };
  };
}
