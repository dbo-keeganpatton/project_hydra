{ pkgs, ... }:

{
  imports = [
    ../../modules/k3s/server.nix
    ../../modules/security/sudo.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "hydra-1"; 
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.k3s.clusterInit = true;
  services.openssh.enable = true;

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

  system.stateVersion = "25.11";
}
