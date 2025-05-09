{ config, pkgs, ... }:

{
  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = false;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    nmap
    # ...outros pacotes específicos do host amor-gera-amor
  ];

}