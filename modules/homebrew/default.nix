{
  homebrew = {
    enable = true;
    onActivation = {
      # autoUpdate = true;
      upgrade = true;
      cleanup = "uninstall";
    };
    casks = [
      "amethyst"
      "arc"
      "chatgpt"
      "darktable"
      "dropbox"
      "google-chrome"
      "iina"
      "karabiner-elements"
      "obs"
      "ollama"
      "processing"
      "racket"
      "raycast"
      "remarkable"
      "signal"
      "skim"
      "supercollider"
      "utm"
      "zoom"
      "zen-browser"
    ];
  };
}
