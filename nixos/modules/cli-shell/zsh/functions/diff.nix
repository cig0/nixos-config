# Don't remove this line! programs.zsh.shellFunctions

{ ... }:

let
  functions = ''
    diffstring() {
      # Using delta :: https://github.com/dandavison/delta
      d <(echo "$1") <(echo "$2")
    }
  '';

in { functions = functions; }