{ config, pkgs, ... }:

{

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.displayManager.gdm.wayland = false;

  zramSwap = {
    enable = true;
    memoryPercent = 75;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "br";
    variant = "";
  };

  environment.systemPackages = with pkgs; [
    htop
    # ...outros pacotes específicos do host mara
  ];

}