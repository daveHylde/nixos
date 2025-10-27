{
  programs.git = {
    enable = true;
		settings = {
			user = {
				name = "daveHylde";
				email = "david.hyldgaard@gmail.com";
			};
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
  };
	programs.delta = {
		enable = true;
		enableGitIntegration = true;
	};
} 
