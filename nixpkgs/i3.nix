{ pkgs, ... }:

let theme = import ./theme.nix;

ws = {
  _1 = "1: >_";
  _2 = "2: dev";
  _3 = "3: www";
  _4 = "4: docs";
  _5 = "5";
  _6 = "6";
  _7 = "7: email";
  _8 = "8: chat";
  _9 = "9: music";
  _10 = "10: sys";
  _11 = "11";
  _12 = "12";
  _13 = "13";
  _14 = "14";
  _15 = "15";
  _16 = "16";
  _17 = "17";
  _18 = "18";
  _19 = "19";
  _20 = "20";
};

mod = "Mod3";
modc = "Control";
moda = "Mod1";

in
{
  enable = true;
  package = pkgs.i3-gaps;
  config = {
    gaps = {
      inner = 8;
      outer = 0;
      smartBorders = "on";
    };
    modifier = mod;
    keybindings = {
      "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +3%";
      "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -3%";
      "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle # mute sound";
      "XF86MonBrightnessUp" = "exec --no-startup-id light -A 10";
      "XF86MonBrightnessDown" = "exec --no-startup-id light -U 10";
      "${mod}+XF86MonBrightnessUp" = "exec --no-startup-id light -A 2";
      "${mod}+XF86MonBrightnessDown" = "exec --no-startup-id light -U 2";
      "XF86AudioMicMute" = "exec --no-startup-id pactl set-source-mute 1 toggle";

      #"XF86Tools" = "exec --no-startup-id change-theme";
      #"XF86Favorites" = "exec /home/ari/bin/lock";

      "${mod}+Return" = "exec kitty";
      "${mod}+${modc}+Return" = "exec --no-startup-id thunar";

      "${modc}+q" = "kill";

      "${mod}+${modc}+s" = "exec --no-startup-id brave --new-window";
      "${mod}+${modc}+g" = "exec --no-startup-id google-chrome-stable --new-window";

      "${mod}+Shift+Up" = "exec --no-startup-id xrandr --output DP-1 --brightness 1";
      "${mod}+Shift+Down" = "exec --no-startup-id xrandr --output DP-1 --brightness 0.85";

      "${mod}+slash" = "exec playerctl play-pause";
      "${mod}+period" = "exec playerctl next";
      "${mod}+comma" = "exec playerctl previous";

      "${modc}+space" = "exec rofi -show drun -show-icons";
      #"${modc}+Mod1+space" = "exec rofi -show window";
      "${modc}+Tab" = "exec rofi -show window";

      # switch window focus
      "${mod}+Left" = "focus left";
      "${mod}+Down" = "focus down";
      "${mod}+Up" = "focus up";
      "${mod}+Right" = "focus right";

      # move window position
      "${mod}+Control+Left" = "move left";
      "${mod}+Control+Down" = "move down";
      "${mod}+Control+Up" = "move up";
      "${mod}+Control+Right" = "move right";

      # split in horizontal/vertifical orientation
      "${mod}+h" = "split h";
      "${mod}+v" = "split v";

      # enter fullscreen mode for the focused container
      "${mod}+f" = "fullscreen toggle";

      # change container layout (toggle split, stacking, tabbed)
      "${mod}+a" = "layout toggle split";
      "${mod}+s" = "layout stacking";
      "${mod}+d" = "layout tabbed";

      # toggle tiling / floating
      "${mod}+space" = "floating toggle";

      # change focus between tiling / floating windows
      "${mod}+i" = "focus mode_toggle";

      # focus the parent container
      "${mod}+p" = "focus parent";

      # focus the child container
      "${mod}+o" = "focus child";

      # switch to workspace
      "${mod}+1" = "workspace ${ws._1}";
      "${mod}+2" = "workspace ${ws._2}";
      "${mod}+3" = "workspace ${ws._3}";
      "${mod}+4" = "workspace ${ws._4}";
      "${mod}+5" = "workspace ${ws._5}";
      "${mod}+6" = "workspace ${ws._6}";
      "${mod}+7" = "workspace ${ws._7}";
      "${mod}+8" = "workspace ${ws._8}";
      "${mod}+9" = "workspace ${ws._9}";
      "${mod}+0" = "workspace ${ws._10}";
      "${mod}+Shift+1" = "workspace ${ws._11}";
      "${mod}+Shift+2" = "workspace ${ws._12}";
      "${mod}+Shift+3" = "workspace ${ws._13}";
      "${mod}+Shift+4" = "workspace ${ws._14}";
      "${mod}+Shift+5" = "workspace ${ws._15}";
      "${mod}+Shift+6" = "workspace ${ws._16}";
      "${mod}+Shift+7" = "workspace ${ws._17}";
      "${mod}+Shift+8" = "workspace ${ws._18}";
      "${mod}+Shift+9" = "workspace ${ws._19}";
      "${mod}+Shift+0" = "workspace ${ws._20}";

      # move focused container to workspace
      "${modc}+${mod}+1" = "move container to workspace ${ws._1}";
      "${modc}+${mod}+2" = "move container to workspace ${ws._2}";
      "${modc}+${mod}+3" = "move container to workspace ${ws._3}";
      "${modc}+${mod}+4" = "move container to workspace ${ws._4}";
      "${modc}+${mod}+5" = "move container to workspace ${ws._5}";
      "${modc}+${mod}+6" = "move container to workspace ${ws._6}";
      "${modc}+${mod}+7" = "move container to workspace ${ws._7}";
      "${modc}+${mod}+8" = "move container to workspace ${ws._8}";
      "${modc}+${mod}+9" = "move container to workspace ${ws._9}";
      "${modc}+${mod}+0" = "move container to workspace ${ws._10}";
      "${modc}+${mod}+Shift+1" = "move container to workspace ${ws._11}";
      "${modc}+${mod}+Shift+2" = "move container to workspace ${ws._12}";
      "${modc}+${mod}+Shift+3" = "move container to workspace ${ws._13}";
      "${modc}+${mod}+Shift+4" = "move container to workspace ${ws._14}";
      "${modc}+${mod}+Shift+5" = "move container to workspace ${ws._15}";
      "${modc}+${mod}+Shift+6" = "move container to workspace ${ws._16}";
      "${modc}+${mod}+Shift+7" = "move container to workspace ${ws._17}";
      "${modc}+${mod}+Shift+8" = "move container to workspace ${ws._18}";
      "${modc}+${mod}+Shift+9" = "move container to workspace ${ws._19}";
      "${modc}+${mod}+Shift+0" = "move container to workspace ${ws._20}";

      # move worksapce to other monitor
      "${mod}+n" = "move workspace to output up";
      "${mod}+m" = "move workspace to output down";

      # Workspaces and multiple monitors
      "${mod}+${moda}+Left" = "move workspace to output left";
      "${mod}+${moda}+Right" = "move workspace to output right";
      "${mod}+${moda}+Up" = "move workspace to output up";
      "${mod}+${moda}+Down" = "move workspace to output down";

      # next/prev workspace
      "${mod}+Next" = "exec ~/.bin/i3-powertools -workspace=next";
      "${mod}+Prior" = "exec ~/.bin/i3-powertools -workspace=prev";

      "${mod}+bracketright" = "workspace next";
      "${mod}+bracketleft" = "workspace prev";

      "${mod}+l" = "exec ~/.bin/screenlock";
      "${mod}+semicolon" = "exec ~/.bin/screenoff";

      "${mod}+r" = "mode resize";

      # restart i3 inplace (preserves your layout/session, can be used to upgrade i3)
      "${mod}+Shift+r" = "restart";

      # exit i3 (logs you out of your X session)
      "${mod}+Shift+e" = "exec \"i3-nagbar -t warning -m 'You pressed the exit shortcut. Do you really want to exit i3? This will end your X session.' -b 'Yes, exit i3' 'i3-msg exit'\"";

      # pick a new wallpaper
      "${mod}+Shift+w" = "exec ~/.bin/set-wallpaper.sh";
    };
    colors = with theme; {
      background = hex.background;
      focused = {
        border = hex.background;
        background = hex.background;
        text = hex.foreground;
        indicator = hex.background;
        childBorder = hex.foreground;
      };
      focusedInactive = {
        border = hex.background;
        background = hex.background;
        text = hex.foreground;
        indicator = hex.background;
        childBorder = hex.background;
      };
      unfocused = {
        border = hex.background;
        background = hex.background;
        text = hex.foreground;
        indicator = hex.background;
        childBorder = hex.background;
      };
      urgent = {
        border = hex.background;
        background = hex.background;
        text = hex.foreground;
        indicator = hex.background;
        childBorder = hex.background;
      };
      placeholder = {
        border = hex.background;
        background = hex.background;
        text = hex.foreground;
        indicator = hex.background;
        childBorder = hex.background;
      };
    };
    modes = {
      # resize window (you can also use the mouse for that)
      resize = {
        # same bindings, but for the arrow keys
        "Left" = "resize shrink width 10 px or 10 ppt";
        "Down" = "resize grow height 10 px or 10 ppt";
        "Up" = "resize shrink height 10 px or 10 ppt";
        "Right" = "resize grow width 10 px or 10 ppt";
        "Escape" = "mode default";
        "Return" = "mode default";
        "${mod}+r" = "mode default";
      };
    };
    bars = [{
      fonts = [ "DejaVu Sans Mono, Font Awesome 10" ];
      position = "bottom";
      statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.dotfiles/config/i3status/status.toml";
      colors = with theme; {
        background = hex.background;
        statusline = hex.foreground;
        separator = hex.foreground;
        focusedWorkspace = { border = hex.color4; background = hex.foreground; text = hex.background; };
        activeWorkspace = { border = hex.color4; background = hex.background; text = hex.foreground; };
        inactiveWorkspace = { border = hex.black; background = hex.black; text = hex.foreground; };
        urgentWorkspace = { border = hex.red; background = hex.red; text = hex.black; };
      };
    }];
    focus = {
      newWindow = "urgent";
    };
    window = {
      border = 2;
      titlebar = false;
    };
    floating = {
      modifier = "${mod}";
      criteria = [
        { "window_type"="dialog"; }
        { "window_type"="menu"; }
        { "window_role"="pop-up"; } # how to disable pop for chrome devtools?  "title"="^(?!DevTools - .*$))";
      ];
    };
    startup = [
      # xresources
      { command = "xrdb -merge ~/.Xresources"; notification = false; }

      # mod/capslock override
      { command = "xmodmap ~/.xmodmap"; notification = false; }

      # key rate
      { command = "xset r rate 175 30"; notification = false; }

      # detect screens
      { command = "autorandr -c"; always = true; notification = false; }

      # turn off screen after 5min
      { command = "xset dpms 300"; notification = false; }

      # go to first workspace
      { command = "i3-msg workspace '${ws._1}'"; notification = false; }

      # network
      { command = "nm-applet"; notification = false; }

      # wallpaper
      { command = "~/.bin/set-wallpaper.sh"; notification = false; }

      # unclutter makes the mouse invisible after a brief period
      { command = "unclutter"; notification = false; }

    ];
  };
  extraConfig = ''
    # screenshot, clip
    bindsym --release ${mod}+Shift+p exec maim -s | xclip -selection clipboard -t "image/png"

    # screenshot, full screen
    bindsym --release ${mod}+p exec --no-startup-id maim ~/Pictures/screenshot-$(date +%s).png

    # switch workspace with mod + mouse wheel/scroll
    bindsym --whole-window --border ${mod}+button4 exec ~/.bin/i3-powertools -workspace=prev
    bindsym --whole-window --border ${mod}+button5 exec ~/.bin/i3-powertools -workspace=next
  '';
}
