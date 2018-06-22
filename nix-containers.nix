{ config, pkgs, ... }:

{
  containers.database = {
    autoStart = false;
    config = { config, pkgs, ...}: { 
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql96;
      };
    };
  };
}
