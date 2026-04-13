{
  config,
  lib,
  ...
}:
let
  claudeModel = "claude-sonnet-4-5";
  ollamaModel = "qwen3.5:9b";
in
{
  plugins = {
    avante = {
      # avante.nvim documentation
      # See: https://github.com/yetone/avante.nvim
      enable = true;

      lazyLoad.settings.event = [ "DeferredUIEnter" ];

      settings = {
        provider = "claude";
        auto_suggestions_provider = "ollama";
        behaviour = {
          auto_suggestions = true;
          support_paste_from_clipboard = true;
        };
        providers = {
          claude = {
            # See: https://github.com/yetone/avante.nvim/pull/2985
            model = claudeModel;
          };
          ollama = {
            endpoint = "http://sunny:11434";
            model = ollamaModel;
          };
        };
        acp_providers = {
          ollama = {
            endpoint = "http://sunny:11434";
            model = ollamaModel;
          };
          claude-code = {
            model = claudeModel;
            env = {
              ANTHROPIC_API_KEY.__raw = ''os.getenv("ANTHROPIC_API_KEY")'';
            };
          };
        };
        # Define our own mappings under correct prefix
        mappings = {
          ask = "<leader>aaa";
          new_ask = "<leader>aan";
          edit = "<leader>aae";
          refresh = "<leader>aar";
          focus = "<leader>aaf";
          stop = "<leader>aaS";
          toggle = {
            default = "<leader>aat";
            debug = "<leader>aad";
            hint = "<leader>aah";
            selection = "<leader>aaC";
            suggestion = "<leader>aas";
            repomap = "<leader>aaR";
          };
          files = {
            add_current = "<leader>aa.";
            add_all_buffers = "<leader>aaB";
          };
          select_model = "<leader>aa?";
          select_history = "<leader>aah";
          zen_mode = "<leader>aaz";
        };
      };
    };

    which-key.settings.spec = lib.optionals config.plugins.avante.enable [
      {
        __unkeyed-1 = "<leader>aa";
        group = "Avante";
        icon = "";
        mode = [
          "n"
          "v"
        ];
      }
    ];
  };

  keymaps = lib.optionals config.plugins.avante.enable [
    {
      mode = "n";
      key = "<leader>aac";
      action = "<CMD>AvanteClear<CR>";
      options.desc = "avante: clear";
    }
  ];
}
