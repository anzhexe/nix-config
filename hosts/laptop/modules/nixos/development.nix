{pkgs, ...}: {
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
  ];
}
