{ pkgs, ...}:
{
  enable = true;
  hooks.postswitch = {
    "set wallpaper" = "${pkgs.i3}/bin/i3-msg reload";
    #"restart compton" = "killall compton"; 
  };
  profiles = {
#     "home-4k" = {
#       fingerprint = {
#         eDP-1 = 
# "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
#         DP-2 = 
# "00ffffffffffff000469a328490200001a1a0104b53e22783a1cb5a3574fa0270d5054bfef00d1c0814081809500b300714f81c001014dd000a0f0703e80302035006d552100001aa36600a0f0701f80302035006d552100001a000000fd001e5018a03c041100f0f838f03c000000fc0041535553205042323837510a20015702031c714f0102031112130414051f900e0f1d1e2309170783010000565e00a0a0a02950302035006d552100001ee26800a0a0402e60302036006d552100001a011d00bc52d01e20b82855406d552100001e8c0ad090204031200c4055006d552100001800000000000000000000000000000000000000000000000000000090";
#       };
#       config = {
#         eDP-1 = {
#           enable = true;
#           primary = true;
#           mode = "2560x1440";
#           position = "0x2160";
#           rate = "60.01";
#         };
#         DP-1 = {
#           enable = true;
#           mode = "3840x2160";
#           position = "0x0";
#           rate = "60.00";
#         };
#       };
#     };
    "mobile" = {
      fingerprint.eDP-1 = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
      config.eDP-1 = {
        enable = true;
        primary = true;
        mode = "2560x1440";
        position = "0x0";
        rate = "60.01";
      };
    };
    "work-4k" = {
      fingerprint = {
        eDP-1 = "00ffffffffffff0006af362000000000001b0104a51f117802fbd5a65334b6250e505400000001010101010101010101010101010101e65f00a0a0a040503020350035ae100000180000000f0000000000000000000000000020000000fe0041554f0a202020202020202020000000fe004231343051414e30322e30200a00d2";
        DP-1 = "00ffffffffffff001e6d095bd8c40700071c0104b53c22789e3035a7554ea3260f50542108007140818081c0a9c0d1c08100010101014dd000a0f0703e803020650c58542100001a286800a0f0703e800890650c58542100001a000000fd00383d1e8738000a202020202020000000fc004c4720556c7472612048440a2001f50203117144900403012309070783010000023a801871382d40582c450058542100001e565e00a0a0a029503020350058542100001a0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c8";
      };
      config = {
        DP-1 = {
          enable = true;
          primary = true;
          mode = "3840x2160";
          position = "0x0";
          rate = "60.00";
        };
        eDP-1 = {
          enable = true;
          mode = "2560x1440";
          position = "0x2160";
          rate = "60.01";
        };
      };
    };
  };
}
