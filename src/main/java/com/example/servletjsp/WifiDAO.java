package com.example.servletjsp;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.example.servletjsp.WifiDTO;
import com.example.servletjsp.DBConnect;

import static com.example.servletjsp.HistoryDAO.insertHistory;

public class WifiDAO {
    public static Connection connection;
    public static ResultSet resultSet;
    public static PreparedStatement preparedStatement;

    public WifiDAO() {

    }

    public static int insertWifiInfo(JsonArray jsonArray) {
        connection = null;
        preparedStatement = null;
        resultSet = null;

        int count = 0;

        try {
            connection = DBConnect.connectDB();
            connection.setAutoCommit(false);

            String sql = "insert into wifi_info(X_SWIFI_MGR_NO, X_SWIFI_WRDOFC, X_SWIFI_MAIN_NM, X_SWIFI_ADRES1, X_SWIFI_ADRES2, X_SWIFI_INSTL_FLOOR, X_SWIFI_INSTL_TY, X_SWIFI_INSTL_MBY, X_SWIFI_SVC_SE, X_SWIFI_CMCWR, X_SWIFI_CNSTC_YEAR, X_SWIFI_INOUT_DOOR, X_SWIFI_REMARS3, LAT, LNT, WORK_DTTM) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);";

            preparedStatement = connection.prepareStatement(sql);

            for (int i = 0; i < jsonArray.size(); i++) {
                JsonObject data = (JsonObject) jsonArray.get(i).getAsJsonObject();

                preparedStatement.setString(1, data.get("X_SWIFI_MGR_NO").getAsString());
                preparedStatement.setString(2, data.get("X_SWIFI_WRDOFC").getAsString());
                preparedStatement.setString(3, data.get("X_SWIFI_MAIN_NM").getAsString());
                preparedStatement.setString(4, data.get("X_SWIFI_ADRES1").getAsString());
                preparedStatement.setString(5, data.get("X_SWIFI_ADRES2").getAsString());
                preparedStatement.setString(6, data.get("X_SWIFI_INSTL_FLOOR").getAsString());
                preparedStatement.setString(7, data.get("X_SWIFI_INSTL_TY").getAsString());
                preparedStatement.setString(8, data.get("X_SWIFI_INSTL_MBY").getAsString());
                preparedStatement.setString(9, data.get("X_SWIFI_SVC_SE").getAsString());
                preparedStatement.setString(10, data.get("X_SWIFI_CMCWR").getAsString());
                preparedStatement.setString(11, data.get("X_SWIFI_CNSTC_YEAR").getAsString());
                preparedStatement.setString(12, data.get("X_SWIFI_INOUT_DOOR").getAsString());
                preparedStatement.setString(13, data.get("X_SWIFI_REMARS3").getAsString());
                preparedStatement.setString(14, data.get("LAT").getAsString());
                preparedStatement.setString(15, data.get("LNT").getAsString());
                preparedStatement.setString(16, data.get("WORK_DTTM").getAsString());

                preparedStatement.addBatch();
                preparedStatement.clearParameters();

                if ((i + 1) % 1000 == 0) {
                    int[] result = preparedStatement.executeBatch();
                    count += result.length;
                    connection.commit();
                }
            }

            int[] result = preparedStatement.executeBatch();
            count += result.length;
            connection.commit();
        } catch (SQLException e) {
            e.printStackTrace();

            try {
                connection.rollback();
            } catch (SQLException sqlException) {
                sqlException.printStackTrace();
            }
        } finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return count;
    }

