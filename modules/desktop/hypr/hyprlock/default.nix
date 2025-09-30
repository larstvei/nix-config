{
  programs.hyprlock = {
    enable = true;

    settings = {
      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "600, 100";
          position = "0, 0";
          halign = "center";
          valign = "center";

          outline_thickness = 4;

          placeholder_text = "⋯";
          fade_on_empty = false;
        }
      ];

      auth."fingerprint:enabled" = true;
    };
  };
}
