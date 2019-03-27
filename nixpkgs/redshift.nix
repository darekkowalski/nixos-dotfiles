{ pkgs, ...}:
# see https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/redshift.nix
{
  enable = true;
  latitude = "43.65";
  longitude = "-79.38";
  brightness = {
    day = "0.6";
    night = "0.7";
  };
  # temperature = {
  #   day = 4000;
  #   night = 3500;
  # };
}
