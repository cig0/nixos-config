# Don't remove this line! programs.zsh.shellInit

{ ... }:

let
  functions = ''
    zr() {  # zsh_reload
      if [ -n "$(jobs)" ]; then
        print -P "Error: %j job(s) in background"
      else
        [[ -n "$ORIGINAL_PATH" ]] && export PATH="$ORIGINAL_PATH"
        exec zsh
      fi
    }
  '';

in { functions = functions; }