{...}: {
  services.flatpak.enable = true;
  services.flatpak.update.onActivation = true;
  services.flatpak.uninstallUnmanaged = true;
  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };

  services.flatpak.overrides = {
    global = {
      Environment = {
        # Fix un-themed cursor in some Wayland apps
        XCURSOR_PATH = "/run/host/user-share/icons:/run/host/share/icons";
        # Force correct theme for some GTK apps
        GTK_THEME = "Adwaita:dark";
      };
    };
  };

  services.flatpak.packages = [
    "app.zen_browser.zen"
    "org.telegram.desktop"
    "im.riot.Riot"
    "com.obsproject.Studio"
    "md.obsidian.Obsidian"
    "com.github.johnfactotum.Foliate"
    "org.kde.krita"
    "org.mozilla.firefox"
    "com.github.tchx84.Flatseal"
    "com.slack.Slack"
  ];
}
