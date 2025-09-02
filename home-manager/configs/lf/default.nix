{ pkgs, ... }:

{
  programs.lf = {
    enable = true;
    
    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
    };

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor = ''$$EDITOR "$f"'';
      mkdir = ''
        ''${{
          printf "Directory Name: "
          read DIR
          mkdir "$DIR"
        }}
      '';
      
      # Open with menu
      open_with = ''
        ''${{
          # Common applications menu
          app="$(printf "Default\nText Editor\nVSCode\nPinta\nGimp\nFirefox\nMPV\nCustom Command" | ${pkgs.fzf}/bin/fzf --prompt="Open with: " --height=10 --reverse)"
          
          case "$app" in
            "Default") 
              lf -remote "send ''${id} open" 
              ;;
            "Text Editor") 
              ''$EDITOR "$f" 
              ;;
            "VSCode")
              ${pkgs.vscode}/bin/code "$f" &
              ;;
            "Pinta") 
              ${pkgs.pinta}/bin/pinta "$f" & 
              ;;
            "Gimp") 
              ${pkgs.gimp3}/bin/gimp3 "$f" & 
              ;;
            "Firefox") 
              ${pkgs.firefox}/bin/firefox "$f" & 
              ;;
            "MPV") 
              ${pkgs.mpv}/bin/mpv "$f" & 
              ;;
            "Custom Command")
              printf "Command: "
              read cmd
              $cmd "$f"
              ;;
          esac
        }}
      '';
      
      # Alternative: simple open with using system apps
      open_with_system = ''
        ''${{
          printf "Application: "
          read app
          $app "$f" &
        }}
      '';
      
      # Fzf integration - find and navigate to file from home
      fzf_home = ''
        ''${{
          res="$(${pkgs.fd}/bin/fd --type f . ~ | ${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat --color=always {} 2>/dev/null || head -20 {}' --reverse --header='Jump to file')"
          if [ -f "$res" ]; then
            dir="$(dirname "$res")"
            lf -remote "send ''${id} cd \"$dir\""
            lf -remote "send ''${id} select \"$res\""
          fi
        }}
      '';
      
      # Fzf - find directory from home and cd to it
      fzf_cd = ''
        ''${{
          dir="$(${pkgs.fd}/bin/fd --type d . ~ | ${pkgs.fzf}/bin/fzf --reverse --header='Change directory')"
          [ -d "$dir" ] && lf -remote "send ''${id} cd \"$dir\""
        }}
      '';
      
      # Fzf - find and open file in editor
      fzf_open = ''
        ''${{
          file="$(${pkgs.fd}/bin/fd --type f . ~ | ${pkgs.fzf}/bin/fzf --preview '${pkgs.bat}/bin/bat --color=always {} 2>/dev/null || head -20 {}')"
          [ -n "$file" ] && ''$EDITOR "$file"
        }}
      '';
    };

    keybindings = {
      "." = "set hidden!";
      DD = "delete";
      p = "paste";
      x = "cut";
      y = "copy";
      "<enter>" = "open";
      mf = "mkfile";
      md = "mkdir";
      C = "clear";
      R = "reload";
      U = "unselect";
      
      # Open with options
      o = "open_with";           # Open with menu
      O = "open_with_system";    # Simple open with prompt
      
      # Fzf keybindings
      f = "fzf_home";        # Find file from home
      F = "fzf_cd";          # Find directory from home  
      "<c-o>" = "fzf_open";  # Find and open file in editor
    };

    extraConfig = ''
      set cleaner ${pkgs.writeShellScript "lf-cleaner" ''
        if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
          printf '\e]5555;remove\e\\' > /dev/tty
        fi
      ''}
    '';
    
    previewer.source = pkgs.writeShellScript "lf-previewer" ''
      file="$1"
      w="$2"
      h="$3"
      x="$4"
      y="$5"
    
      case "$(${pkgs.file}/bin/file -Lb --mime-type "$file")" in
        image/*)
          if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
            ${pkgs.chafa}/bin/chafa -f symbol --size="''${w}x''${h}" "$file" 2>/dev/null && exit
          else
            ${pkgs.chafa}/bin/chafa --size="''${w}x''${h}" "$file" 2>/dev/null && exit
          fi
          ;;
        image/svg+xml)
          if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
            ${pkgs.librsvg}/bin/rsvg-convert "$file" | ${pkgs.chafa}/bin/chafa -f symbol --size="''${w}x''${h}" - 2>/dev/null && exit
          else
            ${pkgs.librsvg}/bin/rsvg-convert "$file" | ${pkgs.chafa}/bin/chafa --size="''${w}x''${h}" - 2>/dev/null && exit
          fi
          ;;
        text/* | application/json | application/javascript | application/x-sh)
          ${pkgs.bat}/bin/bat --color=always --style=numbers --line-range=:500 "$file" 2>/dev/null
          ;;
        application/pdf)
          if [ -n "$GHOSTTY_RESOURCES_DIR" ]; then
            ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 -png "$file" | ${pkgs.chafa}/bin/chafa --format=kitty --size="''${w}x''${h}" - 2>/dev/null && exit
          else
            ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 -png "$file" | ${pkgs.chafa}/bin/chafa --size="''${w}x''${h}" - 2>/dev/null && exit
          fi
          ${pkgs.poppler_utils}/bin/pdftotext "$file" - | head -500
          ;;
        application/vnd.openxmlformats-officedocument.wordprocessingml.document)
          ${pkgs.pandoc}/bin/pandoc "$file" -t plain 2>/dev/null | head -500
          ;;
				application/zip|application/x-rar|application/x-7z-compressed|application/x-tar|application/gzip)
					${pkgs.lesspipe}/bin/lesspipe.sh "$1" 2>/dev/null || batorcat "$1"
					;;
				*)
					${pkgs.lesspipe}/bin/lesspipe.sh "$1" 2>/dev/null || batorcat "$1" || echo "Cannot preview this file type"
					;;
      esac
    '';
  };
}
