# Don't remove this line! This is a NixOS Zsh function module.

{ ... }:

let
  functions = ''
    cm() {
      chezmoi --color true --progress true "$@"
    }

    compdef cm=chezmoi
  '';

in { functions = functions; }