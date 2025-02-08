{pkgs, ...}: {
  programs.zsh = {
    # https://mynixos.com/search?q=programs.zsh

    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    enableCompletion = true;
    autocd = true;

    initExtra = ''
      eval "$(${pkgs.micromamba}/bin/micromamba shell hook --shell zsh)"
      eval "$(${pkgs.direnv}/bin/direnv hook zsh)"
    '';

    shellAliases = {
      ls = "${pkgs.eza}/bin/eza";
      cat = "${pkgs.bat}/bin/bat";
    };

    history.size = 10000;

    oh-my-zsh = {
      enable = true;
      theme = "ys";
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.fzf.enable = true;
}
