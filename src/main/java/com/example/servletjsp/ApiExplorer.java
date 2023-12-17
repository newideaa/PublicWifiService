package com.example.servletjsp;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;
import okhttp3.ResponseBody;

import java.net.URL;
import java.io.IOException;

import static com.example.servletjsp.WifiDAO.insertWifiInfo;

public class ApiExplorer {
    private static String API_URL = "http://openapi.seoul.go.kr:8088/4e74684a4564627434364e48475777/json/TbPublicWifiInfo/";
    private static OkHttpClient okHttpClient = new OkHttpClient();

    public static int WifiCount() throws IOException {
        int cnt = 0;

        URL url = new URL(API_URL + "1/1");

        Request.Builder request = new Request.Builder().url(url).get();

        Response response = okHttpClient.newCall(request.build()).execute();

        try {
            if (response.isSuccessful()) {
                ResponseBody responseBody = response.body();

                if (responseBody != null) {
                    JsonElement jsonElement = JsonParser.parseString(responseBody.string());

                    cnt = jsonElement.getAsJsonObject().get("TbPublicWifiInfo")
                            .getAsJsonObject().get("list_total_count")
                            .getAsInt();

                    System.out.println("와이파이 개수 : " + cnt);
                }
            } else {
                System.out.println("API 호출 실패 : " + response.code());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cnt;
    }

    public static int getWifiInfo() throws IOException {
        int totalCnt = WifiCount();
        int start = 1;
        int end = 1;
        int cnt = 0;

        try {
            for (int i = 0; i <= totalCnt / 1000; i++) {
                start = 1 + (1000 * i);
                end = (i + 1) * 1000;

                URL url = new URL(API_URL + start + "/" + end);

                Request.Builder request = new Request.Builder().url(url).get();
                Response response = okHttpClient.newCall(request.build()).execute();

                if (response.isSuccessful()) {
                    ResponseBody responseBody = response.body();

                    if (responseBody != null) {
                        JsonElement jsonElement = JsonParser.parseString(responseBody.string());

                        JsonArray jsonArray = jsonElement.getAsJsonObject().get("TbPublicWifiInfo")
                                .getAsJsonObject().get("row")
                                .getAsJsonArray();

                        cnt += insertWifiInfo(jsonArray);
                    } else {
                        System.out.println("API 호출 실패 : " + response.code());
                    }
                } else {
                    System.out.println("API 호출 실패 : " + response.code());
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return cnt;
    }
}
