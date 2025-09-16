package ExercicioCozinha;

import java.time.LocalDate;

public class Programa {
    public static void main(String[] args) {
        Cozinha cozinhaMineira = new Cozinha(
                Cozinha.Especialidade.Mineira, 14, 20, "Feijoada"
        );

        var ingrediente = new Ingrediente("Feijão", LocalDate.of(2030, 12, 31));
        cozinhaMineira.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Farinha", LocalDate.of(2030, 12, 31));
        cozinhaMineira.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Arroz", LocalDate.of(2030, 12, 31));
        cozinhaMineira.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Carne de porco", LocalDate.of(2020, 4, 14));
        cozinhaMineira.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Linguiça", LocalDate.of(2020, 4, 14));
        cozinhaMineira.adicionarIngrediente(ingrediente);

        var funcionario = new Funcionario("Altieres Pereira", Funcionario.Funcao.Limpeza);
        cozinhaMineira.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("Dara Vieira", Funcionario.Funcao.Cozinheiro);
        cozinhaMineira.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("Arlan Silva", Funcionario.Funcao.Ajudante);
        cozinhaMineira.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("Ângelo Savioti", Funcionario.Funcao.Outro);
        cozinhaMineira.adicionarFuncionario(funcionario);

        System.out.println(cozinhaMineira);

        Cozinha cozinhaChinesa = new Cozinha(
                Cozinha.Especialidade.Chinesa, 10, 21, "Yakissoba"
        );

        ingrediente = new Ingrediente("Champignon", LocalDate.of(2020, 4, 10));
        cozinhaChinesa.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Brócolis", LocalDate.of(2020, 4, 7));
        cozinhaChinesa.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Macarrão", LocalDate.of(2030, 12, 31));
        cozinhaChinesa.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Carne", LocalDate.of(2020, 4, 14));
        cozinhaChinesa.adicionarIngrediente(ingrediente);

        funcionario = new Funcionario("Ana Luiza Faria", Funcionario.Funcao.Cozinheiro);
        cozinhaChinesa.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("José Luiz da Silva", Funcionario.Funcao.Cozinheiro);
        cozinhaChinesa.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("Bernardo Oliveira", Funcionario.Funcao.Ajudante);
        cozinhaChinesa.adicionarFuncionario(funcionario);

        System.out.println(cozinhaChinesa);

        // Pelos ingredientes, eu assumi que o prato principal italiano era espaguete ao
        // invés de Yakissoba.
        Cozinha cozinhaItaliana = new Cozinha(
                Cozinha.Especialidade.Italiana, 13, 22, "Espaguete"
        );

        ingrediente = new Ingrediente("Molho", LocalDate.of(2020, 4, 21));
        cozinhaItaliana.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Macarrão", LocalDate.of(2030, 12, 31));
        cozinhaItaliana.adicionarIngrediente(ingrediente);
        ingrediente = new Ingrediente("Carne", LocalDate.of(2020, 4, 14));
        cozinhaItaliana.adicionarIngrediente(ingrediente);

        funcionario = new Funcionario("Ana Maria", Funcionario.Funcao.Cozinheiro);
        cozinhaItaliana.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("Pietra Guerra", Funcionario.Funcao.Outro);
        cozinhaItaliana.adicionarFuncionario(funcionario);
        funcionario = new Funcionario("Luiz Fernando", Funcionario.Funcao.Ajudante);
        cozinhaItaliana.adicionarFuncionario(funcionario);

        System.out.println(cozinhaItaliana);
    }
}
