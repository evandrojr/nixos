# debug.nix - Exemplo de como debugar variáveis em Nix
let
  # Variáveis de exemplo
  nome = "João";
  idade = 25;
  lista = [ 1 2 3 ];
  attrs = { a = 10; b = 20; };

  # Debugging individual
  a = builtins.trace "Debug nome: ${nome}" nome;

  in{
    inherit idade;
  }
#   debug2 = builtins.trace "Debug idade: ${toString idade}" idade;
#   debug3 = builtins.trace "Debug lista: ${toString lista}" lista;
#   debug4 = builtins.trace "Debug attrs: ${builtins.toJSON attrs}" attrs;

#   # Debugging aninhado
#   resultadoFinal = builtins.trace "Debug calculo: ${toString (idade * 2)}" (
#     builtins.trace "Debug lista modificada: ${toString (map (x: x * 2) lista)}" (
#       idade * 2 + attrs.a
#     )
#   );
# in {
#   inherit debug1 debug2 debug3 debug4;
#   final = resultadoFinal;
# }