{pkgs, ...}: {
  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-options = "zoom";

      picture-uri = builtins.fetchurl {
        url = "https://w.wallhaven.cc/full/lm/wallhaven-lmmo8r.jpg";
        sha256 = "1nfr5nmn277q8a601r8kzvwfq5far2g414l66y8alpllp799cwa3";
      };

      picture-uri-dark = builtins.fetchurl {
        url = "https://w.wallhaven.cc/full/lm/wallhaven-lmmo8r.jpg";
        sha256 = "1nfr5nmn277q8a601r8kzvwfq5far2g414l66y8alpllp799cwa3";
      };
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      experimental-features = ["scale-monitor-framebuffer"];
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      clock-show-weekday = true;
      clock-format = "24h";
      gtk-theme = "Adwaita";
      icon-theme = "Papirus-Dark";
      enable-hot-corners = false;
      clock-show-seconds = true;
    };

    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = ":minimize,maximize,close";
    };

    "org/gnome/desktop/input-sources" = {
      sources = "[('xkb', 'us'), ('xkb', 'ru')]";
      per-window = true;
    };

    "org/gnome/desktop/sound" = {
      event-sounds = false;
    };

    "org/gnome/nautilus/icon-view" = {
      captions = ["size" "none" "none"];
    };

    "org/gnome/shell" = {
      last-selected-power-profile = "performance";

      favorite-apps = [
        "org.gnome.Nautilus.desktop"
        "app.zen_browser.zen.desktop"
        "code.desktop"
        "md.obsidian.Obsidian.desktop"
        "com.mitchellh.ghostty.desktop"
        "org.telegram.desktop.desktop"
      ];

      "keybindings/show-screenshot-ui" = [];
    };

    # BUG: issue on sleep with battery
    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
    };

    "org/virt-manager/virt-manager/connections" = {
      autoconnect = ["qemu:///system"];
      uris = ["qemu:///system"];
    };
  };
}
