# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  aichat = {
    # Google Gemini
    aG = "aichat -m gemini";
    aGc = "aichat -m gemini --code";
    aGl = "aichat -m gemini --list-sessions";
    aGs = "aichat -m gemini --session";
  };

in {
  aichat = aichat;
}