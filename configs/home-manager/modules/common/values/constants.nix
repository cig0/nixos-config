nixosConfig: {
  gitDirWorkTreeFlake = "--git-dir=${nixosConfig.myNixos.myOptions.flakeSrcPath}/.git --work-tree=${nixosConfig.myNixos.myOptions.flakeSrcPath}";
}
