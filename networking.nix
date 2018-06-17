{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 ];
      #allowedUDPPorts =  [ ... ];
    };
  };
}
