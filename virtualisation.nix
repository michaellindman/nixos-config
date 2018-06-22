{ config, pkgs, ... }:

{
  virtualisation = {
    
    libvirtd = {
      enable = true;
      qemuOvmf = true;
    };

    docker = {
      enable = true;
    };
  };
}
