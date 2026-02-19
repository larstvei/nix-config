let
  theme = import ../theme;
in
{
  programs.swaylock = {
    enable = true;
    settings = {
      color = theme.bg.dark;
      indicator-caps-lock = true;

      inside-color = theme.bg.dark;
      inside-clear-color = theme.bg.dark;
      inside-caps-lock-color = theme.bg.dark;
      inside-ver-color = theme.bg.dark;
      inside-wrong-color = theme.bg.dark;

      ring-color = theme.secondary.dark;
      ring-clear-color = theme.warning.dark;
      ring-caps-lock-color = theme.primary.light;
      ring-ver-color = theme.primary.dark;
      ring-wrong-color = theme.error.dark;

      text-color = theme.fg.dark;
      text-clear-color = theme.fg.dark;
      text-caps-lock-color = theme.fg.dark;
      text-ver-color = theme.fg.dark;
      text-wrong-color = theme.fg.dark;

      key-hl-color = theme.primary.light;
      bs-hl-color = theme.warning.dark;

      line-color = "00000000";
      line-clear-color = "00000000";
      line-caps-lock-color = "00000000";
      line-ver-color = "00000000";
      line-wrong-color = "00000000";
      separator-color = "00000000";
    };
  };
}
