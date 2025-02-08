{
  config,
  pkgs,
  inputs,
  lib,
  username,
  hostname,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Shared modules
    ../../modules/nixos/base.nix
    ../../modules/nixos/openssh.nix
    ../../modules/nixos/docker.nix
    # Machine specific modules
    ./modules/nixos/desktop.nix
    ./modules/nixos/flatpak.nix
    ./modules/nixos/development.nix
    ./modules/nixos/syncthing.nix
  ];

  networking.firewall.enable = false;
  networking.nftables.enable = false;

  nixpkgs.overlays = [
  ];

  programs.nix-ld.libraries = with pkgs; [
    # Add any missing dynamic libraries for unpackaged programs
    # here, NOT in environment.systemPackages
    libGL
    glibc
    gcc.cc.lib
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.binfmt.emulatedSystems = [
  ];

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = hostname;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Lisbon";

  # <sops>
  sops.defaultSopsFormat = "yaml";
  sops.defaultSopsFile = ./secrets/default.yaml;
  sops.age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key" "/home/${username}/.ssh/id_ed25519"];
  sops.secrets."user/password/hashed" = {};
  sops.secrets."user/password/hashed".neededForUsers = true;
  # </sops>

  # Users are immutable and managed by NixOS
  users.mutableUsers = false;

  users.users.${username} = {
    useDefaultShell = true;
    hashedPasswordFile = config.sops.secrets."user/password/hashed".path;
    isNormalUser = true;
    description = "Anzhelina Shevchuk";
    extraGroups = ["networkmanager" "wheel"];
    packages = [];
    openssh.authorizedKeys.keys = [];
  };

  # <openssh>
  services.openssh.settings.PermitRootLogin = lib.mkForce "yes";
  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOofyljh8apzd0uqhV/TKpPAyxWaiH52wQwKvKXn1WDn"
  ];
  # </openssh>

  # <certificates>
  security.pki.certificateFiles = [
    (pkgs.fetchurl {
      url = "https://ca.homeworld.lan:8443/roots.pem";
      hash = "sha256-+EsQqEb+jaLKq4/TOUTEwF/9lwU5mETu4MY4GTN1V+A=";
      curlOpts = "--insecure";
    })
  ];
  # </certificates>

  # <firewall>
  networking.firewall.allowedTCPPorts = [];
  # </firewall>

  home-manager = {
    sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
    ];
    extraSpecialArgs = {inherit inputs username;};
    backupFileExtension = "backup";
    users = {
      "${username}" = import ./home.nix;
    };
  };

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    onlyoffice-bin
  ];

  nixpkgs.config.permittedInsecurePackages = [];

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-gnome3;
  };

  environment.sessionVariables = {};

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = username;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
