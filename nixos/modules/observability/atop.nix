{ ... }:

{
  programs.atop = {
    enable = true;
    interval = 60;
    logFile = "/var/log/atop.log";
  };
}