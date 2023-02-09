package org.example.modelo;

import org.example.ConnectionFactory;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class AlocacaoDao {
    private Connection connection;

    public AlocacaoDao() {
        this.connection = new ConnectionFactory().getConnection();
    }

    public void adiciona(Alocacao alocacao) {
        String sql = "INSERT INTO Alocacao " +
                "(id_professor, id_curso, dia_da_semana, horario)" +
                "values (?,?,?,?)";

        try {
            PreparedStatement stmt = connection.prepareStatement(sql);

            stmt.setLong(1, alocacao.getProfessor());
            stmt.setLong(2, alocacao.getCurso());
            stmt.setString(3, alocacao.getDiaDaSemana());
            stmt.setTimestamp(4, alocacao.getHorario());

            stmt.execute();
            stmt.close();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
