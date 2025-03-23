{
  disko.devices = {
    disk = {
      nixos = {
        type = "disk";
        # Adapt this to real disk
        device = "/dev/vda";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                extraArgs = ["-BOOT"];
              };
            };
            root = {
              # Adapt this to real disk (600G)
              size = "100G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
                extraArgs = ["-LROOT"];
              };
            };
            bak2 = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/bak2";
                extraArgs = ["-LBAK2"];
              };
            };
          };
        };
      };
    };
  };
}
