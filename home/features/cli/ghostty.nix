{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.features.cli.ghostty;
in {
  options.features.cli.ghostty.enable = mkEnableOption "enable extended ghostty configuration";

  config = mkIf cfg.enable {
    programs.ghostty
 = {
      enable = true;
      enableFishIntegration = true;
      enableZshIntegration = true;
      installVimSyntax = true;
      installBatSyntax = true;
      settings = {
        theme = "catppuccin-mocha";
        font-family = "JetBrainsMono Nerd Font";
        background-opacity = 0.8;
        unfocused-split-opacity = 0.96;
        font-size = 10;
        keybind = [
          "alt+c=copy_to_clipboard"
          "alt+v=paste_from_clipboard"
          "ctrl+shift+c=copy_url_to_clipboard"
          "ctrl+shift+v=paste_from_selection"
        ];
      };
  };
};
}
