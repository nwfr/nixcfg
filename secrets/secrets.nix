let
  n00r-laptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDPk4qNW2enqgQaJ7UXYVllO6pNioPhfEKA8gRRtup3W";
  n00r = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE95664C4x1p/8gmiFPXQBQpxySYD7VYzOFpUzsTIbHC nixos";
in
{
  "secret1.age".publicKeys = [
    n00r-laptop
    n00r
  ];
  "n00r-secrets.age".publicKeys = [
    n00r-laptop
    n00r
  ];
}
