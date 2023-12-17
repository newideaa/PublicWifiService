package com.example.servletjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;


public class HistoryDAO {
    public static Connection connection;
    public static PreparedStatement preparedStatement;
    public static ResultSet resultSet;

    public static void insertHistory(String lat, String lnt) {
        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd '('E')' HH:mm:ss");
            String currentTime = sdf.format(new Date());

            String sql = "insert into search_history (LAT, LNT, SEARCH_DTTM) values(?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, lat);
            preparedStatement.setString(2, lnt);
            preparedStatement.setString(3, currentTime);

            preparedStatement.executeUpdate();

            System.out.println("데이터가 삽입 완료되었습니다.");
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }
    }

    public List<HistoryDTO> selectHistoryList() {
        List<HistoryDTO> list = new ArrayList<>();

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try{
            connection = DBConnect.connectDB();

            String sql = "select * from search_history order by id";

            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                HistoryDTO historyDTO = new HistoryDTO(
                        resultSet.getInt("id"),
                        resultSet.getString("lat"),
                        resultSet.getString("lnt"),
                        resultSet.getString("search_dttm")
                );
                list.add(historyDTO);
            }
        }catch (SQLException e){
            e.printStackTrace();
        } finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return list;
    }

    public void deleteHistory(String id){

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();

            String sql = "delete from SEARCH_HISTORY where id = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, Integer.parseInt(id));
            preparedStatement.executeUpdate();

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }
    }
}
