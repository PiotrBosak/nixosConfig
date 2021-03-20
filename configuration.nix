# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      (import "${builtins.fetchTarball https://github.com/rycee/home-manager/archive/master.tar.gz}/nixos")
      ./hardware-configuration.nix
    ];

  
  location.latitude = 50.012100;
  location.longitude = 	20.985842;
  # Use the systemd-boot EFI boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda";
  nixpkgs.config.allowBroken = true;
  # networking.hostName = "nixos"; # Define your hostname.
#  networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp37s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
   console = {
     font = "Lat2-Terminus16";
     keyMap = "pl";
   };

  # Enable the Plasma 5 Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.plasma5.enable = true;
  services.xserver.windowManager = {
   qtile.enable = true;
   xmonad.enable = true;
   xmonad.enableContribAndExtras = true;
   xmonad.extraPackages = hpkgs: [
     hpkgs.xmonad
     hpkgs.xmonad-contrib
     hpkgs.xmonad-extras
]; 
}; 

  #nixpkgs.overlays = [
  #  import (builtins.fetchTarball https://github.com/nix-community/emacs-overlay/archive/master.tar.gz))
  #];

 
  #aliases
  programs.bash.shellAliases = {
	nixconf = "sudo vim /etc/nixos/configuration.nix";
	ls = "exa -lah --group-directories-first";

  };
  programs.fish.enable = true;
  programs.fish.shellAliases = {
	nixconf = "sudo vim /etc/nixos/configuration.nix";
};
  # Configure keymap in X11
   services.xserver.layout = "pl";
  # services.xserver.xkbOptions = "eurosign:e";

  # Enable CUPS to print documents.
   services.printing.enable = true;

  # Enable sound.
   sound.enable = true;
   hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.piotr = {
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" ]; # Enable ‘sudo’ for the user.
     shell = pkgs.fish;
   };

  #
  #allow unfree software
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
	#text editors and environments
	vim
	vimPlugins.spacevim
	sublime3-dev
	vscode
	jetbrains.rider
	jetbrains.datagrip
	jetbrains.idea-ultimate
	jetbrains.pycharm-professional
	jetbrains.webstorm


	#languages
	jetbrains.jdk
	scala
	rustup
	dotnet-sdk_3
	dotnet-netcore
	dotnet-aspnetcore
	elmPackages.elm
	elmPackages.elm-test
	mitscheme
	ghc
        stack
	
	#programming tools

	#build tools
	maven
	gradle
	sbt
	mill
	ghcid
	
	#scala specific stuff
	ammonite

        #emacs
        emacs
        emacs26Packages.doom 

	#desktop utilities (xmonad)	
	xmobar
	nitrogen
	picom
	trayer
	nitrogen
	xdotool
	pcmanfm
	ranger
        vifm
	xfce.thunar
	volumeicon
	xscreensaver
	rofi
	stalonetray
	
	#books/presentations
	okular
	calibre

	#network
	postman
	wireshark

	#university
	teams
	libreoffice

	#cli utilities  
        coreutils
        clang


    killall
	unzip
	unrar
	zip
	exa
	wget
	git
	imagemagick
	ripgrep
	bat
	starship
	fd
	tokei
	procs

	#nix
	home-manager

	#disks and backup
	gparted
	gnome3.gnome-disk-utility	
	etcher


	#system-utilities
	alacritty
	fish
	st
	htop	
	redshift

	#utilities
	gnome3.pomodoro
	kazam
	deluge
	

	
	#sound
	pulseaudio
	pavucontrol
	alsaLib
	alsaTools
	alsaUtils
	xorg.xev
	alsaPlugins
	pulseeffects
	qpaeq

	#databases
	mysql57
	postgresql
	dbeaver

	#entertainment
	vlc
	discord
	spotify
        virtmanager
        virtualbox

    #fonts	 
    fira-code
	fira
	fira-code-symbols

  #browsers
  vivaldi
  brave
  firefox-devedition-bin
  qutebrowser

  #node/npm	
	nodejs
	nodePackages.nodemon
	nodePackages.coinmon
	nodePackages.npm
	nodePackages.http-server
	nodePackages.node2nix
   ];














fonts.fonts = with pkgs; [
  noto-fonts
  noto-fonts-cjk
  noto-fonts-emoji
  liberation_ttf
  fira-code
  fira-code-symbols
  mplus-outline-fonts
  dina-font
  proggyfonts
];

services.redshift = {
	enable = true;
	brightness = {
	day = "1";
	night = "1";
	};
	temperature = {
	day = 5500;
	night = 3700;
	};
  };
services.mysql = {
	enable = true;
	dataDir = "/var/db/mysql";
	package = pkgs.mysql;
 };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}

