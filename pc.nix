hardware.opengl = {
   enable = true;
   driSupport = true;
   extraPackages = with pkgs; [ libvdpau libvdpau-va-gl ];
};

services.xserver = {
   enable = true;
   layout = "us";
   videoDrivers = [ "nvidia" ]; # there also nvidiaBeta if you want to try something newer.
   displayManager.sddm.enable = true;
   desktopManager.plasma5.enable = true;
};

