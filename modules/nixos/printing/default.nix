{ pkgs, ... }:
{
  services.printing = {
    enable = true;
    drivers = [ pkgs.ghostscript ];
  };

  hardware.printers = {
    ensureDefaultPrinter = "UiO-Print-Ricoh";
    ensurePrinters = [
      {
        name = "UiO-Print-Ricoh";
        location = "https://print.uio.no";
        deviceUri = "ipps://mobilityprint.uio.no:9164/printers/UiO-Print";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          "PageSize" = "A4";
          "Duplex" = "DuplexNoTumble";
          "auth-info-required" = "username,password";
        };
      }
    ];
  };
}
