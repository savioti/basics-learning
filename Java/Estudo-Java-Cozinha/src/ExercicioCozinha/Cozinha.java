package ExercicioCozinha;

import java.util.ArrayList;
import java.util.Arrays;

public class Cozinha {
    private final Especialidade especialidade;
    private int horaAbertura;
    private int horaFechamento;
    private String pratoPrincipal;
    private final ArrayList<Ingrediente> ingredientes;
    private final ArrayList<Funcionario> funcionarios;

    public enum Especialidade {
        Mineira, Chinesa, Italiana, Japonesa, Mexicana
    }

    public Cozinha(Especialidade especialidade, int horaAbertura, int horaFechamento, String pratoPrincipal) {
        this.especialidade = especialidade;
        this.horaAbertura = horaAbertura;
        this.horaFechamento = horaFechamento;
        this.pratoPrincipal = pratoPrincipal;
        ingredientes = new ArrayList<>();
        funcionarios = new ArrayList<>();
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        String mensagem = "";
        mensagem += "Cozinha de especialidade " + especialidade + ":\n";
        mensagem += "Horário de abertura: " + horaAbertura + "hrs\n";
        mensagem += "Horário de fechamento: " + horaFechamento + "hrs\n";
        mensagem += "Prato principal: " + pratoPrincipal + "\n";
        mensagem += "Ingredientes:\n";
        stringBuilder.append(mensagem);

        for (Ingrediente ingrediente : ingredientes) {
            mensagem = " - " + ingrediente.toString() + "\n";
            stringBuilder.append(mensagem);
        }

        stringBuilder.append("Funcionários:\n");

        for (Funcionario funcionario : funcionarios) {
            mensagem = " - " + funcionario.toString() + "\n";
            stringBuilder.append(mensagem);
        }

        return stringBuilder.toString();
    }

    public void adicionarIngrediente(Ingrediente ingrediente) {
        ingredientes.add(ingrediente);
    }

    public void adicionarIngrediente(Ingrediente... ingredientes) {
        this.ingredientes.addAll(Arrays.asList(ingredientes));
    }

    public void adicionarFuncionario(Funcionario funcionario) {
        funcionarios.add(funcionario);
    }

    public void adicionarFuncionario(Funcionario... funcionarios) {
        this.funcionarios.addAll(Arrays.asList(funcionarios));
    }

    public int getHoraAbertura() {
        return horaAbertura;
    }

    public void setHoraAbertura(int horaAbertura) {
        this.horaAbertura = horaAbertura;
        validarHorarios();
    }

    public int getHoraFechamento() {
        return horaFechamento;
    }

    public void setHoraFechamento(int horaFechamento) {
        this.horaFechamento = horaFechamento;
        validarHorarios();
    }

    public String getPratoPrincipal() {
        return pratoPrincipal;
    }

    public void setPratoPrincipal(String pratoPrincipal) {
        this.pratoPrincipal = pratoPrincipal;
    }

    private void validarHorarios() {
        if (horaAbertura > 23)
            horaAbertura = 23;

        if (horaAbertura < 0)
            horaAbertura = 0;

        if (horaFechamento > 23)
            horaFechamento = 23;

        if (horaFechamento < 0)
            horaFechamento = 0;
    }
}
