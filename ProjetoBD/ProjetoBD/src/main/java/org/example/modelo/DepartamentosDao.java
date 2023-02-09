package org.example.modelo;

import org.example.ConnectionFactory;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DepartamentosDao {
    private Connection connection;

    public DepartamentosDao() {
        this.connection = new ConnectionFactory().getConnection();
    }

    public void adiciona(Departamentos departamento) {
        String sql = "INSERT INTO Departamentos " +
                "(nome)" +
                "values (?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setString(1, departamento.getNome());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public List<Departamentos> getLista() {
        try {
            List<Departamentos> departamentos = new ArrayList<Departamentos>();
            PreparedStatement stmt = this.connection.prepareStatement("SELECT * FROM Departamentos");
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Departamentos departamento = new Departamentos();
                departamento.setId(rs.getLong("id_departamento"));
                departamento.setNome(rs.getString("nome"));

                departamentos.add(departamento);
            }

            rs.close();
            stmt.close();
            return departamentos;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
