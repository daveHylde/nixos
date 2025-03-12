{ pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    extraConfig = ''
      general {
        disable_loading_bar = true
        hide_cursor = true
        grace = 0
        no_fade_in = false
      }

      background {
        path = /home/david/Pictures/space1.jpeg
        blur_size = 7
        blur_passes = 4
      }

      input-field {
        size = 300, 50
        outline_thickness = 3
        dots_size = 0.33
        dots_spacing = 0.15
        dots_center = false
        outer_color = rgb(151515)
        inner_color = rgb(200, 200, 200)
        font_color = rgb(10, 10, 10)
        fade_on_empty = true
        placeholder_text = <i>Input Password...</i>
        hide_input = false
      }

      label {
        text = $TIME
        color = rgba(200, 200, 200, 1.0)
        font_size = 50
        position = 0, 80
        valign = center
        halign = center
      }
    '';
  };
}

