{ config, pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    hostId = "43a989cc";

    networkmanager = {
      enable = true;
    };

    firewall = {
      enable = true;
      allowedTCPPorts = [ 22 5201 ];
      #allowedUDPPorts =  [ ... ];
    };
  };
}
