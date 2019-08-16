# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

let secrets = import /etc/nixos/secrets.nix; in

{ config, pkgs, options, lib, ... }:

{
  system.copySystemConfiguration = true;

  # TODO: Determine hardware configuration for Macbook Pro
  imports = [
    <nixos-hardware/lenovo/thinkpad/x1/6th-gen>
    /etc/nixos/hardware-configuration.nix
  ];

  hardware.cpu.intel.updateMicrocode = true;
  hardware.enableRedistributableFirmware = true; # Might help wifi?

  # Use the systemd-boot EFI boot loader.
  boot = {
    kernelModules = [ "acpi_call" ];
    blacklistedKernelModules = [ "mei_me" ];
    loader = {
      systemd-boot.enable = true;
      systemd-boot.editor = false;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    extraModulePackages = with config.boot.kernelPackages; [ acpi_call ];
  };

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;

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
    home-manager
    neovim
    wget
    git
    mkpasswd
    fwupd
    bluez
    unzip
    p7zip
    dmidecode
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
    google-fonts
    dejavu_fonts
    powerline-fonts
    source-code-pro
  ];

  # Networking
  networking.hostName = "dk";
  networking.networkmanager.enable = true;
  networking.networkmanager.appendNameservers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];

  networking.firewall.allowedTCPPorts = [
    3000 3001
    8010        # VLC Chromecast
  ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;

  # battery saver auto tune
  powerManagement.powertop.enable = true;

  services = {
    fwupd.enable = true;

    dnsmasq.enable = true;
    dnsmasq.servers = [ "1.1.1.1" "8.8.8.8" "8.8.4.4" ];

    localtime.enable = true;

    xserver = {
      enable = true;
      displayManager.startx.enable = true;
      desktopManager.default = "none";
      layout = "us";

      # Enable touchpad support.
      libinput = {
        enable = true;
        accelProfile = "adaptive";
        accelSpeed = "0.6";
        clickMethod = "clickfinger";
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

    usbmuxd.enable = true;
  };

  # Resolution
  services.xserver.dpi = 210;
  fonts.fontconfig.dpi = 210;

  services.xserver.monitorSection = ''
    DisplaySize 310 174   # In millimeters
  '';

  programs.light.enable = true;
  programs.adb.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services.gnome3.gvfs.enable = true;

  services.flatpak.enable = true;

  virtualisation.docker.enable = true;

  users.mutableUsers = false;
  users.defaultUserShell = pkgs.zsh;
  users.users.root.hashedPassword = secrets.users.root.hashedPassword;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dk = {
    isNormalUser = true;
    uid = 1000;
    description = "Darek Kowalski";
    hashedPassword = secrets.users.dk.hashedPassword;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "sudoers" "audio" "video" "disk" "networkmanager" "lxd" "adbusers"];
  };

  services.tlp = {
    enable = true;
    extraConfig = ''
      START_CHARGE_THRESH_BAT0=90
      STOP_CHARGE_THRESH_BAT0=98
      CPU_SCALING_GOVERNOR_ON_BAT=powersave
      ENERGY_PERF_POLICY_ON_BAT=powersave
      CPU_SCALING_GOVERNOR_ON_AC=balance-performance
      ENERGY_PERF_POLICY_ON_AC=balance-performance
    '';
  };

  # Disable the "throttling bug fix" -_- https://github.com/NixOS/nixos-hardware/blob/master/common/pc/laptop/cpu-throttling-bug.nix
  systemd.timers.cpu-throttling.enable = lib.mkForce false;
  systemd.services.cpu-throttling.enable = lib.mkForce false;

  system.stateVersion = "19.03";
}
