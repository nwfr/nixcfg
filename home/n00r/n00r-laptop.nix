{ config, ... }:
{
  imports = [
    ../common
    ./dotfiles
    ../features/cli
    ../features/desktop
    ./home.nix
    ./sops.nix
  ];

  features = {
    cli = {
      fish.enable = true;
      fzf.enable = true;
      neofetch.enable = true;
      helix.enable = true;
      ghostty.enable = true;
      zellij.enable = true;
      yazi.enable = true;
      # nvf.enable = true;
    };
    desktop = {
      hyprland.enable = true;
      wayland.enable = true;
      fonts.enable = true;
    };
  };

  # settings specific to the host
  wayland.windowManager.hyprland = {
    settings = {
      # Devices
      device = [ ];

      # Monitors
      monitor = [
        "eDP-1, highres@highrr, auto, auto"
        "HDMI-A-1, highres@highrr, auto-up, auto"
      ];

      # Workspaces
      workspace = [
        "1, name:FOCUS"
        "2, name:BROWSER"
        "3, name:IDE"
        "4, name:FILE"
        "5, name:FILE-GUI"
        "6, name:SERVER"
        "7, name:MEDIA"
        "special:term, on-created-empty:ghostty"
        "special:clock, gapsout:400, on-created-empty:[float] ghostty -e clock"
        "special:calcurse, on-created-empty:ghostty -e calcurse"
        "special:notes, on-created-empty:[float] ghostty -e dooit"
        "special:skylight, monitor:HDMI-A-1"
        "special:volume, gapsout:200, on-created-empty:[float] ghostty -e pulsemixer"
        "special:music, on-created-empty:ghostty -e ncmpcpp"
        "special:calc, gapsout:400, on-created-empty:[float] ghostty -e bc -lq"
      ];
    };
  };
}
