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
      orientation = "vertical";
      insensitive = true;
      allow_images = true;
      image_size = 40;
      gtk_dark = true;
      term = "ghostty";
    };
    style = ''
      #input {
        margin: 0;
        border: 2px solid #4c566a;
        padding: 8px 12px;
        color: #eceff4;
        background-color: #3b4252;
        font-size: 14px;
      }
  
      #input:focus {
        border-color: #88c0d0;
        outline: none;
      }
    '';
  };
}

