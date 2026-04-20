{pkgs, ... }:

{
  imports = [
    ../../modules/k3s/agent.nix
    ../../modules/security/sudo.nix
    ./hardware-configuration.nix
  ];

  networking.hostName = "hydra-5"; 
  networking.networkmanager.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.k3s.serverAddr = "https://192.168.0.7:6443";
  services.openssh.enable = true;

  users.users.eyelady = {
    isNormalUser = true;
    extraGroups = [ "wheel" "sudo" ]; 
  };

  services.logind.extraConfig = ''
    HandleLidSwitch=ignore
    HandleLidSwitchDocked=ignore
  '';

  environment.systemPackages = with pkgs; [
      kubernetes-helm
      fastfetch
      cmatrix
      neovim
      btop
      wget
      vim     
  ];

  system.stateVersion = "25.11";
}
