{ config, pkgs, lib, ... }:

let
  # Lê o conteúdo do arquivo .env
  envFile = builtins.readFile ./.env;

  # Função para extrair o valor da variável HOSTNAME
  getEnvVar = name: let
    pattern = "^${name}=(.*)$";
    matches = builtins.match pattern envFile;
  in
    if matches != null then
      builtins.elemAt matches 0
    else
      throw "Variável ${name} não encontrada no arquivo .env";

  hostname = getEnvVar "HOSTNAME";
in {


  # builtins.trace "Hostname atual: ${hostname}" hostname
  # Define o hostname do sistema
  networking.hostName = hostname;

  # Importa configurações específicas com base no hostname
  imports = [
    # ./common/base.nix
    (./hosts- + "${hostname}/configuration.nix")
  ];


}
