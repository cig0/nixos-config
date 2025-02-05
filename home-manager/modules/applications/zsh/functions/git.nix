# Don't remove this line! This is a NixOS Zsh function module.
{...}: let
  ansiColors = import ../ansi-colors.nix {};
  functions = ''
    gd() {
      # TL;DR: git diff
      # Description:
      #   By default, provides a `git diff` of all modified files, skipping `flake.lock` if it exists (notifying the user).
      #   Also allows for `git diff` of individual files.

      payload=("flake.lock")

      # Check if files in payload are modified and notify
      skipped=()
      for fileName in ''${payload[@]}; do
        if git diff --quiet "$fileName" 2>/dev/null; then
          : # File is not modified, do nothing
        else
          skipped+=("$fileName")
        fi
      done

      if [ ''${#skipped[@]} -gt 0 ]; then
        echo -e "\\n${ansiColors.bold_white}=== ${ansiColors.bold_white}Skipping${ansiColors.reset} modified file(s): ${ansiColors.bold_green}$(printf "%s " ''${skipped[@]})${ansiColors.reset}"
      fi

      # Perform git diff based on arguments
      if [ $# -eq 0 ]; then
        # Default behavior: diff all modified files except those in payload
        git diff -- $(git ls-files --modified | grep -vxFf <(printf "%s\n" ''${payload[@]}))
      else
        # Diff only the specified files, excluding those in payload
        to_diff=()
        for fileName in "$@"; do
          if [[ " ''${payload[@]} " =~ " $fileName " ]]; then
            echo -e "${ansiColors.reset}=== ${ansiColors.bold_white}Skipping file: ${ansiColors.bold_green}$fileName${ansiColors.reset}"
          else
            to_diff+=("$fileName")
          fi
        done
        if [ ''${#to_diff[@]} -gt 0 ]; then
          git diff -- ''${to_diff[@]}
        fi
      fi
    }
  '';
in {functions = functions;}
