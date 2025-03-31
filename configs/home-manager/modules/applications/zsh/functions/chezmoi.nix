# Home Manager Zsh functions module. Do not remove this header.
{ ... }:
let
  functions = ''
    cm() {
      chezmoi --color true --progress true "$@"
    }

    compdef cm=chezmoi
  '';
in
{
  inherit functions;
}
