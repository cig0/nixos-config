# Don't remove this line! programs.zsh.shellInit

{ ansiColors, ... }:

let
  # Aliases helper functions.
  functions = ''
    alse() {
      [[ -z $1 ]] && \
        echo -e "\n${ansiColors.bold_white}Missing alias to search!${ansiColors.reset}\n\nSyntax: ${ansiColors.bold_green}alse ${ansiColors.italic}alias_to_search${ansiColors.reset}" && \
          return 1
      alias | grep --color=always --ignore-case "$1"
    }
  '';

in { functions = functions; }