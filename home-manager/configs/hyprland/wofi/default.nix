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
        border: 2px solid #5e81ac;
        background-color: #2e3440;
        border-radius: 15px;
        animation: slideIn 0.1s ease-in-out;
        overflow: hidden;
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
        border: 2px solid #4c566a;
        border-radius: 8px;
        padding: 8px 12px;
        color: #eceff4;
        background-color: #3b4252;
        font-size: 14px;
      }
  
      #input:focus {
        border-color: #88c0d0;
        outline: none;
      }
  
      #inner-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }
  
      #outer-box {
        margin: 5px;
        border: none;
        background-color: transparent;
      }
  
      #scroll {
        margin: 0px;
        border: none;
      }
  
      #text {
        margin: 5px;
        border: none;
        color: #e5e9f0;
        padding: 8px 12px;
      }
  
      #entry {
        border-radius: 8px;
        margin: 2px 8px;
        padding: 4px;
      }
  
      #entry:selected {
        background-color: #434c5e;
        border-radius: 8px;
        color: #eceff4;
      }
  
      #entry:hover {
        background-color: #3b4252;
        border-radius: 8px;
      }
  
      #entry:selected #text {
        color: #88c0d0;
        font-weight: bold;
      }
    '';
  };
}

