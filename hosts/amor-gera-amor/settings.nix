{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.enable = false;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    nmap
    htop
    rustdesk
    google-cloud-sdk
    google-cloud-sdk-gce

    # ...outros pacotes específicos do host amor-gera-amor
  ];

}