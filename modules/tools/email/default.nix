{ pkgs, ... }:
{
  home.packages = [
    pkgs.oama
  ];

  services.gnome-keyring = {
    enable = true;
    components = [ "secrets" ];
  };

  # Use Thunderbird's Client ID
  xdg.configFile."oama/config.yaml".text = builtins.toJSON {
    encryption = {
      tag = "KEYRING";
    };
    services = {
      microsoft = {
        client_id = "9e5f94bc-e8a4-4e73-b8be-63364c29d753";
        redirect_uri = "http://localhost:8080";
        scopes = [
          "offline_access"
          "https://outlook.office.com/IMAP.AccessAsUser.All"
          "https://outlook.office.com/SMTP.Send"
        ];
      };
    };
  };

  home.sessionVariables = {
    SASL_PATH = "${pkgs.cyrus-sasl-xoauth2}/lib/sasl2:${pkgs.cyrus_sasl}/lib/sasl2";
  };

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

      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls = {
          enable = true;
          useStartTls = true;
        };
      };

      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        extraConfig.account = {
          AuthMechs = "XOAUTH2";
        };
      };

      msmtp = {
        enable = true;
        extraConfig = {
          auth = "xoauth2";
          user = "larstvei@uio.no";
          from = "larstvei@ifi.uio.no";
        };
      };

      passwordCommand = "${pkgs.oama}/bin/oama access larstvei@ifi.uio.no";

      mu.enable = true;
    };
  };
}
