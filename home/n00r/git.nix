{
  programs.git = {
    enable = true;
    userEmail = "noorweb@noorweb.fr"; # "cat ${config.sops.secrets."nw_mail".path}"; #
    userName = "nwfr";
    aliases = { };
  };
}
