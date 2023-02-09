package org.example.modelo;

import org.example.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProfessorDao {
    private Connection connection;

    public ProfessorDao() {
        this.connection = new ConnectionFactory().getConnection();
    }

    public void adiciona(Professor professor) {
        String sql = "INSERT INTO Professor " +
                "(nome, cpf, id_departamento)" +
                "values (?,?,?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, professor.getNome());
            stmt.setString(2, professor.getCpf());
            stmt.setLong(3, professor.getDepartamento());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Professor> getLista() {
        try {
            List<Professor> professores = new ArrayList<Professor>();
            PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM Professor");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Professor professor = new Professor();
                professor.setId(rs.getLong("id_professor"));
                professor.setNome(rs.getString("nome"));
                professor.setCpf(rs.getString("cpf"));
                professor.setDepartamento(rs.getLong("id_departamento"));

                professores.add(professor);
            }

            rs.close();
            stmt.close();
            return professores;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
