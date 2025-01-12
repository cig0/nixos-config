# Don't remove this line! This is a NixOS Zsh function module.

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