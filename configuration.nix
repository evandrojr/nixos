{ config, pkgs, lib, ... }:

let
  # Lê o conteúdo do arquivo .env
  envFile = builtins.readFile ./.env;

  # Função para extrair variáveis de ambiente
  getEnvVar = name: let
    matches = builtins.match ".*${name}=([^\n]*).*" envFile;
  in
    if matches != null then
      lib.strings.removeSuffix " " (builtins.elemAt matches 0)
    else
      throw ''Variável ${name} não encontrada no arquivo .env'';

  hostname = getEnvVar "HOSTNAME";

  # Caminhos para configurações específicas
  specificConfigPath = ./hosts/${hostname}/settings.nix;
  hardwareConfigPath = ./hosts/${hostname}/hardware-configuration.nix;
 

in {
  
  # Define o hostname do sistema
  networking.hostName = hostname;

  # Importa configurações comuns, específicas e de hardware com base no hostname
  imports = [
    hardwareConfigPath
    specificConfigPath
  ];


    # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Habilita suporte ao Wayland e Hyprland
  # programs.hyprland.enable = true;
  # services.displayManager.sddm.wayland.enable = true;

  # # Suporte para swaylock/swayidle e ferramentas comuns no Wayland
  # security.pam.services.login.enableGnomeKeyring = true;
  # programs.dconf.enable = true;

  # Login gráfico
  # services.displayManager.sddm.enable = true;  # ou outro, como GDM


  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Bahia";

  # Select internationalisation properties.
  i18n.defaultLocale = "pt_BR.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };


  # Configure console keymap
  console.keyMap = "br-abnt2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dg = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Evandro";
    extraGroups = [ "networkmanager" "wheel" "docker"];
  };

  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  programs.nix-ld.enable = true;

  # Enable automatic login for the user.
  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "dg";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    go
    vscode
    google-chrome
    docker
    zed
    qbittorrent
    vlc
    fzf
    libreoffice
    webtorrent_desktop
    gnome-tweaks
    python3
    temurin-jre-bin-24
    direnv
    vscode-extensions.mkhl.direnv
    psmisc
    apacheHttpd
    tig
    xreader
    nmap
    nemo
  ] ++(config.myExtraPackages or []);

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      theme = "agnoster";
    };
  };

  virtualisation.docker.enable = true;

  systemd.services.startup = {
    description = "Executa um script após a rede estar disponível";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "/home/dg/scripts/startup.sh";
      RemainAfterExit = true;
    };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "24.11";

}
