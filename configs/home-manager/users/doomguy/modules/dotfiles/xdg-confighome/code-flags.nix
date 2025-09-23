{
  config,
  ...
}:
{
  home.file."${config.xdg.configHome}/code-flags.conf".text = ''
    --enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer,VaapiVideoDecodeLinuxGL,ZeroCopy,CanvasOopRasterization
    --ozone-platform=wayland
    --enable-accelerated-2d-canvas
    --enable-gpu-rasterization
  '';
}
