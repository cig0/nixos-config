{
  role,
  laptopSettings,
  desktopSettings,
  homeLabSettings,
}: let
  selector =
    if role == "laptop"
    then laptopSettings
    else if role == "desktop"
    then desktopSettings
    else if role == "home-lab"
    then homeLabSettings
    else throw "Invalid role: ${role}";
in
  selector
