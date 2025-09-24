{
  config,
  nixosConfig,
  ...
}:
{
  xdg.configFile."git/gitconfig-work".text = ''
    # Ref: https://git-scm.com/docs/pretty-formats.
    [commit]
      gpgSign = true

    [core]
      sshCommand = "ssh -i ${config.home.homeDirectory}/.ssh/keys/h-d/HDcigorrm -o IdentitiesOnly=yes"

    [gpg]
      format = ssh

    # Default fetch refspec for all remotes from H-D
    # [remote "origin"]
    #   fetch = +refs/heads/develop:refs/remotes/origin/develop

    [user]
      name = "Martín Cigorraga";
      email = "${nixosConfig.mySecrets.getSecret "shared.home-manager.git.github.work.email"}";
      signingKey = "${config.home.homeDirectory}/.ssh/keys/h-d/HDcigorrm";
  '';
}
