{
  config,
  lib,
  ...
}:
with lib;
let
  cfg = config.features.cli.btop;
in
{
  options.features.cli.btop.enable = mkEnableOption "enable btop";

  config = mkIf cfg.enable {
    programs.btop = {
      enable = true;
      settings = {
        color_theme = "catppuccin_mocha";
        vim_keys = true;
        theme_background = true;
      };
    };
  };
}
