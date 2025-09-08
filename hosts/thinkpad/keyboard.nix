{ pkgs, ... }:
{

  # Disable internal keyboard when external (Voyager) is connected
  services.udev.extraRules = ''
    ACTION=="add",    SUBSYSTEM=="input", KERNEL=="event*", ENV{DEVLINKS}=="*usb-ZSA_Technology_Labs_Voyager-event-kbd*", RUN+="${pkgs.kmod}/bin/modprobe -r atkbd"
    ACTION=="remove", SUBSYSTEM=="input", KERNEL=="event*", ENV{DEVLINKS}=="*usb-ZSA_Technology_Labs_Voyager-event-kbd*", RUN+="${pkgs.kmod}/bin/modprobe atkbd"
  '';

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defvar
            tap-time 150
            hold-time 200
          )

          (defsrc
                     e r
            caps a s d f g h j k l ;
                     c v
                       spc
          )

          (defalias
            ;; home-row mods
            caps (tap-hold $tap-time $hold-time bspc lctl)
            a    (tap-hold $tap-time $hold-time a lsft)
            s    (tap-hold $tap-time $hold-time s lalt)
            d    (tap-hold $tap-time $hold-time d lmet)
            f    (tap-hold $tap-time $hold-time f lctl)
            j    (tap-hold $tap-time $hold-time j rctl)
            k    (tap-hold $tap-time $hold-time k rmet)
            l    (tap-hold $tap-time $hold-time l ralt)
            ;    (tap-hold $tap-time $hold-time ; rsft)
            spc  (tap-hold $tap-time $hold-time spc lsft)

            ;; layer-taps
            g    (tap-hold $tap-time $hold-time g (layer-while-held navigation))
            h    (tap-hold $tap-time $hold-time h (layer-while-held symbol))
          )

          (deflayer base
                        e  r
            @caps @a @s @d @f @g @h @j @k @l @;
                          c  v
                              @spc
          )

          (deflayer navigation
                        e  r
            @caps @a @s @d @f @g left down up right @;
                          c  v
                             @spc
          )

          (deflayer symbol
                          S-[  S-]
            @caps @a  S-4  S-9 S-0  @g @h @j @k @l @;
                            [    ]
                                 @spc
          )
        '';
      };
    };
  };
}
