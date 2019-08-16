{ pkgs, ... }:

let
  theme = import ./theme.nix;
  srandrd = import ./srandrd.nix;
  oomox = import ./oomox;
  git-quick-stats = import ./git-quick-stats;
  xwobf = import ./xwobf;
  # ngrok = import ./ngrok;
  mozilla = import (builtins.fetchGit {
    url = "https://github.com/mozilla/nixpkgs-mozilla.git";
    ref = "master";
    rev = "9f35c4b09fd44a77227e79ff0c1b4b6a69dff533";
  });
  nixpkgs = import <nixpkgs> { overlays = [ mozilla ]; };
in
{
  nixpkgs.config.allowUnfree = true;
  
  programs.home-manager.enable = true;

  nixpkgs.overlays = [
    mozilla
    (self: super: {
      latest = {
        rustChannels.nightly.rust = (nixpkgs.rustChannelOf { date = "2019-06-06"; channel = "nightly"; }).rust.override {
          targets = [
            "wasm32-unknown-unknown"
          ];

          extensions = [
            "rustfmt-preview"
            "rls-preview"
            "clippy-preview"
            "rust-src"
          ];
        };
      };
    })
  ];

  home.packages = with pkgs; [
    # ngrok

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
    s-tui
    # stress
    xorg.xmodmap
    xorg.xdpyinfo
    whois
    tmux
    arandr
    # wine

    # languages & build tools
    gcc8
    go
    gnumake
    binutils
    lua
    python
    python3Full
    cmake
    yarn
    nodejs-12_x
    ms-sys
    git-quick-stats
    ansible
    glslang
    latest.rustChannels.nightly.rust
    cargo-edit
    gitg
    lsof
    parallel

    libudev
    nodePackages.node-gyp
    libusb

    # desktop env
    pywal
    i3status-rust
    i3lock
    srandrd
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
    networkmanagerapplet

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
    libreoffice
    font-manager
    slack
    powerstat
    transmission-gtk
    xorg.xkill
    webtorrent_desktop
    nmap
    jq
    xdotool
    openvpn
    xorg.xwininfo

    gnupg
    #drone-cli

    # rice
    lxappearance
    hicolor-icon-theme
    
    # chat
    weechat
    discord
  ];
    
  programs.zsh = import ./zsh.nix pkgs;
  programs.rofi = import ./rofi.nix pkgs;
  programs.autorandr = import ./autorandr.nix pkgs;

  home.file.".tmux.conf".source = ../config/tmux.conf;
  home.file."./.config/kitty/kitty.conf".source = ../config/kitty/kitty.conf;

  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "dk@module17.xyz";
    userName = "Darek Kowalski";
    aliases = {
      co = "checkout";
      s = "status";
      ci = "commit";
      b = "branch";
      undo = "reset --soft HEAD^";
      last = "log 1 HEAD";
      diff2 = "diff --color-words --ignore-all-space --patience";
    };
    extraConfig = ''
      [branch "master"]
      remote = origin
      merge = refs/heads/master

      [core]
      editor = "code --wait";

      [push]
      default = "current";

      [diff]
      tool = "default-difftool";
    '';
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
      package = pkgs.google-fonts;
      name = "Open Sans 10";
      # package = pkgs.noto-fonts;
      # name = "Noto Sans 10";
    };
    theme = {
      package = pkgs.theme-vertex;
      name = "Vertex-Dark";
    };
    iconTheme = {
      package = pkgs.tango-icon-theme;
      name = "Tango";
    };
    gtk3.extraConfig = {
      gtk-decoration-layout = "appmenu,menu";
    };
  };


  # Services
  services.dunst = import ./dunst.nix pkgs;
  services.redshift = import ./redshift.nix pkgs;
  # services.compton = import ./compton.nix pkgs;


  # X
  xsession = {
    enable = true;
    windowManager.i3 = import ./i3.nix pkgs;

    pointerCursor = {
      name = "Vanilla-DMZ-AA";
      package = pkgs.vanilla-dmz;
      size = 32;
    };
  };

  home.file.".xinitrc".text = ''
    #!/bin/sh
    [ -f ~/.xprofile ] && . ~/.xprofile
    export TERMINAL=kitty
    exec dbus-launch --exit-with-x11 i3
  '';

  home.file.".xmodmap".text = ''
    ! Swap windows and alt keys
    remove mod1 = Alt_L Alt_R
    add control = Alt_L
    clear mod4
    add mod1 = Super_L

    ! set caps lock key to mod3
    clear lock
    keycode 66 = Hyper_R
    add mod3 = Hyper_R

    ! set print screen to mod3 as well
    keycode 107 = Hyper_R

    ! set left alt key to Control_L
    keycode 64 = Control_L

    ! set super key to Alt_L (swapping windows and alt key)
    keycode 133 = Alt_L

    ! set alt_r key to hyper as well
    keycode 108 = Hyper_R
  '';

  xresources.properties = {
    "Xft.dpi" = 140; # = 210 / 1.5
  };

  # systemd.user.services.lock = {
  #   Unit = {
  #     Description = "Lock Screen When Sleeping";
  #     Before = [ "sleep.target" ];
  #   };
  #   Service = {
  #     Type = "forking";
  #     ExecStart = "${pkgs.maim} /tmp/screen.png && ${xwobf}/bin/xwobf -s 11 /tmp/screen.png && ${pkgs.i3lock}/bin/i3lock -i /tmp/screen.png && rm /tmp/screen.png";
  #     # ExecStartPost = "/run/current-system/sw/bin/sleep 1";
  #   };
  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };

}
