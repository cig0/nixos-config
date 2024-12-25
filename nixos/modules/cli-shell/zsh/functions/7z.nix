# Don't remove this line! programs.zsh.shellFunctions

{ ... }:

let
  # === ANSI escape codes for colors ===
  # Note the double forward slash for the escape sequences !
  # Otherwise Nix will render the content of the string like
  # regular characters.
  bold_green = "\\e[1;32m";
  bold_white = "\\e[1;97m";
  italic = "\\033[3m";
  reset = "\\e[0m"; # ANSI escape code for resetting text attributes

  # Description
  function = ''
    7za9() {
      [[ -z $1 ]] || [[ -z $2 ]] && \
      echo -e "\n${bold_white}Missing arguments!${reset}\n\nSyntax: ${bold_green}7za9 ${bold_white}${italic}output_file.${bold_green}7z ${bold_white}input_file_or_dir${reset}" && \
        return 1
      7z a -mx=9 -m0=lzma2 -mmt=on "$1".7z "$2"
    }
  '';

in {
  function = function;
}