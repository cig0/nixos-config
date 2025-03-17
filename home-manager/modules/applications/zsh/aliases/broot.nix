# Home Manager Zsh aliases module. Do not remove this header.
{ ... }:
let
  # Interactive tree view, a fuzzy search, a balanced BFS descent and customizable commands
  # Homepage: https://dystroy.org/broot/
  aliases = {
    br = "broot --no-only-folders --no-hidden --tree --sort-by-type-dirs-first --no-whale-spotting";
  };
in
{
  aliases = aliases;
}
