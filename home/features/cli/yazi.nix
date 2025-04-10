{
  pkgs,
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.features.cli.yazi;
  # yazi-plugins = pkgs.fetchFromGitHub {
  #   owner = "yazi-rs";
  #   repo = "plugins";
  #   rev = "";
  #   hash = "";
  # };
in
{
  options.features.cli.yazi.enable = mkEnableOption "enable yazi";

  config = mkIf cfg.enable {
    programs.yazi = {
      enable = true;
      enableFishIntegration = true;
      shellWrapperName = "y";

      settings = {
        manager = {
          show_hidden = true;
        };
        preview = {
          max_width = 1000;
          max_height = 1000;
        };
      };

      # plugins = {
      # chmod = "${yazi-plugins}/chmod.yazi";
      # full-border = "${yazi-plugins}/full-border.yazi";
      # toggle-pane = "${yazi-plugins}/toggle-pane.yazi";
      # starship = pkgs.fetchFromGitHub {
      #   owner = "Rolv-Apneseth";
      #   repo = "starship.yazi";
      #   rev = "";
      #   sha256 = "";
      # };
      # };

      # initLua = ''
      #   			require("full-border"):setup()
      #   			require("starship"):setup()
      #   		'';

      # keymap = {
      #   manager.prepend_keymap = [
      #     {
      #       on = "T";
      #       run = "plugin toggle-pane max-preview";
      #       desc = "Maximize or restore the preview pane";
      #     }
      #     {
      #       on = [
      #         "c"
      #         "m"
      #       ];
      #       run = "plugin chmod";
      #       desc = "Chmod on selected files";
      #     }
      #   ];
      # };
      # flavors = {
      #   dark = "catppuccin-mocha";
      # };
    };
  };
}
