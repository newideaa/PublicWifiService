<%--
  Created by IntelliJ IDEA.
  User: dbtnr
  Date: 2023-12-12
  Time: 오전 1:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servletjsp.WifiDAO" %>
<%@ page import="com.example.servletjsp.WifiDTO" %>
<%@ page import="java.util.*" %>
<%@ page import="com.example.servletjsp.BookmarkGroupDAO" %>
<%@ page import="com.example.servletjsp.BookmarkGroupDTO" %>
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
        .input{
            padding: 8px;
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
        WifiDAO wifiDAO = new WifiDAO();
        String distance = request.getParameter("distance");
        String mgrNo = request.getParameter("mgrNo");
        WifiDTO wifiDTO = wifiDAO.selectWifiInfo(mgrNo, Double.parseDouble(distance));

        BookmarkGroupDAO bookmarkGroupDAO = new BookmarkGroupDAO();
        List<BookmarkGroupDTO> bookmarkGroupDTOList = bookmarkGroupDAO.selectBookmarkGroupList();
        request.setAttribute("bookmarkList", bookmarkGroupDTOList);
    %>
    <h1>와이파이 정보 구하기</h1>
    <ul class = "horizontal-menu">
        <li><a href="http://localhost:8080">홈</a></li>
        <li><a href="history.jsp">위치 히스토리 목록</a></li>
        <li><a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="bookmark-list.jsp">북마크 보기</a></li>
        <li><a href="bookmark-group.jsp">북마크 그룹 관리</a></li>
    </ul>
    <br>
    <form action="bookmark-add.jsp" method="post" id="bookmarkList">
        <select name="bGroupName">
            <option value = "#" selected>북마크 그룹 이름 선택</option>
            <%
                for(BookmarkGroupDTO bookmarkGroupDTO : bookmarkGroupDTOList) {
            %>
            <option value="<%=bookmarkGroupDTO.getId()%>">
                <%=bookmarkGroupDTO.getBookmarkName()%>
            </option>
            <%
                }
            %>
        </select>
        <input type="submit" value="북마크 추가하기">
        <input type="hidden" name="mgrNo" value="<%=mgrNo%>">
    </form>
    <table>
        <tbody>
        <tr>
            <th>거리(Km)</th>
            <td><%=wifiDTO.getDistance()%></td>
        </tr>
        <tr>
            <th>관리번호</th>
            <td><%=wifiDTO.getXSwifiMgrNo()%></td>
        </tr>
        <tr>
            <th>자치구</th>
            <td><%=wifiDTO.getXSwifiWrdofc()%></td>
        </tr>
        <tr>
            <th>와이파이명</th>
            <td><%=wifiDTO.getXSwifiMainNm()%></td>
        </tr>
        <tr>
            <th>도로명주소</th>
            <td><%=wifiDTO.getXSwifiAdres1()%></td>
        </tr>
        <tr>
            <th>상세주소</th>
            <td><%=wifiDTO.getXSwifiAdres2()%></td>
        </tr>
        <tr>
            <th>설치위치(층)</th>
            <td><%=wifiDTO.getXSwifiInstlFloor()%></td>
        </tr>
        <tr>
            <th>설치유형</th>
            <td><%=wifiDTO.getXSwifiInstlTy()%></td>
        </tr>
        <tr>
            <th>설치기관</th>
            <td><%=wifiDTO.getXSwifiInstlMby()%></td>
        </tr>
        <tr>
            <th>서비스구분</th>
            <td><%=wifiDTO.getXSwifiSvcSe()%></td>
        </tr>
        <tr>
            <th>망종류</th>
            <td><%=wifiDTO.getXSwifiCmcwr()%></td>
        </tr>
        <tr>
            <th>설치년도</th>
            <td><%=wifiDTO.getXSwifiCnstcYear()%></td>
        </tr>
        <tr>
            <th>실내외구분</th>
            <td><%=wifiDTO.getXSwifiInoutDoor()%></td>
        </tr>
        <tr>
            <th>WIFI접속환경</th>
            <td><%=wifiDTO.getXSwifiRemars3()%></td>
        </tr>
        <tr>
            <th>X좌표</th>
            <td><%=wifiDTO.getLat()%></td>
        </tr>
        <tr>
            <th>Y좌표</th>
            <td><%=wifiDTO.getLnt()%></td>
        </tr><tr>
            <th>작업일자</th>
            <td><%=wifiDTO.getWorkDttm()%></td>
        </tr>
        </tbody>
    </table>
</body>
</html>
