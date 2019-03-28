{ pkgs, ...}:
# see https://github.com/NixOS/nixpkgs/blob/master/nixos/modules/services/x11/redshift.nix
{
  enable = true;
  # provider = "geoclue2";
  latitude = "43.65";
  longitude = "-79.38";
  
  # brightness = {
  #   day = "0.9";
  #   night = "0.65";
  # };

  # temperature = {
  #   day = 5700;
  #   night = 3500;
  # };
}
