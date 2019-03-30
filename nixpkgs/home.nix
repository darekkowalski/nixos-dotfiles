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
    gotop
    xclip
    psmisc
    acpi
    sysstat
    lm_sensors
    file
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
    whois

    # languages & build tools
    gcc8
    go
    gnumake
    lua
    python
    python3Full
    cmake
    yarn
    nodejs-11_x
    ms-sys
    git-quick-stats
    ansible
    glslang
    rustup

    libudev
    nodePackages.node-gyp
    libusb

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
    gimp
    vlc
    xfce.thunar
    spotify
    git-lfs
    brave
    irssi
    xournal
    libreoffice-fresh
    slack
    powerstat
    transmission-gtk
    xorg.xkill

    # rice
    lxappearance
    hicolor-icon-theme
    
    # chat
    weechat
    discord
  ];
  
  programs.home-manager = {
    enable = true;
    # path = "https://github.com/rycee/home-manager/archive/release-18.09.tar.gz";
  };
  
  programs.zsh = import ./zsh.nix pkgs;

  xsession = {
    enable = true;
    windowManager.i3 = import ./i3.nix pkgs;

    pointerCursor = {
      name = "Vanilla-DMZ-AA";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };
  programs.autorandr = import ./autorandr.nix pkgs;

  programs.rofi = import ./rofi.nix pkgs;
  services.dunst = import ./dunst.nix pkgs;
  services.redshift = import ./redshift.nix pkgs;
  services.compton = import ./compton.nix pkgs;

  services.network-manager-applet.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
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

  programs.firefox = {
    enable = true;
    enableIcedTea = true;
  };

  programs.fzf = {
    enable = true; 
    enableZshIntegration = true;
  };

  gtk = {
    enable = true;
    font = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans 9";
    };
    theme = {
      package = pkgs.theme-vertex;
      name = "Vertex-Dark";
    };
    iconTheme = {
      package = pkgs.tango-icon-theme;
      name = "Tango";
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
