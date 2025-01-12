# Don't remove this line! programs.zsh.shellInit

{ ... }:

let
  # Jumpy - https://github.com/ClementNerma/Jumpy
  functions = ''
    j() {
      local result=$(jumpy query "$1" --checked --after "$PWD")
      if [[ -n $result ]]; then
          export __JUMPY_DONT_REGISTER=1
          cd "$result"
          export __JUMPY_DONT_REGISTER=0
      fi
    }

    jumpy_handler() {
        if (( $__JUMPY_DONT_REGISTER )); then
            return
        fi
        emulate -L zsh
        jumpy inc "$PWD"
    }

    chpwd_functions+=("jumpy_handler")
  '';

in { functions = functions; }