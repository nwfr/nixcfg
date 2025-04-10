{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.features.cli.nvf;
in {
  options.features.cli.nvf.enable = mkEnableOption "neovim config";

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
    };
  };
}
