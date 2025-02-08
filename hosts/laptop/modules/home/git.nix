{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    extraConfig = {
      init.defaultBranch = "main";

      pull = {
        rebase = true;
      };

      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_ed25519.pub";
    };

    userName = "Anzhelina Shevchuk";
    userEmail = "anzhelina.shevchuk@gmail.com";
  };
}
