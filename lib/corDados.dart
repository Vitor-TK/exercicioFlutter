class Dados {
  int a, r, g, b;
  int correto;
  List<String> opcoes;

  Dados(this.r, this.g, this.b, this.a, this.correto, this.opcoes);
  Dados.empty(
      {this.a = 0,
      this.r = 0,
      this.g = 0,
      this.b = 0,
      this.correto = 0,
      this.opcoes = const []});
}