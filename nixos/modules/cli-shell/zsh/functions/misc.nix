# Don't remove this line! This is a NixOS Zsh function module.

{ ... }:

let
  functions = ''
    bkp() {
      source="''${1}"
      cp -i "$source" "$source.bkp"
    }

    freemem() {
      printf '\n=== Superuser password required to elevate permissions ===\n\n'
      su -c "echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\\n%s\\n' 'RAM-cache and Swap Cleared'" root
    }
  '';

in { functions = functions; }