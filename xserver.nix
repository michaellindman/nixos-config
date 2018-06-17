{ config, pkgs, ... }:

{
  services.xserver = {
    enable = true;
    layout = "gb";
    videoDrivers = [ "nvidia" ];

    windowManager = {
      default = "i3";
      i3.enable =  true;
    };

    desktopManager = {
      gnome3.enable = true;
    };

    displayManager = {
      lightdm.enable = true;
    };
  };

  hardware.opengl.driSupport32Bit = true;
}
