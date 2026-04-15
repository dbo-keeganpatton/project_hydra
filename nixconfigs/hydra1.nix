
{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  networking.hostName = "hydra-1"; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.networkmanager.enable = true;

  users.users.eyelady = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ]; 
  };

  environment.sessionVariables = {
	  KUBECONFIG = "/etc/rancher/k3s/k3s.yaml";
  };



  environment.systemPackages = with pkgs; [
  	kubernetes-helm
  	fastfetch
  	btop
	neovim
    	vim     
	wget
  ];

  #########################
  #     K8 & SSH support  #
  #########################
  services.openssh.enable = true;
  services.k3s = {
	enable = true;
	role = "server";
	token = "token123";
	clusterInit = true;
  };
  networking.firewall.allowedTCPPorts = [ 6443 3000 ];
  networking.firewall.allowedUDPPorts = [ 8472 ];

  

  system.stateVersion = "25.11";

}

