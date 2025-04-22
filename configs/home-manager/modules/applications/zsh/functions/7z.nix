# Home Manager Zsh functions module. Do not remove this header.
{
  libraryAnsiColors,
  ...
}:
let
  functions = ''
    7za9() {
      [[ -z $1 ]] || [[ -z $2 ]] && \
      echo -e "\n${libraryAnsiColors.bold_white}Missing arguments!${libraryAnsiColors.reset}\n\nSyntax: ${libraryAnsiColors.bold_green}7za9 ${libraryAnsiColors.bold_white}${libraryAnsiColors.italic}output_file.${libraryAnsiColors.bold_green}7z ${libraryAnsiColors.bold_white}input_file_or_dir${libraryAnsiColors.reset}" && \
        return 1
      7z a -mx=9 -m0=lzma2 -mmt=on "$1".7z "$2"
    }
  '';
in
{
  inherit functions;
}
