class Funcionario {
  final _nome;
  final _idade;

  Funcionario(this._nome, this._idade);

  void mostrarInfo() {
    print('Informações:\n$_nome\n$_idade');
  }
}
