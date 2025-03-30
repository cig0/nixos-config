{
  ...
}:
{
  mySystem = {
    hardware = {
      graphics.enable = true;
      nvidia-container-toolkit.enable = true;

      # Radio
      bluetooth.enable = true;
    };

    myOptions = {
      hardware = {
        cpu = "intel";
        gpu = "nvidia";
      };
    };
  };
}
