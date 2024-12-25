# Don't remove this line! programs.zsh.shellFunctions

{ ... }:

let
  functions = ''
    lg() {
      local repo_path="''${1:-$(pwd)}"
      local git_dir="''${repo_path%/}/.git"
      local work_tree="''${repo_path%/}"

      if [[ ! -d "$git_dir" ]]; then
        echo "Error: '$repo_path' is not a Git repository"
        return 1
      fi

      git --git-dir="$git_dir" --work-tree="$work_tree" status --short --branch
    }
  '';

in {
  functions = functions;
}


# README!
# =======

# 1. **The Problem**
#    - In shell scripts, `${var}` is used for variable expansion
#    - In Nix strings, `${expr}` is used for interpolation
#    - This creates a conflict when writing shell scripts inside Nix

# 2. **The Solution**
#    - Nix uses `''` for multi-line strings
#    - Inside these strings, `''${...}` escapes shell variables
#    - The first `''` is interpreted by Nix as string start
#    - The second `'` combines with the first to escape `${`
#    - This prevents Nix from trying to interpolate shell variables

# 3. **Example Breakdown**
# ```nix
# # Normal shell:
# local repo_path="${1:-$(pwd)}"

# # In Nix string:
# local repo_path="''${1:-$(pwd)}"
# #              ^^-- escape sequence
# ```

# 4. **Why It Works**
#    - When Nix evaluates the string, it removes one `'`
#    - The resulting shell script sees: `${1:-$(pwd)}`
#    - Shell then properly interprets the variable expansion

# This is a common pattern when writing shell scripts in Nix configuration files.