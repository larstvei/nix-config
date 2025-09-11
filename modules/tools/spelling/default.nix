{ pkgs, ... }:
{
  home.packages = with pkgs; [
    hunspell
    hunspellDicts.en_US
    hunspellDicts.nb_NO
  ];

  home.file.".config/enchant/hunspell/".source = "${pkgs.hunspellDicts.nb_NO}/share/hunspell/";
}
