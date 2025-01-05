# Don't remove this line! programs.zsh.shellInit

{ ... }:

let
  functions = ''
    CVS2JSON() {
      # TODO: add proper parameterization, help message, etc. (lowest prio)
      # Credits: Veronica Explains https://youtu.be/uL7KvRskeog?si=VkM7rRQD7QE-IkiA

      # Flags:
      # -t create a table
      # -s ":" use ":" as the field separator
      # -N set column names
      # -J use JSON format
      # -n use a non-interactive mode

      column -t -s ":" $1 -N USERNAME,PWD,UI,GUI,COMMENT,HOME,"SHELL INTERPRETER" -J -n myNewTable
    }
  '';

in { functions = functions; }