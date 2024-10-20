String baseUrl = "https://cadastro-produtos-fd01a-default-rtdb.firebaseio.com/";

abstract class Endpoints {
  static String usuarios = "$baseUrl/usuarios.json";
  static String produtos = "$baseUrl/produtos.json";
  static String lancamentos = "$baseUrl/lancamentos.json";
  static String fornecedores = "$baseUrl/fornecedores.json";
}
