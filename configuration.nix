# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

let secrets = import /etc/nixos/secrets.nix; in

{ config, pkgs, ... }:

{
  system.copySystemConfiguration = true;

  imports = [
    <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
    /etc/nixos/hardware-configuration.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    blacklistedKernelModules = [ "mei_me" ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

  networking.hostName = "pak"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "DejaVu Sans Mono";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/Toronto";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    bluez
    wget
    git
    unzip
    mkpasswd
    p7zip
    dmidecode
    fwupd
    neovim
    xorg.xinit
  ];

  # environment.shellAliases = {
  #   vim = "nvim";
  # };

  fonts.fonts = with pkgs; [
    font-awesome-ttf
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    dejavu_fonts
    (nerdfonts.override {
      withFont = "--complete FiraCode";
    })
  ];

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [ 3000 3001 8000 ];
  networking.firewall.allowedUDPPorts = [ ];

  # battery saver auto tune
  powerManagement.powertop.enable = true;

  services = {
    fwupd.enable = true;
    xserver = {
      enable = true;

      # Enable touchpad support.
      libinput = {
        enable = true;
        accelProfile = "adaptive";
        accelSpeed = "0.6";
        clickMethod = "clickfinger";
      };

      layout = "us";

      displayManager.lightdm = {
        enable = true;
        autoLogin.enable = true;
        autoLogin.user = "peter";
      };
    };
    openssh = {
      enable = false;
      forwardX11 = true;
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint gutenprintBin brlaser
      ];
    };
    # usbmuxd.enable = true;
  };

  # Font dpis
  services.xserver.dpi = 140;
  fonts.fontconfig.dpi = 140;

  services.dnsmasq.enable = true;
  services.dnsmasq.servers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];

  programs.light.enable = true;

  programs.adb.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.gnome3.gvfs.enable = true;

  services.flatpak.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.lxd.enable = true;

  users.mutableUsers = false;

  users.defaultUserShell = pkgs.zsh;

  users.users.root.hashedPassword = secrets.users.root.hashedPassword;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.peter = {
    isNormalUser = true;
    uid = 1000;
    description = "Peter Kieltyka";
    hashedPassword = secrets.users.peter.hashedPassword;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "sudoers" "audio" "video" "disk" "networkmanager" "lxd" "adbusers"];
  };

  services.tlp.extraConfig = ''
    START_CHARGE_THRESH_BAT0=70
    STOP_CHARGE_THRESH_BAT0=95
    CPU_SCALING_GOVERNOR_ON_BAT=powersave
    ENERGY_PERF_POLICY_ON_BAT=powersave
  '';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
