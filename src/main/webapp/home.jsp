<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servletjsp.WifiDAO" %>
<%@ page import="com.example.servletjsp.WifiDTO" %>
<%@ page import="java.util.List" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        /* 기본적인 스타일링 */
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        /* 가로 메뉴 스타일링 */
        ul.horizontal-menu {
            list-style-type: none;
            margin: 0;
            padding: 8px;
            overflow: hidden;
        }

        ul.horizontal-menu li {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 10px 10px;
            text-decoration: none;
            border-right: 1px solid black; /* 우측에 1px 실선 테두리 추가 */
        }

        ul.horizontal-menu li:last-child {
            border-right: none; /* 마지막 메뉴 항목에는 우측 테두리 없음 */
        }
        table {
            border-collapse: collapse;
            width: 100%;
        }

        table, th {
            border: 1px solid white;
            padding: 8px;
            text-align: center;
        }
        td{
            padding: 15px 0;
            border: 1px solid darkgray;
            text-align: center;
        }

        th {
            color: white;
            background-color: darkseagreen;
        }
    </style>
</head>
<body>
    <%
        String lat = request.getParameter("lat") == null ? "0.0" : request.getParameter("lat");
        String lnt = request.getParameter("lnt") == null ? "0.0" : request.getParameter("lnt");
    %>
    <h1>와이파이 정보 구하기</h1>
    <ul class = "horizontal-menu">
        <li><a href="http://localhost:8080">홈</a></li>
        <li><a href="history.jsp">위치 히스토리 목록</a></li>
        <li><a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="bookmark-list.jsp">북마크 보기</a></li>
        <li><a href="bookmark-group.jsp">북마크 그룹 관리</a></li>
    </ul>
    <div class ="input">
        <span>LAT:</span>
        <input type="text" id="lat" value="<%=lat%>">
        <span>, LNT:</span>
        <input type="text" id="lnt" value="<%=lnt%>">

        <button type="button" onclick="getMyLocation()">내 위치 가져오기</button>
        <button type="button" onclick="getNearWifiInfo()">근처 WIFI 정보 보기</button>
    </div>
    <br>
    <table id="dataTable">
        <thead>
        <tr>
            <th>거리(Km)</th>
            <th>관리번호</th>
            <th>자치구</th>
            <th>와이파이명</th>
            <th>도로명주소</th>
            <th>상세주소</th>
            <th>설치위치(층)</th>
            <th>설치유형</th>
            <th>설치기관</th>
            <th>서비스구분</th>
            <th>망종류</th>
            <th>설치년도</th>
            <th>실내외구분</th>
            <th>WIFI접속환경</th>
            <th>X좌표</th>
            <th>Y좌표</th>
            <th>작업일자</th>
        </tr>
        </thead>
        <tbody>
        <%
            if(!("0.0").equals(lat) && !("0.0").equals(lnt)) {
                WifiDAO wifiDAO = new WifiDAO();
                List<WifiDTO> list = wifiDAO.getNearWifiInfo(lat, lnt);

                if(list != null){
                    for(WifiDTO wifiDTO : list){
        %>
            <tr>
                <td><%=wifiDTO.getDistance()%></td>
                <td><%=wifiDTO.getXSwifiMgrNo()%></td>
                <td><%=wifiDTO.getXSwifiWrdofc()%></td>
                <td><a href="detail_wifi.jsp?mgrNo=<%=wifiDTO.getXSwifiMgrNo()%>&distance=<%=wifiDTO.getDistance()%>&wifiname=<%=wifiDTO.getXSwifiMainNm()%>"> <%=wifiDTO.getXSwifiMainNm()%></a></td>
                <td><%=wifiDTO.getXSwifiAdres1()%></td>
                <td><%=wifiDTO.getXSwifiAdres2()%></td>
                <td><%=wifiDTO.getXSwifiInstlFloor()%></td>
                <td><%=wifiDTO.getXSwifiInstlMby()%></td>
                <td><%=wifiDTO.getXSwifiInstlTy()%></td>
                <td><%=wifiDTO.getXSwifiSvcSe()%></td>
                <td><%=wifiDTO.getXSwifiCmcwr()%></td>
                <td><%=wifiDTO.getXSwifiCnstcYear()%></td>
                <td><%=wifiDTO.getXSwifiInoutDoor()%></td>
                <td><%=wifiDTO.getXSwifiRemars3()%></td>
                <td><%=wifiDTO.getLat()%></td>
                <td><%=wifiDTO.getLnt()%></td>
                <td><%=wifiDTO.getWorkDttm()%></td>
            </tr>
        <%
                    }
                }
            } else {
        %>
            <td colspan="17">위치 정보를 입력한 후에 조회해 주세요.</td>
        <%
            }
        %>
        <%-- 기존에 테이블에 추가할 데이터가 있다면 여기에 추가 --%>
        </tbody>
    </table>
    <script>
        function getMyLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                alert("Geolocation is not supported by this browser.");
            }
        }

        function showPosition(position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;

            document.getElementById("lat").value = latitude;
            document.getElementById("lnt").value = longitude;
        }

        function showError(error) {
            switch (error.code) {
                case error.PERMISSION_DENIED:
                    alert("User denied the request for Geolocation.");
                    break;
                case error.POSITION_UNAVAILABLE:
                    alert("Location information is unavailable.");
                    break;
                case error.TIMEOUT:
                    alert("The request to get user location timed out.");
                    break;
                case error.UNKNOWN_ERROR:
                    alert("An unknown error occurred.");
                    break;
            }
        }

        function getNearWifiInfo(){
            var latitude = document.getElementById("lat").value;
            var longitude = document.getElementById("lnt").value;

            if(latitude !== "" || longitude !== ""){
                window.location.assign("http://localhost:8080?lat=" + latitude + "&lnt=" + longitude);
            }else{
                alert("위치 정보를 입력하신 후에 조회해주세요.")
            }
        }
    </script>
</body>
</html>
