{ ... }:
{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    flags = [ "--disable-up-arrow" ];
    settings = {
      auto_sync = true;
      inline_height = "45";
      search_mode = "prefix";
      sync_address = "https://api.atuin.sh";
      sync_frequency = "5m";
      update_check = false;
      workspaces = false;
    };
  };
}
