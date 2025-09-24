# Home Manager Zsh functions module. Do not remove this header.
{
  ...
}:
let
  functions = ''
    a() {
      setopt null_glob
      hidden_found=false
      for entry in .*; do
        [[ $entry != "." && $entry != ".." ]] && hidden_found=true && break
      done
      $hidden_found && ls -dl --color=always --group-directories-first .??* || echo -e '\nNo hidden files found.\e[0m'
      unsetopt null_glob
    }

    la() {
      setopt null_glob
      hidden_found=false
      for entry in .*; do
        [[ $entry != "." && $entry != ".." ]] && hidden_found=true && break
      done
      $hidden_found && ls -dl --color=always --group-directories-first .??* || echo -e '\nNo hidden files found.\e[0m'
      unsetopt null_glob
    }
  '';
in
{
  inherit functions;
}
