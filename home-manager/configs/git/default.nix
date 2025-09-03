{
  programs.git = {
    enable = true;
    userName = "daveHylde";
    userEmail = "david.hyldgaard@gmail.com";
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
    delta.enable = true;
  };
} 
