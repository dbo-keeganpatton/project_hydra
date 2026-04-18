
{ pkgs, ... }:

{
  services.k3s = {
    enable = true;
    tokenFile = "/etc/secrets/k3s-token";
    package = pkgs.k3s;
  };

  
  networking.firewall.allowedTCPPorts = [ 6443 ];
  networking.firewall.allowedUDPPorts = [ 8472 ];

}

