{ config, pkgs, lib, ... }:

let
  # Lê o conteúdo do arquivo .env
  envFile = builtins.readFile ./.env;

  # Função para extrair o valor da variável HOSTNAME
  getEnvVar = name: let
    pattern = ''^${name}=(.*)$'';
    matches = builtins.match pattern envFile;
  in
    if matches != null then
      builtins.elemAt matches 0
    else
      throw ''Variável ${name} não encontrada no arquivo .env'';

  hostname = getEnvVar "HOSTNAME";
  specificConfigPath = ./hosts-${hostname}/settings.nix;
  hardwareConfigPath = ./hosts-${hostname}/hardware-configuration.nix;
in {

  # Define o hostname do sistema
  networking.hostName = hostname;

  # Importa configurações comuns, específicas e de hardware com base no hostname
  imports = [
    ./common.nix
    hardwareConfigPath
    specificConfigPath
  ];

}