    public List<WifiDTO> getNearWifiInfo(String lat, String lnt) {

        connection = null;
        preparedStatement = null;
        resultSet = null;

        List<WifiDTO> list = new ArrayList<>();

        try {
            connection = DBConnect.connectDB();

            String sql = "select *, round(6731*acos(cos(radians(?))*cos(radians(LAT))*cos(radians(LNT)-radians(?))+sin(radians(?))*sin(radians(LAT))), 4)"
                    + "as distance from wifi_info order by distance limit 20;";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setDouble(1, Double.parseDouble(lat));
            preparedStatement.setDouble(2, Double.parseDouble(lnt));
            preparedStatement.setDouble(3, Double.parseDouble(lat));

            resultSet = preparedStatement.executeQuery();

            while(resultSet.next()){
                WifiDTO wifiDTO = WifiDTO.builder()
                        .distance(resultSet.getDouble("distance"))
                        .xSwifiMgrNo(resultSet.getString("X_SWIFI_MGR_NO"))
                        .xSwifiWrdofc(resultSet.getString("X_SWIFI_WRDOFC"))
                        .xSwifiMainNm(resultSet.getString("X_SWIFI_MAIN_NM"))
                        .xSwifiAdres1(resultSet.getString("X_SWIFI_ADRES1"))
                        .xSwifiAdres2(resultSet.getString("X_SWIFI_ADRES2"))
                        .xSwifiInstlFloor(resultSet.getString("X_SWIFI_INSTL_FLOOR"))
                        .xSwifiInstlTy(resultSet.getString("X_SWIFI_INSTL_TY"))
                        .xSwifiInstlMby(resultSet.getString("X_SWIFI_INSTL_MBY"))
                        .xSwifiSvcSe(resultSet.getString("X_SWIFI_SVC_SE"))
                        .xSwifiCmcwr(resultSet.getString("X_SWIFI_CMCWR"))
                        .xSwifiCnstcYear(resultSet.getString("X_SWIFI_CNSTC_YEAR"))
                        .xSwifiInoutDoor(resultSet.getString("X_SWIFI_INOUT_DOOR"))
                        .xSwifiRemars3(resultSet.getString("X_SWIFI_REMARS3"))
                        .lat(resultSet.getString("LAT"))
                        .lnt(resultSet.getString("LNT"))
                        .workDttm(String.valueOf(resultSet.getTimestamp("WORK_DTTM").toLocalDateTime()))
                        .build();

                list.add(wifiDTO);
            }
        } catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        insertHistory(lat, lnt);

        return list;
    }

    public WifiDTO selectWifiInfo(String mgrNo,double distance){
        connection = null;
        preparedStatement = null;
        resultSet = null;

        WifiDTO wifiDTO = new WifiDTO();
        try{
            connection = DBConnect.connectDB();

            String sql = "select * from wifi_info where X_SWIFI_MGR_NO = ?;";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, mgrNo);

            resultSet = preparedStatement.executeQuery();


            while(resultSet.next()){
                wifiDTO.setDistance(distance);
                wifiDTO.setXSwifiMgrNo(resultSet.getString("X_SWIFI_MGR_NO"));
                wifiDTO.setXSwifiWrdofc(resultSet.getString("X_SWIFI_WRDOFC"));
                wifiDTO.setXSwifiMainNm(resultSet.getString("X_SWIFI_MAIN_NM"));
                wifiDTO.setXSwifiAdres1(resultSet.getString("X_SWIFI_ADRES1"));
                wifiDTO.setXSwifiAdres2(resultSet.getString("X_SWIFI_ADRES2"));
                wifiDTO.setXSwifiInstlFloor(resultSet.getString("X_SWIFI_INSTL_FLOOR"));
                wifiDTO.setXSwifiInstlTy(resultSet.getString("X_SWIFI_INSTL_TY"));
                wifiDTO.setXSwifiInstlMby(resultSet.getString("X_SWIFI_INSTL_MBY"));
                wifiDTO.setXSwifiSvcSe(resultSet.getString("X_SWIFI_SVC_SE"));
                wifiDTO.setXSwifiCmcwr(resultSet.getString("X_SWIFI_CMCWR"));
                wifiDTO.setXSwifiCnstcYear(resultSet.getString("X_SWIFI_CNSTC_YEAR"));
                wifiDTO.setXSwifiInoutDoor(resultSet.getString("X_SWIFI_INOUT_DOOR"));
                wifiDTO.setXSwifiRemars3(resultSet.getString("X_SWIFI_REMARS3"));
                wifiDTO.setLat(resultSet.getString("LAT"));
                wifiDTO.setLnt(resultSet.getString("LNT"));
                wifiDTO.setWorkDttm(resultSet.getString("WORK_DTTM"));
            }
        }catch (SQLException e){
            e.printStackTrace();
        }finally {
            DBConnect.close(connection, preparedStatement, resultSet);
        }

        return wifiDTO;
    }
}
