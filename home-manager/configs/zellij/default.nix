{
  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      pane_frames = false;
      default_layout = "compact";
      theme = "gruvbox-dark";
      copy_command = "xclip -selection clipboard";
      keybinds = {

        normal = ''
          bind "Ctrl g" { SwitchToMode "Locked"; }
          bind "Ctrl q" { Quit; }
          bind "Alt n" { NewPane; }
          bind "Alt i" { MoveTab "Left"; }
          bind "Alt o" { MoveTab "Right"; }
          bind "Alt h" "Alt Left" { MoveFocusOrTab "Left"; }
          bind "Alt l" "Alt Right" { MoveFocusOrTab "Right"; }
          bind "Alt j" "Alt Down" { MoveFocus "Down"; }
          bind "Alt k" "Alt Up" { MoveFocus "Up"; }
          bind "Alt =" "Alt +" { Resize "Increase"; }
          bind "Alt -" { Resize "Decrease"; }
          bind "Alt [" { PreviousSwapLayout; }
          bind "Alt ]" { NextSwapLayout; }
        '';
      };
    };
  };
}
