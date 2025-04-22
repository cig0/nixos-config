# Home Manager Zsh functions module. Do not remove this header.
{
  libraryAnsiColors,
  ...
}:
let
  # Aliases helper functions.
  functions = ''
    alse() {
      [[ -z $1 ]] && \
        echo -e "\n${libraryAnsiColors.bold_white}Missing alias to search!${libraryAnsiColors.reset}\n\nSyntax: ${libraryAnsiColors.bold_green}alse ${libraryAnsiColors.italic}alias_to_search${libraryAnsiColors.reset}" && \
          return 1
      alias | grep --color=always --ignore-case "$1"
    }
  '';
in
{
  inherit functions;
}
