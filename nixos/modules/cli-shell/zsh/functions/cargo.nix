# Don't remove this line! programs.zsh.shellInit

{ ansiColors, commonEnvSessionVars, ... }:

let
  functions = ''
    _upgrade.apps.cargo() {
      local action='Upgrading:'
      local payload='Cargo packages'
      echo -e "\\n\\n${ansiColors.bold_white}====  $action${ansiColors.reset} ${ansiColors.bold_green}$payload${ansiColors.reset}\\n"


      # Set the update execution bit:
      # 0 successful
      # 1 failed
      local update_state=0

      # Use shell evaluation of $XDG_CONFIG_HOME
      # file="$XDG_CONFIG_HOME/apps.cargo"
      file="${commonEnvSessionVars.xdgConfigHome}/apps.cargo"

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

in { functions = functions; }