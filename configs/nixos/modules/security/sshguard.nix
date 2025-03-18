# TODO: needs option
{ ... }:

{
  services.sshguard = {
    enable = false;
    blocktime = 300;
    detection_time = 3600;
    # services = {
    #  cockpit
    #  sshd
    # };
  };
}
