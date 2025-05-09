{ config, pkgs, ... }:

{

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.xserver.displayManager.gdm.enable = true;
  services.xserver.displayManager.gdm.wayland = false;
  services.displayManager.defaultSession = "xfce";
  services.xserver.desktopManager.xfce.enable = true;

  zramSwap = {
    enable = true;
    memoryPercent = 75;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

 
}