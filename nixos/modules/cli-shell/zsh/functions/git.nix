# Don't remove this line! programs.zsh.shellFunctions

{ ... }:

let
  functions = ''
    lg() {
      local repo_path="${1:-$(pwd)}"
      local git_dir="${repo_path%/}/.git"
      local work_tree="${repo_path%/}"

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
