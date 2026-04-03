_: {
  plugins.mini-move = {
    enable = true;
    settings = {
      mappings = {
        # Move visual selection
        left = "<C-M-h>";
        right = "<C-M-l>";
        down = "<C-M-j>";
        up = "<C-M-k>";

        # Move current line in Normal mode
        line_left = "<C-M-h>";
        line_right = "<C-M-l>";
        line_down = "<C-M-j>";
        line_up = "<C-M-k>";
      };
    };
  };
}
