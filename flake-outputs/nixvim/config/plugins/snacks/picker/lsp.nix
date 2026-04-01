{
  config,
  lib,
  ...
}:
{
  keymaps =
    lib.mkIf (config.plugins.snacks.enable && lib.hasAttr "picker" config.plugins.snacks.settings)
      [
        {
          mode = "n";
          key = "<leader>fd";
          action = "<CMD>lua Snacks.picker.diagnostics_buffer()<CR>";
          options.desc = "Find buffer diagnostics";
        }
        {
          mode = "n";
          key = "<leader>fD";
          action = "<CMD>lua Snacks.picker.diagnostics()<CR>";
          options.desc = "Find workspace diagnostics";
        }
        {
          mode = "n";
          key = "<leader>fl";
          action = "<CMD>lua Snacks.picker.lsp_symbols()<CR>";
          options.desc = "Find lsp document symbols";
        }
        {
          mode = "n";
          key = "<leader>fG";
          action = "<CMD>lua Snacks.picker.lsp_workspace_symbols()<CR>";
          options.desc = "Find lsp workspace symbols";
        }
        {
          mode = "n";
          key = "<leader>ld";
          action = "<CMD>lua Snacks.picker.lsp_definitions()<CR>";
          options.desc = "Goto Definition";
        }
        {
          mode = "n";
          key = "<leader>li";
          action = "<CMD>lua Snacks.picker.lsp_implementations()<CR>";
          options.desc = "Goto Implementation";
        }
        {
          mode = "n";
          key = "<leader>lD";
          action = "<CMD>lua Snacks.picker.lsp_references()<CR>";
          options.desc = "Find references";
        }
        {
          mode = "n";
          key = "<leader>lt";
          action = "<CMD>lua Snacks.picker.lsp_type_definitions()<CR>";
          options.desc = "Goto Type Definition";
        }

        {
          mode = "n";
          key = "gd";
          action = "<CMD>lua Snacks.picker.lsp_definitions()<CR>";
          options.desc = "Goto Definition";
        }
        {
          mode = "n";
          key = "gD";
          action = "<CMD>lua Snacks.picker.lsp_declarations()<CR>";
          options.desc = "Goto Declaration";
        }
        {
          mode = "n";
          key = "grr";
          action = "<CMD>lua Snacks.picker.lsp_references()<CR>";
          options = {
            desc = "Goto References";
            nowait = true;
          };
        }
        {
          mode = "n";
          key = "gri";
          action = "<CMD>lua Snacks.picker.lsp_implementations()<CR>";
          options.desc = "Goto Implementation";
        }
        {
          mode = "n";
          key = "gy";
          action = "<CMD>lua Snacks.picker.lsp_type_definitions()<CR>";
          options.desc = "Goto T[y]pe Definition";
        }
      ];
}
