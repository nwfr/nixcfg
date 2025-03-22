{ config, ... }: {
  imports = [
    ../common
    ../features/cli
    ../features/desktop
    ./home.nix

  ];

  features = {
    cli = {
      fish.enable = true;
      fzf.enable = true;
      neofetch.enable = true;
    };
    desktop = {
      hyprland.enable = true;
      wayland.enable = true;
    };
  };
}
