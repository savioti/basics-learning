import 'Funcionario.dart';

class Professor extends Funcionario {
  final _materia;

  Professor(nome, idade, this._materia) : super(nome, idade);

  @override
  void mostrarInfo() {
    super.mostrarInfo();
    print('$_materia');
  }
}
