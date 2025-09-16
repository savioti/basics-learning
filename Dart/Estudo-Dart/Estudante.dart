class Estudante {
  var _nome;
  var _idade;
  var _curso;
  var _notas;

  String get nome => _nome;
  set nome(String value) => _nome = value;
  set notas(List<num> values) => _notas = [...values];

  Estudante(var nome, var idade, [var curso = 'Sistemas']) {
    _nome = nome;
    _idade = idade;
    _curso = curso;
  }

  Estudante.convidado(var nome, var idade) {
    _nome = nome;
    _idade = idade;
    _curso = 'Convidado';
  }

  void mostrarInfo() {
    print('Informações:\n$_nome\n$_idade\n$_curso');
  }

  num calcularNotas() {
    if ((_notas == null) || (_notas.length == 0))
      throw Exception('Não há notas registradas!');

    num notaFinal = 0;
    _notas.forEach((nota) => notaFinal += nota);

    return notaFinal / _notas.length;
  }
}
