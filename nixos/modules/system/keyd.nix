{ ... }:

{
  services.keyd = {
    enable = true;

    keyboards = {
      SINOWealthGaming = {  # Portable keyboard.
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