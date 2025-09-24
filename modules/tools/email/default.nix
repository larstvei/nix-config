{ pkgs, ... }:
{
  home.packages = [ pkgs.oama ];

  programs = {
    mu.enable = true;
    msmtp.enable = true;
    mbsync.enable = true;
  };

  accounts.email = {
    accounts.uio = {
      primary = true;
      address = "larstvei@ifi.uio.no";
      userName = "larstvei@ifi.uio.no";
      realName = "Lars Tveito";

      imap.host = "outlook.office365.com";
      smtp.host = "smtp.office365.com";

      mbsync = {
        enable = true;
        create = "maildir";
      };

      passwordCommand = "oama access larstvei@ifi.uio.no";

      msmtp.enable = true;
      mu.enable = true;
    };
  };
}
