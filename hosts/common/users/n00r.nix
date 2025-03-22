{
  config,
  pkgs,
  inputs,
  ...
}: {
  users.users.n00r = {
    initialHashedPassword = "$y$j9T$csTUEi7UuaxivnRBpke4r0$UpWeJz75jKq3ojOC9//5Sca/gOJx1K0RUU1iW0g6Md7";
    isNormalUser = true;
    description = "n00r";
    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      #"flatpak"
      "audio"
      "video"
      "plugdev"
      "input"
      "kvm"
      "qemu-libvirtd"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC4t2FGISS91zbX69KgFPaYp3cssQui4CkkTqWfCbRPj2Jz7oTvKZHHiGZ8hUclLlrTMF9qMZf/PBqKpWBFoXV9T1eBLW48cWmY2rJSbr8zAY/fmOaYL/49SclLARXiQaJEQKbPhZaPk2BJEr4ijCRvNSwPkDG4TEx4EFN1XBaXDH0pJTQd/Mnu1yyU/EK32r4eFIKlj8xoViRFJqdU0MX25czlUByHvyWLQ8bSuyvxcWS/XM4mhJOrv5zDMCvLUNaL7sktsoQkM04GCJQEwpqR+VSej7h0n4ojU9qD7oax5V+BaC1qxOdPHKLG1wU5+bi53tuxbI4V2mKoNP/Df1Ep phpseclib-generated-key"
    ];
    packages = [inputs.home-manager.packages.${pkgs.system}.default];
  };
  home-manager.users.n00r =
    import ../../../home/n00r/${config.networking.hostName}.nix;
}
