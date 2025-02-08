{config, username, ...}: let
  cfg = import ../../secrets/syncthing.nix;
in {

  sops.secrets.syncthing_private_key = {
    sopsFile = ../../secrets/syncthing.yaml;
    format = "yaml";
    key = "syncthing/keys/private";
    owner = username;
  };

  sops.secrets.syncthing_public_key = {
    sopsFile = ../../secrets/syncthing.yaml;
    format = "yaml";
    key = "syncthing/keys/public";
    owner = username;
  };

  services.syncthing = {
    enable = true;
    user = username;
    cert = config.sops.secrets.syncthing_public_key.path;
    key = config.sops.secrets.syncthing_private_key.path;
    group = "users";
    extraFlags = [
      "--no-default-folder"
    ];

    overrideDevices = true;
    overrideFolders = true;
    dataDir = "/home/${username}/Documents/";
    configDir = "/home/${username}/.config/syncthing/";

    settings = {
      gui = {
        theme = "black";
        user = cfg.gui.user;
        password = cfg.gui.password;
      };

      options = {
        crashReportingEnabled = false;
      };

        devices = {
          "archive.lan" = {id = cfg.devices.id;};
        };

        folders = {
          "Anzh's Obsidian" = {
            id = "mlxix-vvuns";
            path = "/home/${username}/Documents/Obsidian";
            devices = ["archive.lan"];
          };

          "Anzh's Passwords" = {
            id = "o2wks-mb7rz";
            path = "/home/${username}/Documents/Passwords";
            devices = ["archive.lan"];
          };
        };
    };
  };
}
