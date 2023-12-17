package com.example.servletjsp;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BookmarkDAO {
    public static Connection connection;
    public static PreparedStatement preparedStatement;
    public static ResultSet resultSet;

    public BookmarkDAO(){

    }

    public boolean insertBookmark(BookmarkDTO bookmarkDTO){
        int affected = 0;

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd '('E')' HH:mm:ss");
            String currentTime = sdf.format(new Date());

            String sql = "insert into bookmark_list(group_id, mgr_no, registered_dttm) values (?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, bookmarkDTO.getGroupId());
            preparedStatement.setString(2, bookmarkDTO.getMgrNo());
            preparedStatement.setString(3, currentTime);

            affected = preparedStatement.executeUpdate();

            if(affected > 0){
                System.out.println("북마크 삽입 완료");
            }else{
                System.out.println("북마크 삽입 실패");
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return affected > 0;
    }

    public BookmarkDTO selectBookmark(int id){
        BookmarkDTO bookmarkDTO = new BookmarkDTO();

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();
            String sql = "select * from bookmark_list where id = ?";
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                bookmarkDTO.setId(resultSet.getInt("id"));
                bookmarkDTO.setGroupId(resultSet.getInt("group_id"));
                bookmarkDTO.setMgrNo(resultSet.getString("mgr_no"));
                bookmarkDTO.setRegisteredDttm(resultSet.getString("registered_dttm"));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return bookmarkDTO;
    }

    public boolean deleteBookmark(int id){
        int affected = 0;

        connection = null;
        preparedStatement = null;
        resultSet = null;

        try {
            connection = DBConnect.connectDB();
            String sql = " delete from bookmark_list where id = ? ";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            affected = preparedStatement.executeUpdate();

            if (affected > 0) {
                System.out.println("북마크 데이터 삭제 완료");
            } else {
                System.out.println("북마크 데이터 삭제 실패");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return affected > 0;
    }

    public List<BookmarkDTO> selectBookmarkList(){
        connection = null;
        preparedStatement = null;
        resultSet = null;

        List<BookmarkDTO> list = new ArrayList<>();

        try {
            connection = DBConnect.connectDB();

            String sql = "select bookmark_list.* from bookmark_list inner join bookmark_group ON bookmark_list.group_id = bookmark_group.id order by bookmark_group.order_no";

            preparedStatement = connection.prepareStatement(sql);
            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                BookmarkDTO bookmarkDTO = BookmarkDTO.builder()
                        .id(resultSet.getInt("id"))
                        .groupId(resultSet.getInt("group_id"))
                        .mgrNo(resultSet.getString("mgr_no"))
                        .registeredDttm(resultSet.getString("registered_dttm"))
                        .build();

                list.add(bookmarkDTO);
            }

        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return list;
    }
}
