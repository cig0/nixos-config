# Home Manager Zsh functions module. Do not remove this header.
{
  libAnsiColors,
  ...
}:
let
  functions = ''
    7za9() {
      [[ -z $1 ]] || [[ -z $2 ]] && \
      echo -e "\n${libAnsiColors.bold_white}Missing arguments!${libAnsiColors.reset}\n\nSyntax: ${libAnsiColors.bold_green}7za9 ${libAnsiColors.bold_white}${libAnsiColors.italic}output_file.${libAnsiColors.bold_green}7z ${libAnsiColors.bold_white}input_file_or_dir${libAnsiColors.reset}" && \
        return 1
      7z a -mx=9 -m0=lzma2 -mmt=on "$1".7z "$2"
    }
  '';
in
{
  inherit functions;
}
