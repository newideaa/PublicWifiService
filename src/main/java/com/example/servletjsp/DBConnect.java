package com.example.servletjsp;

import java.sql.*;

public class DBConnect {
    public static Connection connectDB(){
        String dbPath = "C:/gonis_gitrepo/ZerobaseStudy/ServletJSP/ServletJSP.db";
        String url = "jdbc:sqlite:" + dbPath;

        Connection connection = null;

        try{
            Class.forName("org.sqlite.JDBC");
            connection = DriverManager.getConnection(url);
        }catch (ClassNotFoundException | SQLException e){
            e.printStackTrace();
        }

        return connection;
    }

    public static void close(Connection connection, PreparedStatement preparedStatement, ResultSet resultSet){
        try {
            if(resultSet != null && !resultSet.isClosed()){
                resultSet.close();
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        try{
            if(preparedStatement != null && !preparedStatement.isClosed()){
                preparedStatement.close();
            }
        }catch (SQLException e){
            e.printStackTrace();
        }

        try {
            if(connection !=null && connection.isClosed()){
                connection.close();
            }
        }catch (SQLException e){
            e.printStackTrace();
        }
    }
}
