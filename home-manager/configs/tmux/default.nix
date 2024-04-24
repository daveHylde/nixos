{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
      tmuxPlugins.resurrect
    ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      set -g prefix C-t
      set -g allow-passthrough on
      set -g mouse on

      set-option -g status-position top
    '';
  };
}


