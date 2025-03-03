# Don't remove this line! This is a NixOS Zsh alias module.
{ ... }:
let
  # Interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands
  # Homepage: https://dystroy.org/broot/
  aliases = {
    br = "--no-only-folders --no-hidden --tree --sort-by-type-dirs-first --no-whale-spotting";
  };
in
{
  aliases = aliases;
}
