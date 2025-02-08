{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./fonts.nix
    ../../../../modules/nixos/xserver.nix
    ../../../../modules/nixos/opengl.nix
    ../../../../modules/nixos/audio.nix
    ../../../../modules/nixos/bluetooth.nix
    ../../../../modules/nixos/gaming.nix
    ../../../../modules/nixos/logitech.nix
    # NOTE: See what broken in Wayland. https://gist.github.com/probonopd/9feb7c20257af5dd915e3a9f2d1f2277
    ./wayland.nix
  ];

  environment.systemPackages = with pkgs; [
    # Basic applications
    mpv
    keepassxc

    # Theming
    papirus-icon-theme

    # Thumbnailer for videos
    ffmpegthumbnailer
  ];

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Thumbnailer service.
  services.tumbler.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Override some internationalisation properties.
  i18n.defaultLocale = lib.mkForce "en_US.UTF-8";
  i18n.supportedLocales = lib.mkForce ["en_US.UTF-8/UTF-8" "ru_UA.UTF-8/UTF-8"];
  i18n.inputMethod = {
    enable = true;
    type = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      table
      table-others
    ];
  };

  # Set up keyboard layouts
  services.xserver = {
    xkb.layout = lib.mkForce "us,ru";
  };

  # Cleanup unused apps
  environment.gnome.excludePackages = with pkgs; [
    gnome-software
    gnome-system-monitor
    gnome-contacts
    gnome-music
    gnome-tour
    gnome-logs
    cheese
    gedit
    epiphany
    geary
    totem
    sound-theme-freedesktop
  ];

  # Uniform look for Qt and GTK applications
  qt = {
    enable = true;
    platformTheme = "gnome";
    style = "adwaita-dark";
  };
}
