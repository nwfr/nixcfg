{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./fzf.nix
    ./neofetch.nix
    ./helix.nix
    # ./starship.nix
    # ./secrets.nix
    ./ghostty.nix
    ./zellij.nix
    ./yazi.nix
    ./nvf.nix
    ./btop.nix
  ];

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    git = true;
    icons = "always";
    extraOptions = [
      "-l"
      "-a"
    ];
  };

  programs.bat = {
    enable = true;
  };

  home.packages = with pkgs; [
    coreutils
    fd
    htop
    httpie
    jq
    procs
    ripgrep
    tldr
    zip
  ];
}
