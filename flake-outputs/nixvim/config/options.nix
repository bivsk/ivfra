{
  config,
  lib,
  pkgs,
  ...
}:
let
  neovimVersion = pkgs.neovim.version or "0.0";
  hasNeovim012OrNewer = lib.versionAtLeast neovimVersion "0.12";
in
{
  clipboard.register = "unnamedplus";

  colorschemes.everforest = {
    enable = true;
    lazyLoad.enable = config.plugins.lz-n.enable;

    settings = {
      diagnostic_line_highlight = 1;
      diagnostic_text_highlight = 1;
      transparent_background = 1;
    };
  };
  luaLoader.enable = true;

  globals = {
    # Disable useless providers
    loaded_ruby_provider = 0;
    loaded_perl_provider = 0;
    loaded_python_provider = 0;
  };

  opts = {
    # Performance & Timing
    updatetime = 100; # CursorHold delay; faster completion and git signs
    lazyredraw = false; # Breaks noice plugin
    synmaxcol = 240; # Disable syntax highlighting for long lines
    timeoutlen = 500; # Key sequence timeout (ms)
    smoothscroll = true; # Smooth scrolling with Ctrl-D/U

    # Project local config
    exrc = true; # Enable .nvim.lua, .nvimrc, .exrc in project dirs

    # UI & Appearance
    number = true;
    relativenumber = true;
    cursorline = true;
    cursorcolumn = true;
    signcolumn = "yes";
    colorcolumn = "100";
    laststatus = 3; # Global statusline
    showtabline = 2;
    showmode = false;
    showmatch = true;
    matchtime = 1; # Flash duration in deciseconds
    termguicolors = true;
    winborder = "rounded";

    # Windows & Splits
    splitbelow = true;
    splitright = true;
    splitkeep = "screen";

    # Mouse
    mouse = "a";
    mousemodel = "extend"; # Right-click extends selection

    # Search
    incsearch = true;
    ignorecase = true; # Case-insensitive search
    smartcase = true; # Unless pattern contains uppercase
    iskeyword = "@,48-57,_,192-255,-"; # Treat dash-separated text as a single word

    # Files & Buffers
    swapfile = false;
    undofile = true;
    autoread = true;
    writebackup = false;
    fileencoding = "utf-8";
    modeline = true; # Scan for editor directives like 'vim: set ft=nix'
    modelines = 100; # Scan first/last 100 lines for modelines

    # Spelling
    spell = true;
    spelllang = lib.mkDefault [ "en_us" ];

    # Indentation & Formatting
    tabstop = 2;
    shiftwidth = 2;
    expandtab = true;
    autoindent = true;
    breakindent = true;
    copyindent = true;
    preserveindent = true;
    formatoptions = "rqnl1j";
    formatlistpat = "^\\s*[0-9\\-\\+\\*]\\+[\\.)]*\\s\\+";
    linebreak = true;
    wrap = false;

    # Folding
    foldlevel = 10; # Keep most folds open, but preserve structure
    foldcolumn = "1";
    foldenable = true;
    foldmethod = "indent";
    foldnestmax = 10;
    foldlevelstart = -1; # -1 uses foldlevel value
    fillchars = {
      horiz = "━";
      horizup = "┻";
      horizdown = "┳";
      vert = "┃";
      vertleft = "┫";
      vertright = "┣";
      verthoriz = "╋";

      eob = " ";
      diff = "╱";

      fold = " ";
      foldopen = "";
      foldclose = "";

      msgsep = "‾";
    };

    # Completion & Popups
    pumheight = 10; # Max items in popup menu
    infercase = true;
    completeopt = [
      "menu"
      "menuone"
      "noselect"
    ];

    # Command Line & Messages
    cmdheight = 0; # Hide command line when not in use
    history = 100; # Command history limit
    report = 9001; # Disable "x more/fewer lines" messages

    # Editor Behavior
    virtualedit = "block";
    startofline = true;
    title = true;
  }
  // lib.optionalAttrs hasNeovim012OrNewer {
    completeitemalign = "abbr,kind,menu";
    jumpoptions = "stack";
    pumborder = "single";
    pummaxwidth = 100;
    completetimeout = 100;
  };

  viAlias = true;
  vimAlias = true;
}
