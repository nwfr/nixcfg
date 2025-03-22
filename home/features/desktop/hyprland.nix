{ config
, lib
, ...
}:
with lib; let
  cfg = config.features.desktop.hyprland;
in
{
  options.features.desktop.hyprland.enable = mkEnableOption "hyprland config";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        xwayland = {
          force_zero_scaling = true;
        };
        "$mainMod" = "SUPER";
        "$terminal" = "kitty";
        "$term" = "ghostty";
        "$fileManager" = "ghostty -e yazi";
        "$fileManager_gui" = "pcmanfm-qt";
        "$browser" = "firefox";
        "$kbd_layout" = "us";
        "$shotDir" = "~/documents/pictures/screenshots";
        "$shotFile" = "$(date = screenshot_%Y%m%d-%H%M%S%)";

        env = [
          "XCURSOR_SIZE,32"
          "WLR_NO_HARDWARE_CURSORS,1"
          "GTK_THEME,Dracula"
        ];

        # Autostart
        exec-once = [
          "wl-paste --type text --watch cliphist store"
          "wl-paste --type image --watch cliphist store"
          "systemctl --user start hyprpolkitagent"
          "dunst"
          "hyprpaper"
          "hypridle"
          "udiskie"
          "playerctld daemon"
        ];

        # Input
        input = {
          kb_layout = "$kbd_layout";
          kb_variant = "";
          kb_model = "";
          kb_options = "caps:escape";
          kb_rules = "";
          numlock_by_default = true;
          follow_mouse = 1;
          sensitivity = 0.5;
          touchpad = {
            natural_scroll = false;
          };
        };

        gestures = {
          workspace_swipe = false;
        };

        # Aesthetics
        general = {
          gaps_in = 7;
          gaps_out = 9;
          border_size = 0;
          "col.active_border" = "rgba(94e2d599)";
          "col.inactive_border" = "rgba(11111b99)";
          resize_on_border = true;
          allow_tearing = false;
          layout = "master";
        };

        master = {
          allow_small_split = true;
          special_scale_factor = 0.95;
          mfact = 0.50;
          new_status = "master";
          new_on_top = false;
          new_on_active = "none";
          orientation = "left";
          inherit_fullscreen = true;
          smart_resizing = true;
          drop_at_cursor = true;
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        animations = {
          enabled = true;
          bezier = [
            "easeOutQuint,0.23,1,0.32,1"
            "easeInOutCubic,0.65,0.05,0.36,1"
            "linear,0,0,1,1"
            "almostLinear,0.5,0.5,0.75,1.0"
            "quick,0.15,0,0.1,1"
          ];
          animation = [
            "global, 1, 10, default"
            "border, 1, 5.39, easeOutQuint"
            "windows, 1, 4.79, easeOutQuint"
            "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
            "windowsOut, 1, 1.49, linear, popin 87%"
            "fadeIn, 1, 1.73, almostLinear"
            "fadeOut, 1, 1.46, almostLinear"
            "fade, 1, 3.03, quick"
            "layers, 1, 3.81, easeOutQuint"
            "layersIn, 1, 4, easeOutQuint, fade"
            "layersOut, 1, 1.5, linear, fade"
            "fadeLayersIn, 1, 1.79, almostLinear"
            "fadeLayersOut, 1, 1.39, almostLinear"
            "workspaces, 1, 2.34, almostLinear, slide"
            "workspacesIn, 1, 2.34, almostLinear, slide"
            "workspacesOut, 1, 2.34, almostLinear, slidevert"
          ];
        };

        decoration = {
          rounding = 0;
          active_opacity = 1.0;
          inactive_opacity = 0.5;
          shadow = {
            enabled = true;
            range = 2;
            render_power = 1;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 2;
            passes = 2;
            vibrancy = 0.1696;
          };
        };

        misc = {
          force_default_wallpaper = 0;
          disable_hyprland_logo = true;
        };

        # Monitors
        monitor = [
          "eDP-1, highres@highrr, auto, auto"
          "HDMI-A-1, highres@highrr, auto-up, auto"
        ];

        # Bindings
        bind = [
          "$mainMod, return, exec, $terminal"
          "$mainMod, backspace, exec, $terminal"
          "$mainMod, code:49, exec, $terminal" # exit, code:49 = (FR: towsuperior = ²) (EN: backtick = `)
          "$mainMod, E, exec, $fileManager"
          "$mainMod SHIFT, E, exec, $fileManager_gui"
          "$mainMod, B, exec, $browser"
          "$mainMod SHIFT, B, exec, $browser -private-window"
          "$mainMod, R, exec, pkill -x rofi || launcher"
          "$mainMod SHIFT, R, exec, pkill -x rofi || runner"
          "$mainMod, Z, exec, pkill -x rofi || clipboard c"
          "$mainMod SHIFT, Z, exec, pkill -x rofi || clipboard"
          "$mainMod, X, exec, pkill -x rofi || tmux-rofi"
          "$mainMod, F1, exec, pkill -x rofi || sysinfo"
          "CTRL, backspace, exec, pkill -x rofi || powermenu"
          "$mainMod, K, exec, pkill -x rofi || bookmark"
          "$mainMod, I, exec, pkill -x rofi || icons"
          ", F12, exec, pkill -x rofi || recorder"
          "$mainMod, F9, exec, pkill -x rofi || audio"
          "$mainMod, F2, exec, pkill -x rofi || notes"
          "$mainMod, F4, exec, pkill -x rofi || mounter"
          "$mainMod SHIFT, F4, exec, pkill -x rofi || unmounter"
          "$mainMod, F5, exec, pkill -x rofi || handler"
          "$mainMod, U, exec, $terminal -e sys_update"

          # Functions
          "$mainMod, Q, killactive"
          "$mainMod, F, fullscreen"
          "$mainMod, T, togglefloating"

          # Screenshots
          "$mainMod, Home, exec, pkill -x rofi || screenshot"
          "$mainMod, Prior, exec, hyprshot -o $shotDir -m output"
          "$mainMod, Next, exec, hyprshot -o $shotDir -m window"
          "$mainMod SHIFT, Home, exec, hyprshot -o $shotDir -m region"

          # Window Focus
          "$mainMod, space, layoutmsg, swapwithmaster master"
          "$mainMod, left, movefocus, l"
          "$mainMod, right, movefocus, r"
          "$mainMod, up, movefocus, u"
          "$mainMod, down, movefocus, d"
          "$mainMod, H, movefocus, l"
          "$mainMod, J, movefocus, d"
          "$mainMod, K, movefocus, u"
          "$mainMod, L, movefocus, r"

          # Window Movement
          "$mainMod SHIFT, H, movewindow, l"
          "$mainMod SHIFT, J, movewindow, d"
          "$mainMod SHIFT, K, movewindow, u"
          "$mainMod SHIFT, L, movewindow, r"

          # Workspace Switching
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"

          # Window Movement to Workspaces
          "$mainMod SHIFT, 1, movetoworkspacesilent, 1"
          "$mainMod SHIFT, 2, movetoworkspacesilent, 2"
          "$mainMod SHIFT, 3, movetoworkspacesilent, 3"
          "$mainMod SHIFT, 4, movetoworkspacesilent, 4"
          "$mainMod SHIFT, 5, movetoworkspacesilent, 5"
          "$mainMod SHIFT, 6, movetoworkspacesilent, 6"
          "$mainMod SHIFT, 7, movetoworkspacesilent, 7"
          "$mainMod SHIFT, 8, movetoworkspacesilent, 8"
          "$mainMod SHIFT, 9, movetoworkspacesilent, 9"

          # Hyprnome
          "$mainMod CTRL, right, exec, hyprnome"
          "$mainMod CTRL, left, exec, hyprnome --previous"
          "$mainMod SHIFT, right, exec, hyprnome --move"
          "$mainMod SHIFT, left, exec, hyprnome --previous --move"

          # Workspace Notifications
          # "$mainMod, code:10, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 FOCUS 1\""
          # "$mainMod, code:11, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 BROWSER 2\""
          # "$mainMod, code:12, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 IDE 3\""
          # "$mainMod, code:13, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 FILE 4\""
          # "$mainMod, code:14, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 FILE-GUI 5\""
          # "$mainMod, code:15, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 SERVER 6\""
          # "$mainMod, code:16, exec, hyprctl notify 2 2000 \"rgb(008080)\" \"fontsize:10 MEDIA 7\""

          # Scratchpads
          "$mainMod SHIFT, S, togglespecialworkspace"
          "$mainMod, S, togglespecialworkspace, term"
          "$mainMod, F3, togglespecialworkspace, calcurse"
          "$mainMod, F10, togglespecialworkspace, volume"
          "$mainMod, F11, togglespecialworkspace, music"
          "$mainMod, F12, togglespecialworkspace, calc"

          # Workspace Scrolling
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"

          # Audio Control
          ", F6, exec, playerctl play-pause"
          ", F5, exec, playerctl previous"
          ", F7, exec, playerctl next"
          ", F8, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPause, exec, playerctl play-pause"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPrev, exec, playerctl previous"
          ", F10, exec, brightnessctl s 10%+"
          ", F9, exec, brightnessctl s 10%-"

          # Laptop Specific
          ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
          ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ", XF86MonBrightnessUp, exec, brightnessctl s 10%+"
          ", XF86MonBrightnessDown, exec, brightnessctl s 10%-"
        ];

        # Mouse movements
        bindm = [
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];

        # Rules
        windowrulev2 = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"
          "opacity 0.0 override, class:^(xwaylandvideobridge)$"
          "opacity 0.85 0.85,title:^*.(Nvim)$"
          "opacity 0.90 0.90,class:^(firefox)$"
          "opacity 0.90 0.90,class:^(Google-chrome)$"
          "opacity 0.90 0.90,class:^(Brave-browser)$"
          "opacity 0.80 0.80,class:^(code-oss)$"
          "opacity 0.80 0.80,class:^([Cc]ode)$"
          "opacity 0.80 0.80,class:^(code-url-handler)$"
          "opacity 0.80 0.80,class:^(code-insiders-url-handler)$"
          "opacity 0.80 0.80,class:^(ghostty)$"
          "opacity 0.80 0.80,class:^(ghostty)$,title:^(yazi)$"
          "opacity 1.00 1.00,class:^(ghostty)$,title:^(clock)$"
          "opacity 0.80 0.70,title:^(pulsemixer)$"
          "opacity 0.80 0.70,class:^(polkit-gnome-authentication-agent-1)$"
          "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.gtk)$"
          "opacity 0.80 0.70,class:^(org.freedesktop.impl.portal.desktop.hyprland)$"
          "opacity 0.80 0.80,class:^(app.drey.Warp)$"
          "opacity 0.80 0.80,class:^(Signal)$"
          "opacity 0.80 0.80,class:^(com.github.unrud.VideoDownloader)$"
          "opacity 1.00 1.00 override,class:^(pcmanfm)$,title:^(Moving files)$"
          "float, ^(vlc)$"
          "float, class:ghostty, title:pulsemixer"
          "float, tag:clock, title:^(tty-clock|clock)$"
          "float, tag:skylight"
          "float, title:^(Extension).*(Bitwarden).*$"
          "float, class:^(pcmanfm)$, title:^(Moving files)$"
          "noanim, class:^(xwaylandvideobridge)$"
          "noinitialfocus, class:^(xwaylandvideobridge)$"
          "maxsize 1 1, class:^(xwaylandvideobridge)$"
          "maxsize 500 300 override, tag:clock"
          "size 600 400, floating 1, move 2300 1600, tag:skylight"
          "maxsize 600 400, class:^(pcmanfm)$, title:^(Moving files)$"
          "minsize 950 750 , class:Vivaldi-stable title:Vivaldi Settings: General - Vivaldi$"
          "noblur, class:^(xwaylandvideobridge)$"
          "noblur,class:^()$,title:^()$"
          "noblur,class:^(pcmanfm)$,title:^(Moving files)$"
          "tag +clock, title:^(tty-clock|clock)$, class:^(ghostty)$"
          "tag +skylight, class:^(mpv)$"
        ];

        # Workspaces
        workspace = [
          "1, name:FOCUS"
          "2, name:BROWSER"
          "3, name:IDE"
          "4, name:FILE"
          "5, name:FILE-GUI"
          "6, name:SERVER"
          "7, name:MEDIA"
          "special:term, on-created-empty:ghostty"
          "special:clock, gapsout:400, on-created-empty:[float] ghostty -e clock"
          "special:calcurse, on-created-empty:ghostty -e calcurse"
          "special:notes, on-created-empty:[float] ghostty -e dooit"
          "special:skylight, monitor:HDMI-A-1"
          "special:volume, gapsout:200, on-created-empty:[float] ghostty -e pulsemixer"
          "special:music, on-created-empty:ghostty -e ncmpcpp"
          "special:calc, gapsout:400, on-created-empty:[float] ghostty -e bc -lq"
        ];
      };
    };
  };
}
