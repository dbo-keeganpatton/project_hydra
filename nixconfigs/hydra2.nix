
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];


  networking.hostName = "hydra-2"; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;
  time.timeZone = "America/Chicago";
  users.users.eyelady = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ];
    packages = with pkgs; [];
  };


  services.logind.settings = {
  # Ensure the system stays on when the lid is closed
  	Login = {
		HandleLidSwitch = "ignore";
		HandleLidSwitchDocked = "ignore";
	};
  };


  environment.systemPackages = with pkgs; [
	python3Packages.pynvim
	python3Packages.pip
	tree-sitter
	luarocks
	python3
	ripgrep
    	neovim    
	lua5_1
	unzip
	kitty
	nmap
	btop
	tmux
	wget
	yazi
	curl
	git
	fzf
  ];



  ##############################
  #        SSH & K8s Config    #
  ##############################
  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 6443 ];
  networking.firewall.allowedUDPPorts = [ 8472 ];
  services.k3s = {
	enable = true;
	role = "server";
	token = "token123";
	serverAddr = "https://192.168.0.7:6443";
  };


  system.stateVersion = "25.11";

}

