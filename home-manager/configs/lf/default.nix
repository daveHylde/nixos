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
      
      # Fzf keybindings
      f = "fzf_home";        # Find file from home
      F = "fzf_cd";          # Find directory from home  
      "<c-o>" = "fzf_open";  # Find and open file in editor
    };

    extraConfig = ''
      set cleaner ${pkgs.writeShellScript "lf-cleaner" ''
        if [ -n "$FIFO_UEBERZUG" ]; then
          printf '{"action": "remove", "identifier": "PREVIEW"}\n' > "$FIFO_UEBERZUG"
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
          ${pkgs.chafa}/bin/chafa --size="''${w}x''${h}" "$file" 2>/dev/null && exit
          ;;
        image/svg+xml)
          # Convert SVG to PNG and display with chafa
          ${pkgs.librsvg}/bin/rsvg-convert "$file" | ${pkgs.chafa}/bin/chafa --size="''${w}x''${h}" - 2>/dev/null && exit
          ;;
        text/* | application/json | application/javascript | application/x-sh)
          ${pkgs.bat}/bin/bat --color=always --style=numbers --line-range=:500 "$file" 2>/dev/null
          ;;
        application/pdf)
          # Try converting first page to image, fallback to text
          ${pkgs.poppler_utils}/bin/pdftoppm -f 1 -l 1 -png "$file" | ${pkgs.chafa}/bin/chafa --size="''${w}x''${h}" - 2>/dev/null && exit
          ${pkgs.poppler_utils}/bin/pdftotext "$file" - | head -500
          ;;
        application/vnd.openxmlformats-officedocument.wordprocessingml.document)
          # Extract text from DOCX
          ${pkgs.pandoc}/bin/pandoc "$file" -t plain 2>/dev/null | head -500
          ;;
        *)
          ${pkgs.file}/bin/file -Lb "$file"
          ;;
      esac
    '';
  };
}

