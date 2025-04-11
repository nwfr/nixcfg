{
  config,
  lib,
  inputs,
  ...
}:
with lib;
let
  cfg = config.features.cli.nvf;
in
{

  imports = [ inputs.nvf.homeManagerModules.default ];
  options.features.cli.nvf.enable = mkEnableOption "neovim config";

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      settings = {
        vim = {
          viAlias = true;
          vimAlias = true;

          theme = {
            enable = true;
            name = "catppuccin";
            style = "mocha";
            transparent = true;
          };

          languages = {
            enableLSP = true;
            enableTreesitter = true;
            enableExtraDiagnostics = true;
            enableFormat = true;

            bash.enable = true;
            css.enable = true;
            go.enable = true;
            html.enable = true;
            lua.enable = true;
            markdown.enable = true;
            php.enable = true;
            nix.enable = true;
            sql.enable = true;
            tailwind.enable = true;
            ts.enable = true;
            yaml.enable = true;
          };

          filetree.nvimTree = {
            enable = true;
            setupOpts.view.side = "right";
          };

          statusline.lualine.enable = true;
          telescope.enable = true;
          autocomplete.nvim-cmp.enable = true;
        };
      };
    };
  };
}
