# Note that this module requires setting up a host aliased `storagebox` that
# supports file transfers via SFTP. In addition, it requires adding the restic
# password to ~/.config/restic/password.
{ config, osConfig, ... }:
let
  host = osConfig.networking.hostName;
in
{
  services.restic = {
    enable = true;
    backups.${host} = {
      # assume storagebox is configured in the SSH config
      repository = "sftp:storagebox:backup/${host}";
      passwordFile = "${config.home.homeDirectory}/.config/restic/password";

      paths = [ config.home.homeDirectory ];
      exclude = [ "${config.home.homeDirectory}/.cache" ];

      initialize = true;

      timerConfig.OnCalendar = "hourly";

      pruneOpts = [
        "--keep-hourly 24"
        "--keep-daily 7"
        "--keep-weekly 4"
        "--keep-monthly 12"
        "--keep-yearly unlimited"
      ];
    };
  };
}
