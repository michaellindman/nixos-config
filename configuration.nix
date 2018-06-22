# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./xserver.nix
      ./networking.nix
      ./users.nix
      ./virtualisation.nix
      ./packages.nix
      ./ssh.nix
      ./nix-containers.nix
    ];

  boot = {
    loader = {
      # Use the systemd-boot EFI boot loader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxPackages_4_16;
    kernelParams = [ "iommu=1" "amd_iommu=on" "pcie_acs_override=downstream,multifunction" "rd.driver.pre=vfio-pci" ];
    blacklistedKernelModules = [ "nvidia" "nouveau" ];
    kernelModules = [ "kvm-amd" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio" ];
    postBootCommands = "/usr/bin/vfio-pci-override.sh";
    extraModprobeConfig = "install vfio-pci /usr/bin/vfio-pci-override.sh";
  };

  # Apply ACS patch to kernel
  nixpkgs.config.packageOverrides = pkgs: {
    linux_4_16 = pkgs.linux_4_16.override {
      kernelPatches = pkgs.linux_4_16.kernelPatches ++ [
        { name = "acs";
          patch = pkgs.fetchurl {
            url = "https://lelrek.tk/s/BF8YZJmaMTA6PCH/download";
            sha256 = "5b952a2ea634d14e21806b11dfa6f937c9faab5a977373994430106e70809e15";
          };
        }
      ];
    };
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "uk";
    defaultLocale = "en_GB.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.bash.enableCompletion = true;
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.03"; # Did you read the comment?

}
