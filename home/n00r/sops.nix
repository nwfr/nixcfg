{
  inputs,
  config,
  ...
}:
{

  imports = [ inputs.sops-nix.homeManagerModules.sops ];
  sops = {
    age.keyFile = "/home/n00r/.config/sops/age/keys.txt";

    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    secrets = {
      "private_keys/n00r" = {
        path = "/home/n00r/.ssh/id_ed25519";
      };
    };
  };
}
