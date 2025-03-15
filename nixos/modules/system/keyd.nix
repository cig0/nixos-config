{ ... }:

{
  services.keyd = {
    enable = true;

    keyboards = {
      # Portable keyboard
      SINOWealthGaming = {
        ids = [ "258a:002a" ];
        settings = {
          main = {
            "capslock" = "capslock";
          };
          shift = {
            "capslock" = "insert";
          };
        };
      };
    };
  };
}
