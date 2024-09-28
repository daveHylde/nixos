{ pkgs, ... }:
{
  programs.wofi = {
    enable = true;
    settings = {
      width = "25%";
      height = "40%";
      location = "center";
      show = "drun";
      prompt = "Search...";
      filter_rate = 100;
      allow_markup = true;
      no_actions = true;
      halign = "fill";
      orientation = "vertical";
      content_halign = "fill";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
      layer = "overlay";
      term = "kitty";
      dynamic_lines = true;
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #414868;
        background-color: #24283b;
        border-radius: 15px;
        animation: slideIn 0.1s ease-in-out;
      }

      @keyframes slideIn {
        0% {
          opacity: 0;
          transform: translateY(-5%);
        }
        100% {
          opacity: 1;
          transform: translateY(0);
        }
      }

      #input {
        margin: 5px;
        border: none;
        color: #c0caf5;
        background-color: #414868;
      }

      #inner-box {
        margin: 5px;
        border: none;
        background-color: #24283b;
      }

      #outer-box {
        margin: 5px;
        border: none;
        background-color: #24283b;
      }

      #scroll {
        margin: 0px;
        border: none;
      }

      #text {
        margin: 5px;
        border: none;
        color: #c0caf5;
      }

      #entry:selected {
        background-color: #414868;
        border-radius: 5px;
      }
    '';
  };
}

