{config, ...}: {
  programs.git = {
    enable = true;
    userEmail = "noorweb@noorweb.fr"; # "cat ${config.sops.secrets."nw_mail/nw".path}"; #
    userName = "nwfr";
    aliases = {};
  };
}
