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
      term = "ghostty";
    };
    style = ''
      window {
        margin: 0px;
        border: 2px solid #4c566a;
        background-color: #2e3440;
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
        color: #d8dee9;
        background-color: #4c566a;
      }
  
      #inner-box {
        margin: 5px;
        border: none;
        background-color: #2e3440;
      }
  
      #outer-box {
        margin: 5px;
        border: none;
        background-color: #2e3440;
      }
  
      #scroll {
        margin: 0px;
        border: none;
      }
  
      #text {
        margin: 5px;
        border: none;
        color: #d8dee9;
      }
  
      #entry:selected {
        background-color: #4c566a;
        border-radius: 5px;
      }
    '';
  };
}

