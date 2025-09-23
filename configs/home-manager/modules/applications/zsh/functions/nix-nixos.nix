# Home Manager Zsh functions module. Do not remove this header.
{
  nixosConfig,
  self,
  ...
}:
let
  functions = ''
    # Hydra
      hc() {  # 'hydra-check' with the `nixos-25.05` channel
        hydra-check --arch x86_64-linux --channel 25.05 "$1"
      }

      hcs() {  # `hydra-check` with the `staging` channel
        hydra-check --arch x86_64-linux --channel staging "$1"
      }

      hcu() {  # `hydra-check` with the `unstable` channel
        hydra-check --arch x86_64-linux --channel unstable "$1"
      }

      nhos() {
      # Build NixOS generations with secrets management.
      # Stages secrets in the Git index, runs 'nh os <action> <flake-path> -- --show-trace',
      # and unstages secrets. Handles Ctrl+C and errors by unstaging secrets and returning 1.
      # Usage: nhos [action] [flags], e.g., 'nhos switch', 'nhos boot --dry'.
      # Check ../aliases/nix-nixos.nix for handy aliases.
      # Defaults to 'switch --dry' if no action provided.

        # Disable errexit and enable pipefail
        set +o errexit
        set -o pipefail

        # Common exit function
        exit_with_message() {
          printf "Secrets files successfully unstaged. Exiting.\n"
          return 1
        }

        # Unstaging and status function
        cleanup_secrets() {
          # Disable ERR trap to prevent recursive calls
          trap - ERR
          printf "Unstaging secrets...\n"
          git ${c.gitDirWorkTreeFlake} restore --staged ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets
          git ${c.gitDirWorkTreeFlake} status --short --branch
          # Only return if called from a trap
          [[ -n "$1" ]] && exit_with_message
        }

        # Trap SIGINT (Ctrl+C)
        trap '{
          printf "\nCaught Ctrl+C!\n"
          cleanup_secrets trap
          trap - SIGINT
          return 1
        }' SIGINT

        # Trap ERR
        trap '{
          printf "\nError: Command failed with status $?\n"
          cleanup_secrets trap
          trap - ERR
          return 1
        }' ERR

        # Validate variables
        [[ -z "${c.gitDirWorkTreeFlake}" || -z "${nixosConfig.myNixos.myOptions.flakeSrcPath}" ]] && {
          printf "Error: Git or flake path variables unset!\n"
          return 1
        }

        local nh_args=()
        local build_args=()
        local separator_found=0

        # Separate arguments for nh and the build command based on '--'
        for arg in "$@"; do # Iterate over original args passed to the function
          if [[ "$arg" == "--" ]]; then
            separator_found=1
            continue # Skip the separator itself
          fi
          if [[ "$separator_found" -eq 1 ]]; then
            build_args+=("$arg")
          else
            nh_args+=("$arg")
          fi
        done

        # If no arguments were provided for 'nh os' (before --), default them.
        if [[ ''${#nh_args[@]} -eq 0 ]]; then
            if [[ $# -eq 0 ]]; then # No arguments at all were passed to nhos
                print "Warning: No action provided, defaulting to 'switch --dry'\n"
                nh_args=(switch --dry)
            else # Arguments were passed, but only build args (e.g., nhos -- --fast)
                print "Warning: No 'nh os' action provided, defaulting to 'switch --dry'\n"
                nh_args=(switch --dry) # Default the action part
            fi
        fi

        # Stage secrets
        git ${c.gitDirWorkTreeFlake} add ${nixosConfig.myNixos.myOptions.flakeSrcPath}/secrets

        # Run nh os with separated arguments, adding --show-trace and any extra build_args
        nh os "''${nh_args[@]}" ${nixosConfig.myNixos.myOptions.flakeSrcPath} -- --show-trace "''${build_args[@]}"

        # Unstage secrets and show status
        cleanup_secrets
        # Unset traps before returning
        trap - SIGINT ERR
        return 0
      }

    # Nix shell
      # `nix shell` packages from nixpkgs
      nixsh() {  # `nix shell` packages from nixpkgs
        local p
        for p in "$@"; do
          NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs#$p
        done
      }

      # `nix shell` packages from nixpkgs/nixos-unstable
      nixshu() {  # `nix shell` packages from nixpkgs/nixos-unstable
        local p
        for p in "$@"; do
          NIXPKGS_ALLOW_UNFREE=1 nix shell --impure nixpkgs/nixos-unstable#$p
        done
      }

    # Search (options and packages)
      manix() {
        case "$#" in
          0)
            # No arguments: run the fuzzy-finder-based command
            manix "" | \
              grep '^# ' | \
              sed 's/^# \(.*\) (.*)/\1/;s/ (.*//;s/^# //' | \
              fzf --preview="command manix '{}'" | \
              xargs manix
            ;;
          *)
            # With arguments: pass them to the manix binary
            command manix "$@"
            ;;
        esac
      }

    # System
      nixcv() {  # Outputs the Nix channel version.
        local channel_version="$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version')"
        echo -e "\n$bold_greenNix channel version: $bold_white$channel_version$reset"
      }
  '';
  c = import "${self}/configs/home-manager/modules/common/values/constants.nix" nixosConfig;
in
{
  inherit functions;
}
