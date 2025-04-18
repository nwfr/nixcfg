{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  sops = {
    age.keyFile = "/home/n00r/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    secrets = {
      "private_keys/n00r" = {
        path = "/home/n00r/.ssh/id_ed25519";
      };
      # "nw_mail/nw" = {
      # owner = config.users.users.n00r.name;
      # inherit (config.users.users.n00r) group;
      # };
      # "wifi_pass/work_cergy" = { };
    };
  };
}
