# Home Manager Zsh functions module. Do not remove this header.
{
  ansiColors,
  ...
}:
let
  functions = ''
    7za9() {
      [[ -z $1 ]] || [[ -z $2 ]] && \
      echo -e "\n${ansiColors.bold_white}Missing arguments!${ansiColors.reset}\n\nSyntax: ${ansiColors.bold_green}7za9 ${ansiColors.bold_white}${ansiColors.italic}output_file.${ansiColors.bold_green}7z ${ansiColors.bold_white}input_file_or_dir${ansiColors.reset}" && \
        return 1
      7z a -mx=9 -m0=lzma2 -mmt=on "$1".7z "$2"
    }
  '';
in
{
  inherit functions;
}
