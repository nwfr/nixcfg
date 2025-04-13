{
  sops = {
    defaultSopsFile = ../../secrets.yaml;
    validateSopsFiles = false;

    age = {
      # Automaticaly import host keys as age keys
      sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
      # this will use age key that is expected to already be in filesystem
      keyFile = "/var/lib/sops-nix/key.txt";
      # generate a new key if the key specified above does not exist
      generateKey = true;
    };

  };
}
