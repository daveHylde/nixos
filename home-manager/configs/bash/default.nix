{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    initExtra = ''
      bind "set completion-ignore-case on"
      bind "set show-all-if-ambiguous on"
      bind "set menu-complete-display-prefix on"
    '';
    shellAliases = {
      k = "kubectl";
      clpb = "wl-copy";
      nx = "npx nx";
      ai = "ollama run llama3.2";
      b64 = "f() { echo -n \"$1\" | base64 -w 0 | wl-copy; }; f";
    };
    bashrcExtra = ''
      export PATH=~/.npm-packages/bin:$PATH
      export NODE_PATH=~/.npm-packages/lib/node_modules
    '';
  };
}
