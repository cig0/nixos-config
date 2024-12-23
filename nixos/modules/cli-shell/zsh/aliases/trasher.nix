# Don't remove this line! programs.zsh.shellAliases

{ ... }:

let
  # Trasher - https://crates.io/crates/trasher
  trasher = {
    rm = "trasher --exclude /var rm";
    rmp = "trasher --exclude /var rm -p";
    te = "trasher --exclude /var empty";
    tls = "trasher --exclude /var ls";
    tp = "trasher --exclude /var path-of";
  };

in {
  trasher = trasher;
}