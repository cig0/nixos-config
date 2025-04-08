# Don't remove this line! This is a NixOS Zsh function module.
# TODO: review this function; I believe Delta only works with git?
{
  ...
}:
let
  functions = ''
    diffstring() {
      # Using delta :: https://github.com/dandavison/delta
      d <(echo "$1") <(echo "$2")
    }
  '';
in
{
  inherit functions;
}
