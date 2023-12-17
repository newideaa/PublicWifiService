package com.example.servletjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BookmarkGroupDAO {
    public static Connection connection;
    public static PreparedStatement preparedStatement;
    public static ResultSet resultSet;

    public boolean insertBookmarkGroup(String bookmarkName, String orderNo){
        connection = null;
        preparedStatement = null;
        resultSet = null;

        int affectedRows = 0;

        try {
            connection = DBConnect.connectDB();

            String checkSql = "select count(*) from bookmark_group where order_no = ?;";

            preparedStatement = connection.prepareStatement(checkSql);
            preparedStatement.setInt(1, Integer.parseInt(orderNo));
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next() && resultSet.getInt(1) > 0){
                return false;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd '('E')' HH:mm:ss");
            String currentTime = sdf.format(new Date());
            String updatedTime = "";

            String insertSql = "insert into bookmark_group(BOOKMARK_NAME, ORDER_NO, REGISTERED_DTTM, UPDATED_DTTM) values(?, ?, ?, ?);";

            preparedStatement = connection.prepareStatement(insertSql);
            preparedStatement.setString(1, bookmarkName);
            preparedStatement.setInt(2, Integer.parseInt(orderNo));
            preparedStatement.setString(3, currentTime);
            preparedStatement.setString(4, updatedTime);

            affectedRows = preparedStatement.executeUpdate();

            System.out.println("데이터가 삽입 완료되었습니다.");


        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return affectedRows > 0;
    }

    public boolean updateBookmarkGroup(String id, String bookmarkName, int orderNo){
        connection = null;
        preparedStatement = null;
        resultSet = null;

        int affectedRows = 0;

        try{
            connection = DBConnect.connectDB();

            String checkSql = "select count(*) from bookmark_group where order_no = ?;";

            preparedStatement = connection.prepareStatement(checkSql);
            preparedStatement.setInt(1, orderNo);
            resultSet = preparedStatement.executeQuery();

            if(resultSet.next() && resultSet.getInt(1) > 0){
                return false;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd '('E')' HH:mm:ss");
            String currentTime = sdf.format(new Date());

            String sql = "update bookmark_group set bookmark_name = ?, order_no = ?, updated_dttm = ? where id = ?";
            preparedStatement = connection.prepareStatement(sql);

            preparedStatement.setString(1, bookmarkName);
            preparedStatement.setInt(2,orderNo);
            preparedStatement.setString(3, currentTime);
            preparedStatement.setInt(4,Integer.parseInt(id));

            affectedRows = preparedStatement.executeUpdate();

        }catch (SQLException e){
            e.printStackTrace();
            return false;
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return affectedRows > 0;
    }

    public BookmarkGroupDTO selectBookMarkGroup(int id) {

        BookmarkGroupDTO bookMarkGroupDTO = new BookmarkGroupDTO();

        connection = null;
        resultSet = null;
        preparedStatement = null;

        try {
            connection = DBConnect.connectDB();

            String sql = " select * from bookmark_group where id = ? " ;

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                bookMarkGroupDTO.setId(resultSet.getInt("id"));
                bookMarkGroupDTO.setBookmarkName(resultSet.getString("bookmark_name"));
                bookMarkGroupDTO.setOrderNo(resultSet.getInt("order_no"));
                bookMarkGroupDTO.setRegisteredDttm(resultSet.getString("registered_dttm"));
                bookMarkGroupDTO.setUpdatedDttm(resultSet.getString("updated_dttm"));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return bookMarkGroupDTO;
    }

    public List<BookmarkGroupDTO> selectBookmarkGroupList(){
        List<BookmarkGroupDTO> list = new ArrayList<>();

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();

            String sql = "select * from bookmark_group order by order_no;";

            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while (resultSet.next()){
                BookmarkGroupDTO bookmarkGroupDTO = new BookmarkGroupDTO(
                        resultSet.getInt("id"),
                        resultSet.getString("bookmark_name"),
                        resultSet.getInt("order_no"),
                        resultSet.getString("registered_dttm"),
                        resultSet.getString("updated_dttm")
                );

                list.add(bookmarkGroupDTO);
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return list;
    }

    public void deleteBookmarkGroup(String id){

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();

            String sql = "delete from bookmark_group where id = ?";

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
