{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.gruvbox
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.resurrect
    ];
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf

      set -g prefix C-t
      set -g allow-passthrough on
      set -g mouse on

      set-option -g status-position top

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="
            ps - o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'M-Left' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
      bind-key -n 'M-Down' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
      bind-key -n 'M-Up' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
      bind-key -n 'M-Right' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
          if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

          bind-key -T copy-mode-vi 'M-Left' select-pane -L
          bind-key -T copy-mode-vi 'M-Down' select-pane -D
          bind-key -T copy-mode-vi 'M-Up' select-pane -U
          bind-key -T copy-mode-vi 'M-Right' select-pane -R
          bind-key -T copy-mode-vi 'M-p' select-pane -l
    '';
  };
}


