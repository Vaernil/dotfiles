{ config, lib, pkgs, options, ... }:

let
  nixcfg = {
    allowUnfree = true;
    oraclejdk.accept_license = true;
  };

  edge = import (fetchTarball https://github.com/NixOS/nixpkgs/archive/master.tar.gz) { config = nixcfg; };
 
 # get shared env variables
  #consts = import ../../shared/consts.nix;
  consts = import /home/boski/.dotfiles/os/nixos/shared/consts.nix;
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      # include
#      ../../config/packages.nix
#      ../../config/services.nix
#      ../../shared/consts.nix
      #/home/boski/.dotfiles/os/nixos/shared/consts.nix
    ];

  /* Nix preferences */

  nix = {
    #nixPath = [ "nixos-config=/home/boski/_dotfiles/os/nixos/configuration.nix" ];
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
      builders-use-substitutes = true
    '';
    distributedBuilds = true;
    # GC options
    gc.automatic = true;
    gc.dates = "weekly";
    gc.options = "--delete-older-than 30d";
  };

  virtualisation = {
    docker = {
      enable = true;
    };
    virtualbox = {
      host.enable = false;
    };
  };

  # TODO refind

  ### ENVIRONMENT VARIABLES

  environment.extraInit = ''
    # SVG loader for pixbuf (needed for GTK svg icon themes)
    export GDK_PIXBUF_MODULE_FILE=$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)
    '';

  # LOCALE
  # depening on hostname later
  time.timeZone = "Europe/Oslo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # FONTS
  console = {
    font = "Lat2-Terminus16";
    keyMap = "pl";
  };
  fonts.fonts = with pkgs; [
    iosevka
    hasklig
    powerline-fonts
    nerdfonts
    fira
    fira-code
    fira-code-symbols
    cooper-hewitt
    ibm-plex
    jetbrains-mono
    # bitmap
    spleen
  ];

  users.extraGroups.vboxusers.members = [ "boski" ];
  # For VR (Simula)
  nix.settings.trusted-users = [ "root" "boski"];
  # USERS
  nix.trustedUsers = [
    "root"
    "boski"
    "oski"
    "vaer"
    "vaernil"
    "ansgar"
    "ansgarus"
    "ansgarius"
    "mortwind"
    "mirra"
    "mirrasotiny"
    "redrhytmic"
  ];
  users.users.boski = {
    isNormalUser = true;
    uid = 1000;
    description = "Ansgar Edgarson";
    extraGroups = [
      "wheel"
      "disk"
      "docker"
      "audio"
      "video"
      "systemd-journal"
      "networkmanager"
      "network"
      "cdrom"
      "vboxusers"
      "corectrl"
      "lp"
      "scanner"
    ];
    packages = with pkgs; [
      docker
      zsh
      dash
      bash
      alacritty
      kitty
      neovim
      etcher
      git
      wget
      dmenu
      rofi
      wofi
      firefox
      #chrome
      thunderbird
      bspwm
      lemonbar
      tdesktop
      # include instead?
    ];
    createHome=true;
    # home="/home/boski";
    # home = consts.home;
    # dash vs zsh?
    shell="/run/current-system/sw/bin/bash";
    initialPassword="password";
    openssh.authorizedKeys.keyFiles = [
      "/etc/nixos/ssh/authorized_keys"
      "/home/boski/.ssh/authorized_keys"
      "~/.ssh/authorized_keys"
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2dEQrj+8mZVaQHAi4N6DcYK41vTOVEfwsd+dt9VSyF vaernil@gmail.com"
#      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFYFRUEBS2XeaW6sgNhbguZ3500VhdDoiQFUWH0PFkbX nickjanus@janusX1"
    ];
  };
  users.users.root.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID2dEQrj+8mZVaQHAi4N6DcYK41vTOVEfwsd+dt9VSyF vaernil@gmail.com"
  ];
  #users.defaultUserShell = "/run/current-system/sw/bin/fish";
  #users.defaultUserShell = "/run/current-system/sw/bin/zsh";














  ### NETWORK
  networking = {
    hostName = "pc-i9-nixos";
    # hostName = "wintermute-i9-nixos";
    networkmanager.enable = true;
    # wireless.enable = true;  # wpa_supplicant

    # disable DHCP later
    #useDHCP = false;
    interfaces.wlp3s0.useDHCP = true;

    useDHCP = lib.mkDefault true;
    interfaces.wlp114s0.useDHCP = lib.mkDefault true;
    firewall.allowPing = true;
    firewall.allowedTCPPorts = [ 22 ];
    # todo: have this read from file/togglable
    extraHosts =
      ''
      # 127.0.0.1 twitter.com
      # 127.0.0.1 www.twitter.com
    '';
  };

  # TODO

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.













  ### KEYS & SECRUTIY

  security.rtkit.enable = true;

  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "boski";
  services.xserver.exportConfiguration = true;

  ### PACKAGES AND SERVICES

  services.openssh = {
    enable = true;
    # require public key authentication for better security
    #passwordAuthentication = false;
    #kbdInteractiveAuthentication = false;
    permitRootLogin = "yes";
  };
  # Enable the OpenSSH server.
  services.sshd.enable = true;
  ### SOUND
  # Enable sound with pipewire.

  sound.enable = true;
  # ?!?!?!
  hardware.pulseaudio.enable = false;
  nixpkgs.config.pulseAudio = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # Enable CUPS to print documents.
  #services.printing.enable = true;
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Display MAnagers
  services.xserver.displayManager.sddm.enable = true;
  #services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.xserver.desktopManager.plasma5.enable = true;
  #services.xserver.desktopManager.xfce.enable  = true;

  # Window Managers
  services.xserver.windowManager.xmonad.enable  = true;
  services.xserver.windowManager.i3.enable  = true;
  services.xserver.windowManager.bspwm.enable  = true;
  #services.xserver.windowManager.twm.enable  = true;



  # Graphics settings
  services.xserver.videoDrivers = [ "nvidia" "intel" "i915"] ;
  #services.xserver.videoDrivers = [ "nouveau" ];

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  #hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.beta;




  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.

  ### PROGRAMS

  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.mtr.enable = true;

  programs.gnupg.agent.enable = true;
  programs.gnupg.agent.pinentryFlavor  = "qt";
  programs.steam.enable = true;
  # QT
  qt5.platformTheme = "qt5ct";

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.



  # auto upgrade
  #system.autoUpgrade.enable = true;
  #system.autoUpgrade.allowReboot = true;

  # unstable?
  system.stateVersion = "22.11"; # Did you read the comment?

}
