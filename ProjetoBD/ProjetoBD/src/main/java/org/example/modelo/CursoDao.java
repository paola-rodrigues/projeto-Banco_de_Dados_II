package org.example.modelo;

import org.example.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CursoDao {
    private Connection connection;

    public CursoDao() {
        this.connection = new ConnectionFactory().getConnection();
    }

    public void adiciona(Curso curso) {
        String sql = "INSERT INTO Curso " +
                "(nome)" +
                "values (?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, curso.getNome());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Curso> getLista() {
        try {
            List<Curso> cursos = new ArrayList<Curso>();
            PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM Curso");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Curso curso = new Curso();
                curso.setId(rs.getLong("id_curso"));
                curso.setNome(rs.getString("nome"));

                cursos.add(curso);
            }

            rs.close();
            stmt.close();
            return cursos;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
