{ inputs, config, ... }:
{
  # API keys
  clan.core.vars.generators.avante = {
    share = true;
    files.anthropic = {
      owner = "four";
      group = "four";
    };
    prompts.anthropic = {
      description = "Anthropic API key to be used with avante.nvim";
      persist = true;
      type = "hidden";
    };
  };

  imports = [ inputs.nvf.nixosModules.default ];

  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        enableLuaLoader = true;
        searchCase = "smart";
        syntaxHighlighting = true;

        options = {
          expandtab = true;
          tabstop = 2;
          shiftwidth = 0; # use tabstop
          wrap = false;
        };

        clipboard = {
          enable = true;
          registers = "unnamedplus";
          providers.wl-copy.enable = true;
        };

        spellcheck = {
          enable = true;
          programmingWordlist.enable = true;
        };

        lsp = {
          enable = true;

          formatOnSave = true;
          lspkind.enable = true;
          lightbulb.enable = false;
          lspsaga.enable = true;
          trouble.enable = true;
          otter-nvim.enable = true;
          nvim-docs-view.enable = true;
          harper-ls.enable = true;
        };

        debugger = {
          nvim-dap = {
            enable = true;
            ui.enable = true;
          };
        };

        languages = {
          enableFormat = true;
          enableTreesitter = true;
          enableExtraDiagnostics = true;

          nix = {
            enable = true;
            format.type = [ "nixfmt" ];

            lsp.servers = [
              "nil"
              "nixd"
            ];
          };

          bash.enable = true;
          clang.enable = true;
          cmake.enable = true;
          css.enable = true;
          go.enable = true;
          haskell.enable = true;
          html.enable = true;
          json.enable = true;
          lua.enable = true;
          make.enable = true;
          markdown.enable = true;
          nu.enable = true;
          qml.enable = true;
          rust = {
            enable = true;
            extensions.crates-nvim.enable = true;
          };
          sql.enable = true;
          toml.enable = true;
          ts.enable = true;
          zig.enable = true;
        };

        visuals = {
          nvim-scrollbar.enable = true;
          nvim-web-devicons.enable = true;
          nvim-cursorline.enable = true;
          cinnamon-nvim.enable = true;
          fidget-nvim.enable = true;

          highlight-undo.enable = true;
          blink-indent.enable = true;
        };

        statusline = {
          lualine = {
            enable = true;
          };
        };

        autopairs.nvim-autopairs.enable = true;

        autocomplete = {
          blink-cmp = {
            enable = true;
            friendly-snippets.enable = true;
            mappings = {
              complete = "<A-Space>";
              confirm = "<A-l>";
              next = "<A-j>";
              previous = "<A-k>";
              close = "<A-h>";
              scrollDocsUp = "<A-u>";
              scrollDocsDown = "<A-d>";
            };
            setupOpts = {
              sources = {
                default = [
                  "lsp"
                  "path"
                  "snippets"
                  "buffer"
                  "avante_commands"
                  "avante_mentions"
                  "avante_shortcuts"
                  "avante_files"
                ];
                providers = {
                  avante_commands = {
                    name = "avante_commands";
                    module = "blink.compat.source";
                    score_offset = 90; # show at a higher priority than lsp
                    opts = { };
                  };
                  avante_files = {
                    name = "avante_files";
                    module = "blink.compat.source";
                    score_offset = 100; # show at a higher priority than lsp
                    opts = { };
                  };
                  avante_mentions = {
                    name = "avante_mentions";
                    module = "blink.compat.source";
                    score_offset = 1000; # show at a higher priority than lsp
                    opts = { };
                  };
                  avante_shortcuts = {
                    name = "avante_shortcuts";
                    module = "blink.compat.source";
                    score_offset = 1000; # show at a higher priority than lsp
                    opts = { };
                  };
                };
              };
              appearance = {
                nerd_font_variant = "mono";
              };
            };
          };
        };

        snippets.luasnip.enable = true;

        filetree = {
          neo-tree = {
            enable = true;
            setupOpts = {
              git_status_async = true;
              enable_cursor_hijack = true;
              popup_border_style = "";
            };
          };
        };
        keymaps = [
          {
            key = "<leader>e";
            mode = [
              "n"
              "x"
            ];
            silent = true;
            action = ":Neotree filesystem reveal toggle<CR>";
          }
        ];

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter = {
          enable = true;
          context.enable = true;
        };

        binds = {
          cheatsheet.enable = true;
          whichKey = {
            enable = true;
          };
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
          neogit.enable = true;
        };

        minimap = {
          minimap-vim.enable = true;
          codewindow.enable = false;
        };

        dashboard.alpha = {
          enable = true;
        };

        notify = {
          nvim-notify.enable = true;
        };

        projects = {
          project-nvim.enable = true;
        };

        utility = {
          ccc.enable = false;
          vim-wakatime.enable = false;
          diffview-nvim.enable = true;
          yanky-nvim.enable = false;
          qmk-nvim.enable = false;
          icon-picker.enable = true;
          surround.enable = true;
          leetcode-nvim.enable = true;
          multicursors.enable = true;
          smart-splits.enable = true;
          undotree.enable = true;
          nvim-biscuits.enable = false;
          grug-far-nvim.enable = true;

          motion = {
            hop.enable = true;
            leap.enable = true;
          };
          images = {
            image-nvim.enable = false;
            img-clip.enable = true;
          };
        };

        notes = {
          neorg.enable = false;
          orgmode.enable = false;
          mind-nvim.enable = true;
          todo-comments.enable = true;
        };

        terminal = {
          toggleterm = {
            enable = true;
            lazygit.enable = true;
          };
        };

        ui = {
          borders.enable = true;
          noice.enable = true;
          colorizer.enable = true;
          modes-nvim.enable = false;
          illuminate.enable = true;
          breadcrumbs = {
            enable = true;
            navbuddy.enable = true;
          };
          smartcolumn = {
            enable = true;
            setupOpts.custom_colorcolumn = {
              nix = "110";
            };
          };
          fastaction.enable = true;
        };

        assistant = {
          chatgpt.enable = false;
          codecompanion-nvim.enable = false;
          avante-nvim = {
            enable = true;

            setupOpts = {
              provider = "claude";
              providers.claude = {
                api_key_name = "cmd: cat ${config.clan.core.vars.generators.avante.files.anthropic.path}";
              };
            };
          };
        };

        session = {
          nvim-session-manager.enable = false;
        };

        gestures = {
          gesture-nvim.enable = false;
        };

        comments = {
          comment-nvim.enable = false;
        };

        presence = {
          neocord.enable = true;
        };
      };
    };
  };
}
