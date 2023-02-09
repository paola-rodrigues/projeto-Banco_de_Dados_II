package org.example;

import org.example.modelo.*;

import java.util.Calendar;
import java.util.List;
import java.util.Scanner;
import java.sql.*;

public class Main {
    public static void main(String[] args) throws SQLException {
        Scanner input = new Scanner(System.in);

        System.out.println("""
                --- Seja Bem-Vindo(a) ---

                Digite 1 para Adicionar Departamento
                Digite 2 para Adicionar Curso
                Digite 3 para Adicionar Professor
                Digite 4 para montar Alocação
                """);

        System.out.print("Sua Opção: ");
        String opcao = input.nextLine();

        switch (opcao) {
            case "1" -> {
                // Adiciona Departamentos
                Departamentos departamento = new Departamentos();
                System.out.print("Nome Departamento: ");
                departamento.setNome(input.nextLine());

                DepartamentosDao dao = new DepartamentosDao();
                dao.adiciona(departamento);

                System.out.println("Departamento " + departamento.getNome() + " adicionado!");
                break;
            }
            case "2" -> {
                // Adiciona Curso
                Curso curso = new Curso();
                System.out.print("Nome Curso: ");
                curso.setNome(input.nextLine());

                CursoDao dao = new CursoDao();
                dao.adiciona(curso);

                System.out.println("Curso " + curso.getNome() + " adicionado!");
                break;
            }
            case "3" -> {
                // Adiciona Professor
                Professor professor = new Professor();
                System.out.print("Nome do Professor(a): ");
                professor.setNome(input.nextLine());
                System.out.print("CPF do Professor(a): ");
                professor.setCpf(input.nextLine());

                // Verifica o departamento do professor
                System.out.print("Departamento do Professor(a): ");
                String professorDepartamento = input.nextLine();

                DepartamentosDao Depdao = new DepartamentosDao();
                List<Departamentos> departamentos = Depdao.getLista();

                for (Departamentos departamento : departamentos) {
                    if (professorDepartamento.equals(departamento.getNome())) {
                        System.out.println("Departamento existe!");
                        professor.setDepartamento(departamento.getId());
                        break;
                    }
                }

                if (professor.getDepartamento() != null) {
                    ProfessorDao dao = new ProfessorDao();
                    dao.adiciona(professor);

                    System.out.println("Professor(a) " + professor.getNome() + " adicionado(a)!");
                } else {
                    System.out.println("Não foi possível Adicionar o Professor!");
                }
                break;
            }
            case "4" -> {
                // Cria Alocação
                Alocacao alocacao = new Alocacao();

                // Verifica Professor
                System.out.print("Professor para Alocação: ");
                String nomeProfessor = input.nextLine();

                ProfessorDao Profdao = new ProfessorDao();
                List<Professor> professores = Profdao.getLista();
                for (Professor professor : professores) {
                    if (nomeProfessor.equals(professor.getNome())) {
                        System.out.println("Professor existe!");
                        alocacao.setProfessor(professor.getId());
                        break;
                    }
                }

                if (alocacao.getProfessor() == null) {
                    System.out.println("Professor Inválido.");
                    break;
                }

                // Verifica Curso
                System.out.print("Curso para Alocação: ");
                String nomeCurso = input.nextLine();

                CursoDao Curdao = new CursoDao();
                List<Curso> cursos = Curdao.getLista();
                for (Curso curso : cursos) {
                    if (nomeCurso.equals(curso.getNome())) {
                        System.out.println("Curso existe!");
                        alocacao.setCurso(curso.getId());
                        break;
                    }
                }

                if (alocacao.getCurso() == null) {
                    System.out.println("Curso Inválido.");
                    break;
                }

                System.out.print("Dia da Semana para Alocação: ");
                alocacao.setDiaDaSemana(input.nextLine());

                long dateTime = System.currentTimeMillis();

                alocacao.setHorario(new Timestamp(dateTime));
                System.out.println("O horário será " + alocacao.getHorario());

                AlocacaoDao dao = new AlocacaoDao();
                dao.adiciona(alocacao);
                break;
            }
            default -> System.out.println("Opção Inválida ou ainda não implementada!");
        }
    }
}