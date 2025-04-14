# Home Manager Zsh aliases module. Do not remove this header.
{
  ...
}:
let
  aliases = {
    gpgc = "gpg -c --cipher-algo aes256 --output";
    gpgcs = "gpg --symmetric --cipher-algo AES256 --output";
    gpgd = "gpg -d";

    # Compress and encrypt files & dirs using GNU GPG
    gpgtare = "gpgtar --encrypt --symmetric --gpg-args --cipher-algo aes256 --output"; # input_folder/output_file input_folder.
  };
in
{
  inherit aliases;
}
