{pkgs, ...}:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Noto Sans 11";
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "left";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        geometry = "300x5-30+20";
        shrink = "no";
        transparency = 10;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        history_length = 20;
        show_indicators = "yes";
        line_height = 0;
        separator_height = 2;
        padding = 8;
        horizontal_padding = 8;
        separator_color = "frame";
        startup_notification = false;
        frame_width = 3;
        frame_color = "#ebdbb2";
      };
      urgency_low = {
        background = "#282828";
        foreground = "#ebdbb2";
        timeout = 10;
      };
      urgency_normal = {
        background = "#458588";
        foreground = "#ebdbb2";
        timeout = 10;
      };
      urgency_critical = {
        background = "#cc241d";
        foreground = "#ebdbb2";
        frame_color = "#fb4934";
        timeout = 0;
      };
    };
  };
}

