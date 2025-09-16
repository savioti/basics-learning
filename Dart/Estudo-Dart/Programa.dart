import 'Estudante.dart';
import 'Funcionario.dart';
import 'Professor.dart';

void main(List<String> args) {
  Estudante estudante = new Estudante('Ângelo', 29);
  estudante.mostrarInfo();
  Funcionario funcionario = Funcionario('Brabo', 30);
  funcionario.mostrarInfo();
  Professor professor = Professor('Joaquim', 50, 'IALG');
  professor.mostrarInfo();
  estudante.nome = 'Matheus';
  estudante.mostrarInfo();
  // estudante.notas = [10, 8, 9];

  try {
    print(estudante.calcularNotas());
  } catch (e) {
    print(e);
  } finally {
    estudante.notas = [0];
  }
}
