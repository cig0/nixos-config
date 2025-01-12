# Don't remove this line! programs.zsh.shellInit

{ ... }:

let
  functions = ''
    cm() {
      chezmoi --color true --progress true "$@"
    }

    compdef cm=chezmoi
  '';

in { functions = functions; }