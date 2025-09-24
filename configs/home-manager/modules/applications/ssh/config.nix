{
  ...
}:
{
  home.file.".ssh/config".text = ''
      # ------- Handy stuff -------
    # https://linuxcommando.blogspot.com.ar/2008/10/how-to-disable-ssh-host-key-checking.html
    #
    # Git commits GPG signing:
    # https://help.github.com/articles/telling-git-about-your-signing-key/#telling-git-about-your-gpg-key

    # ===[ Common configs ]===
    Host *
        # AddKeysToAgent yes
        StrictHostKeyChecking no
        UserKnownHostsFile=/dev/null

        # https://code.visualstudio.com/docs/remote/troubleshooting#_enabling-alternate-ssh-authentication-methods
        ControlMaster auto
        #ControlPath  ~/.ssh/sockets.d/%r@%h-%p
        ControlPersist  60

    # ===[ Includes ]===
    Include config.d/h-d
  '';
}
