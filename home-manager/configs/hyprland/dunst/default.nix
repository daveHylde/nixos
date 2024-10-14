{pkgs, ...}:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "SF Pro Text 11";
        markup = "full";
        format = "<b>%s</b>\n%b";
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "center";
        show_age_threshold = 60;
        word_wrap = "yes";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        geometry = "300x5-30+20";
        shrink = "no";
        transparency = 15;
        idle_threshold = 120;
        monitor = 0;
        follow = "mouse";
        sticky_history = "yes";
        history_length = 20;
        show_indicators = "no";
        line_height = 0;
        separator_height = 1;
        padding = 12;
        horizontal_padding = 12;
        separator_color = "auto";
        startup_notification = false;
        frame_width = 1;
        frame_color = "#007AFF";
        corner_radius = 10;
      };
      urgency_low = {
        background = "#F2F2F7";
        foreground = "#000000";
        timeout = 10;
      };
      urgency_normal = {
        background = "#007AFF";
        foreground = "#FFFFFF";
        timeout = 10;
      };
      urgency_critical = {
        background = "#FF3B30";
        foreground = "#FFFFFF";
        frame_color = "#FF3B30";
        timeout = 0;
      };
    };
  };
}

