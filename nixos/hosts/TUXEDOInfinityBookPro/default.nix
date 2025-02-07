#                                                               dMP dMP .aMMMb  .dMMMb dMMMMMMP
#                                                              dMP dMP dMP"dMP dMP" VP   dMP
#                                                             dMMMMMP dMP dMP  VMMMb    dMP
#                                                            dMP dMP dMP.aMP dP .dMP   dMP
#                                                           dMP dMP  VMMMP"  VMMMP"   dMP
#
#      .aMMMb  .aMMMb  dMMMMb  dMMMMMP dMP .aMMMMP dMP dMP dMMMMb  .aMMMb dMMMMMMP dMP .aMMMb  dMMMMb
#     dMP"VMP dMP"dMP dMP dMP dMP     amr dMP"    dMP dMP dMP.dMP dMP"dMP   dMP   amr dMP"dMP dMP dMP
#    dMP     dMP dMP dMP dMP dMMMP   dMP dMP MMP"dMP dMP dMMMMK" dMMMMMP   dMP   dMP dMP dMP dMP dMP
#   dMP.aMP dMP.aMP dMP dMP dMP     dMP dMP.dMP dMP.aMP dMP"AMF dMP dMP   dMP   dMP dMP.aMP dMP dMP
#   VMMMP"  VMMMP" dMP dMP dMP     dMP  VMMMP"  VMMMP" dMP dMP dMP dMP   dMP   dMP  VMMMP" dMP dMP
{
  imports = builtins.filter (x: x != null) [
    ./configuration.nix
    ./options.nix
  ];
}
