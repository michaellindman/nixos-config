{ config, pkgs, ... }:

{
  services = {
    gnome3 = {
      gnome-keyring.enable = true;
      seahorse.enable = true;
    };
  };
}
