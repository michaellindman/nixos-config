{ config, pkgs, ... }:

{
  services.openssh = {
    enable = true;
    ports = [ 22 ];
    permitRootLogin = "no";
    passwordAuthentication = false;
    authorizedKeysFiles = [ ".ssh/authorized_keys" ];
    challengeResponseAuthentication = false;
  };
}
