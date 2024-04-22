{
  programs.git = {
    enable = true;
    userName = "daveHylde";
    userEmail = "david@jobbi.no";
    extraConfig = {
      pull.rebase = false;
      rerere.enabled = true;
      gpg.format = "ssh";
      user = {
        signingkey = "/home/david/.ssh/github.pub";
      };
      commit = {
        gpgSign = true;
      };
    };
    diff-so-fancy.enable = true;
  };
} 
