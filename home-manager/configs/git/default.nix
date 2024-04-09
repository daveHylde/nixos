{
  programs.git = {
    enable = true;
    userName = "daveHylde";
    userEmail = "david@jobbi.no";
    extraConfig = {
      pull.rebase = false;
      rerere.enabled = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/github.pub";
    };
    diff-so-fancy.enable = true;
  };
} 
