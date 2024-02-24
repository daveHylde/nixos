{
  programs.git = {
    enable = true;
    userName = "daveHylde";
    userEmail = "david@jobbi.no";
    extraConfig = {
      pull.rebase = false;
    };
    diff-so-fancy.enable = true;
  };
}
