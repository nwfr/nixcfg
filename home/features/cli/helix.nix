{
  config,
  lib,
  pkgs,
  ...
}:
with lib;
let
  cfg = config.features.cli.helix;
in
{
  options.features.cli.helix.enable = mkEnableOption "enable extended helix configuration";

  config = mkIf cfg.enable {
    programs.helix = {
      enable = true;
      defaultEditor = true;
      settings = {
        theme = "catppuccin";
        editor = {
          indent-guides.render = true;
          lsp = {
            display-messages = true;
            display-inlay-hints = true;
          };
          end-of-line-diagnostics = "hint";
          inline-diagnostics = {
            cursor-line = "warning";
          };
          line-number = "relative";
          cursorline = true;
          scrolloff = 8;
          # shell = [ "zsh" "-c" ];
          gutters = [
            "diagnostics"
            "line-numbers"
            "spacer"
            "diff"
          ];
          auto-format = true;
          completion-replace = true;
          completion-trigger-len = 1;
          idle-timeout = 200;
          true-color = true;
          rulers = [ 80 ];
          bufferline = "always";
          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };
          color-modes = true;
          statusline = {
            # mode-separator = "";
            # mode-separator = "";
            # mode-separator = "";
            separator = "";
            # separator = "";
            left = [
              "mode"
              "selections"
              "spinner"
              "total-line-numbers"
            ];
            center = [ "file-name" ];
            right = [
              "diagnostics"
              "file-encoding"
              "file-line-ending"
              "file-type"
              "position-percentage"
              "position"
            ];
            mode = {
              normal = "N     ";
              insert = "   INS";
              select = "SELECT";
            };
          };
          file-picker = {
            hidden = false;
          };
          whitespace = {
            render = "all";
            characters = {
              # space = "·";
              nbsp = "⍽";
              tab = "→";
              newline = "⤶";
            };
          };
          # rainbow-brackets = true;
        };
        keys.normal = {
          space.space = "file_picker";
          space.w = ":w";
          space.q = ":q";
          esc = [
            "collapse_selection"
            "keep_primary_selection"
          ];
          C-g = [
            ":write-all"
            ":new"
            ":insert-output lazygit"
            ":set mouse false" # First disable mouse to hint helix into activating it
            ":set mouse true"
            ":buffer-close!"
            ":redraw"
            ":reload-all"
          ];
        };
      };
      languages.language = [
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
      ];
      themes = {
        catppuccin = {
          "inherits" = "catppuccin_mocha";
          "ui.background" = { };
        };
      };
    };
  };
}
