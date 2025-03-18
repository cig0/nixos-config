# Home Manager Zsh functions module. Do not remove this header.
{
  ansiColors,
  config,
  ...
}:
let
  functions = ''
    _upgrade-apps-cargo() {
      local action='Upgrading:'
      local payload='Cargo packages'
      echo -e "\\n\\n${ansiColors.bold_white}====  $action${ansiColors.reset} ${ansiColors.bold_green}$payload${ansiColors.reset}\\n"


      # Set the update execution bit:
      # 0 successful
      # 1 failed
      local update_state=0

      file="$HOME/${config.xdg.configFile."apps-cargo".target}"

      if [ ! -f "$file" ]; then
        echo "Error: $file not found"
        return 1
      fi

      while IFS= read -r line; do
        # Fix: properly escape the pattern matching for comments
        if [[ ! $line =~ ^[[:space:]]*# && ! -z $line ]]; then
          command cargo binstall --continue-on-failure --locked --no-discover-github-token --root "$HOME/.cargo" -y "$line"
          if [[ $? -ne 0 ]]; then
            update_state=1
          fi
        fi

        if [[ $update_state -eq 1 ]]; then
          break
        fi
      done < "$file"
    }
  '';
in
{
  functions = functions;
}
