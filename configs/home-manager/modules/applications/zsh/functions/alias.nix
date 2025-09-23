# Home Manager Zsh functions module. Do not remove this header.
{
  libAnsiColors,
  ...
}:
let
  # Aliases helper functions.
  functions = ''
    alse() {
      [[ -z $1 ]] && \
        echo -e "\n${libAnsiColors.bold_white}Missing alias to search!${libAnsiColors.reset}\n\nSyntax: ${libAnsiColors.bold_green}alse ${libAnsiColors.italic}alias_to_search${libAnsiColors.reset}" && \
          return 1
      alias | grep --color=always --ignore-case "$1"
    }
  '';
in
{
  inherit functions;
}
