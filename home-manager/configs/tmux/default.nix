{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    plugins = with pkgs;
      with tmuxPlugins; [
        gruvbox
        resurrect
        vim-tmux-navigator
        continuum
      ];
    clock24 = true;
    disableConfirmationPrompt = true;
    mouse = true;
    extraConfig = ''
      unbind r
      bind r source-file ~/.config/tmux/tmux.conf
      bind u display-popup

      set-option -g default-terminal "screen-256color"
      set-option -sa terminal-features ',screen-256color:RGB'
			set-option -sg escape-time 10

      set -g prefix C-t
      set -g allow-passthrough on

      set-option -g status-position top

      set -g @ressurect-strategy-vim 'session'
      set -g @continuum-restore 'on'

      # Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
          | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"
      bind-key -n 'C-Left' if-shell "$is_vim" 'send-keys C-Left'  'select-pane -L'
      bind-key -n 'C-Down' if-shell "$is_vim" 'send-keys C-Down'  'select-pane -D'
      bind-key -n 'C-Up' if-shell "$is_vim" 'send-keys C-Up'  'select-pane -U'
      bind-key -n 'C-Right' if-shell "$is_vim" 'send-keys C-Right'  'select-pane -R'
      tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
      if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-p' if-shell \"$is_vim\" 'send-keys C-p'  'select-pane -l'"
      if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
          "bind-key -n 'C-p' if-shell \"$is_vim\" 'send-keys C-p\\'  'select-pane -l'"

      bind-key -T copy-mode-vi 'C-Left' select-pane -L
      bind-key -T copy-mode-vi 'C-Down' select-pane -D
      bind-key -T copy-mode-vi 'C-Up' select-pane -U
      bind-key -T copy-mode-vi 'C-Right' select-pane -R
      bind-key -T copy-mode-vi 'C-p' select-pane -l
    '';
  };
}

