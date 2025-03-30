{
  config,
  lib,
  ...
}:

{
  options.mySystem.programs.lazygit = {
    enable = lib.mkEnableOption "Whether to enable lazygit, a simple terminal UI for git commands.";
  };

  config = lib.mkIf config.mySystem.programs.lazygit.enable {
    programs.lazygit = {
      enable = true;
      settings = {
        gui = {
          scrollPastBottom = false;
        };

        git = {
          commit = {
            signOff = true;
            autoWrapCommitMessage = true;
          };
          merging = {
            manualCommit = true;
          };
          update = {
            method = "background";
            days = 14;
          };
          os = {
            edit = "${config.mySystem.myOptions.cli.editor} {{filename}}";
            editAtLine = "${config.mySystem.myOptions.cli.editor} {{filename}} +{{line}}";
            editInTerminal = true;
            openDirInEditor = "${config.mySystem.myOptions.cli.editor} {{dir}}";
          };
        };

        promptToReturnFromSubprocess = false;
      };
    };

    /*
      After commit c824181 fix: hopefully fixed the way I was handling NH's FLAKE shell envvar
      the NixOS options are working again.

      I'm keeping this configuration around for a bit in case I need it again (hopefully not), and
      for reference.
    */
    /*
      environment.etc."lazygit".text = ''
        gui:
          scrollPastBottom: false
        git:
          commit:
            signOff: true
            autoWrapCommitMessage: true
          merging:
              manualCommit: true
          update:
            method: "background"
            days: 14
          os:
            edit: "${config.mySystem.myOptions.cli.editor} {{filename}}"
            editAtLine: "${config.mySystem.myOptions.cli.editor} {{filename}} +{{line}}"
            editInTerminal: true
            openDirInEditor: "${config.mySystem.myOptions.cli.editor} {{dir}}"
        promptToReturnFromSubprocess: false
      '';
    */
  };
}
