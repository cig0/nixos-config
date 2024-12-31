# Don't remove this line! programs.zsh.shellFunctions

{ ansiColors, ... }:

let
   # Update Cargo-installed packages described in $XDG_CONFIG_HOME/apps.cargo
  functions = ''
    apps.cargo() {
      funcname="\${funcstack[0]}"
      echo -e "\\n\\n${ansiColors.bold_white}====  Running ${ansiColors.bold_green}\${funcname}${ansiColors.reset} ${ansiColors.bold_white}update target...${ansiColors.reset}\\n"

      # Set the update execution bit:
      # 0 successful
      # 1 failed
      local update_state=0

      # cargo install-update -a
      file="\$XDG_CONFIG_HOME/apps.cargo"
      while IFS= read -r line; do
        if [[ ! "\$line" =~ ^# ]]; then
          [[ -z "\$line" ]] && continue || \
            command cargo binstall --continue-on-failure --locked --no-discover-github-token --root "\$HOME/.cargo" -y "\$line"
          if [[ \$? -ne 0 ]]; then
            update_state=1
          fi
        fi

        if [[ \$update_state -eq 1 ]]; then
          break
        fi
      done < "\$file"
    }
  '';

in { functions = functions; }