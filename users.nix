{ config, pkgs, ... }:

{
  users.users.michael = {
    isNormalUser = true;
    home = "/home/michael";
    description = "Michael";
    extraGroups = [ "wheel" "networkmanager" "michael" "libvirtd" "docker" ];
    uid = 1000;
  };
}
