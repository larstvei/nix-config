{ pkgs, inputs, ... }:
let
  nanostatus = inputs.nanostatus.packages.${pkgs.system}.default;

  toggle-mirror-display = pkgs.writeShellScriptBin "toggle-mirror-display" ''
    if hyprctl monitors | grep -q '^Monitor eDP-1'; then
        M=$(hyprctl monitors | awk '/Monitor/ && $2 != "eDP-1" { print $2 }' | head -n1)
        hyprctl keyword monitor "eDP-1,preferred,auto,1,mirror,$M"
    else
        hyprctl keyword monitor "eDP-1,preferred,auto,1"
    fi
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    input = {
      kb_layout = "us";
      kb_variant = "mac";
      # Both Alt keys becomes Option (called Mod5)
      kb_options = "lv3:alt_switch,apple:alupckeys";

      repeat_delay = 300;
      repeat_rate = 50;

      touchpad = {
        natural_scroll = true;
        scroll_factor = 0.4;
        tap-to-click = true;
      };
    };

    "$mod" = "SUPER Mod5";
    bind = [
      "$mod, code:41, fullscreen" # F (code:41)
      "$mod, code:24, killactive" # Q (code:24)
      "$mod, code:119, exec, swaylock" # Delete (code:119)

      # Focus Movement (Super + Alt + HJKL)

      "$mod, code:43, movefocus, l" # H (code:43)
      "$mod, code:44, movefocus, d" # J (code:44)
      "$mod, code:45, movefocus, u" # K (code:45)
      "$mod, code:46, movefocus, r" # L (code:46)

      # Window Movement (Super + Shift + Alt + HJKL)
      "$mod SHIFT, code:43, movewindow, l"
      "$mod SHIFT, code:44, movewindow, d"
      "$mod SHIFT, code:45, movewindow, u"
      "$mod SHIFT, code:46, movewindow, r"

      # Master Layout & Resize
      "$mod, code:36, layoutmsg, swapwithmaster master" # Return (code:36)
      "$mod, code:20, layoutmsg, mfact -0.01" # Minus (code:20)
      "$mod, code:21, layoutmsg, mfact +0.01" # Equal (code:21)
      "$mod, code:23, layoutmsg, cyclenext" # Tab (code:23)
      "$mod SHIFT, code:23, layoutmsg, cycleprev"
      "$mod, code:59, layoutmsg, addmaster" # Comma (code:59)
      "$mod, code:60, layoutmsg, removemaster" # Period (code:60)

      # App Launchers (Super + Alt + Key)
      "$mod, code:28, exec, kitty" # T (code:28)
      "$mod, code:26, exec, emacs" # E (code:26)
      "$mod, code:56, exec, zen-beta" # B (code:56)
      "$mod, code:40, exec, ${pkgs.darkman}/bin/darkman toggle" # D (code:40)
      "$mod, code:65, exec, ${nanostatus}/bin/nanostatus-toggle" # Space (code:65)
      "$mod SHIFT, code:58, exec, ${toggle-mirror-display}/bin/toggle-mirror-display" # M (code:58) + Shift

      # Screenshots

      "$mod, code:39, exec, grimblast copysave area /tmp/screenshot-$(date +%F--%T).png" # S (code:39)
      "$mod SHIFT, code:39, exec, grimblast copysave screen /tmp/screenshot-$(date +%F--%T).png"

      # Media & Brightness (Standard Keys)
      ", XF86AudioRaiseVolume, exec, pamixer -i 5 "
      ", XF86AudioLowerVolume, exec, pamixer -d 5 "
      ", XF86AudioMute, exec, pamixer -t"
      ", XF86AudioMicMute, exec, pamixer --default-source -t"
      ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
      ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      "SHIFT, XF86MonBrightnessUp, exec, brightnessctl set 100%"
      "SHIFT, XF86MonBrightnessDown, exec, brightnessctl set 1"

      # Workspaces (Super + Alt + 1-9)
      # 1=code:10, 2=code:11, ... 9=code:18, 0=code:19
      "$mod, code:10, workspace, 1"
      "$mod SHIFT, code:10, movetoworkspace, 1"

      "$mod, code:11, workspace, 2"
      "$mod SHIFT, code:11, movetoworkspace, 2"

      "$mod, code:12, workspace, 3"
      "$mod SHIFT, code:12, movetoworkspace, 3"

      "$mod, code:13, workspace, 4"
      "$mod SHIFT, code:13, movetoworkspace, 4"

      "$mod, code:14, workspace, 5"
      "$mod SHIFT, code:14, movetoworkspace, 5"

      "$mod, code:15, workspace, 6"
      "$mod SHIFT, code:15, movetoworkspace, 6"

      "$mod, code:16, workspace, 7"
      "$mod SHIFT, code:16, movetoworkspace, 7"

      "$mod, code:17, workspace, 8"
      "$mod SHIFT, code:17, movetoworkspace, 8"

      "$mod, code:18, workspace, 9"
      "$mod SHIFT, code:18, movetoworkspace, 9"

      "$mod, code:19, workspace, 10"
      "$mod SHIFT, code:19, movetoworkspace, 10"
    ];
  };
}
