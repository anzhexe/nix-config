{
  pkgs,
  pkgs-unstable,
  ...
}: {
  nixpkgs.overlays = [
    (self: super: {devenv = pkgs-unstable.devenv;})
  ];

  environment.systemPackages = with pkgs; [
    devenv
    direnv
    micromamba
    gcc
    clang
    pkg-config
    vscode
    deno
    jetbrains.pycharm-community
    code-cursor
    ghostty
  ];
}
