{ pkgs, ... }:

let
  theme = import ./theme.nix;
  oomox = import ./oomox;
  git-quick-stats = import ./git-quick-stats;
  xwobf = import ./xwobf;
in
{
  nixpkgs.config.allowUnfree = true;
  
  home.packages = with pkgs; [
    # system utils
    htop
    xclip
    psmisc
    acpi
    sysstat
    lm_sensors
    file
    smartmontools
    graphviz
    toilet
    xorg.xev
    openssl
    rename
    usbutils
    ffmpeg
    pciutils
    # s-tui
    # stress
    xorg.xmodmap
    xorg.xdpyinfo

    # languages & build tools
    go
    gnumake
    lua
    tokei
    python
    python3Full
    cmake
    yarn
    nodejs-11_x
    ms-sys
    git-quick-stats
    awscli
    ansible
    swiProlog
    glslang
    rustup
    libimobiledevice

    # desktop env
    pywal
    i3status-rust
    i3lock
    gnome3.dconf
    maim
    pavucontrol
    feh
    libnotify
    inotify-tools
    xwobf
    blueman
    exa
    gitAndTools.git-extras
    playerctl
    unclutter
    networkmanagerapplet
    redshift

    # apps
    appimage-run
    google-chrome
    vscode
    kitty
    pcmanfm
    gnome3.eog
    gnome3.gucharmap
    gnome3.nautilus
    neofetch
    woeusb
    simplescreenrecorder
    kicad
    gimp
    atom
    arduino
    xoscope
    vlc
    xfce.thunar
    spotify
    git-lfs
    brave
    firefox
    irssi
    xournal
    libreoffice-fresh
    slack
    powertop
    powerstat
    transmission-gtk
    xorg.xkill
    
    # chat
    weechat
    discord
  ];
  
  programs.home-manager = {
    enable = true;
    # path = "https://github.com/rycee/home-manager/archive/release-18.09.tar.gz";

  };

  xsession = {
    enable = true;
    windowManager.i3 = import ./i3.nix pkgs;

    pointerCursor = {
      name = "Vanilla-DMZ";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
  programs.autorandr = import ./autorandr.nix pkgs;

  programs.rofi = import ./rofi.nix pkgs;
  services.dunst = import ./dunst.nix pkgs;
  services.redshift = import ./redshift.nix pkgs;
  services.compton = import ./compton.nix pkgs;

  programs.git = {
    enable = true;
    userEmail = "peter.kieltyka@gmail.com";
    userName = "Peter Kieltyka";
    aliases = {
      co = "checkout";
      s = "status";
      ci = "commit";
      b = "branch";
      undo = "reset --soft HEAD^";
      last = "log 1 HEAD";
      diff2 = "diff --color-words --ignore-all-space --patience";
    };
    extraConfig = {
      core.editor = "code --wait";
      push.default = "current";
      diff.tool = "default-difftool";
    };
  };

  systemd.user.services.lock = {
    Unit = {
      Description = "Lock Screen When Sleeping";
      Before = [ "sleep.target" ];
    };
    Service = {
      Type = "forking";
      ExecStart = "${pkgs.maim} /tmp/screen.png && ${xwobf}/bin/xwobf -s 11 /tmp/screen.png && ${pkgs.i3lock}/bin/i3lock -i /tmp/screen.png && rm /tmp/screen.png";
      # ExecStartPost = "/run/current-system/sw/bin/sleep 1";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}
