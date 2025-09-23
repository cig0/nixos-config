{
  config,
  ...
}:
{
  home.file."${config.xdg.dataHome}/applications/code.desktop".text = ''
    [Desktop Action new-empty-window]
    Exec=code --new-window %F
    Icon=vscode
    Name=New Empty Window

    [Desktop Entry]
    Actions=new-empty-window
    Categories=Utility;TextEditor;Development;IDE
    Comment=Code Editing. Redefined.
    Exec=code '--enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecodeLinuxGL,ZeroCopy,CanvasOopRasterization\n--ozone-platform=wayland\n--enable-accelerated-2d-canvas\n--enable-gpu-rasterization' %F
    GenericName=Text Editor
    Icon=vscode
    Keywords=vscode
    Name=Visual Studio Code
    NoDisplay=false
    Path=
    StartupNotify=true
    StartupWMClass=Code
    Terminal=false
    TerminalOptions=
    Type=Application
    Version=1.4
    X-KDE-SubstituteUID=false
    X-KDE-Username=
  '';
}
