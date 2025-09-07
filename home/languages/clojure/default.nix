{ pkgs, ... }:
{
  home.packages = with pkgs; [
    babashka
    clj-kondo
    clojure
    leiningen
    neil
  ];
}
