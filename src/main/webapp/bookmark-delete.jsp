<%@ page import="com.example.servletjsp.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
<h1>북마크 그룹</h1>
<ul class = "horizontal-menu">
    <li><a href="http://localhost:8080">홈</a></li>
    <li><a href="history.jsp">위치 히스토리 목록</a></li>
    <li><a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
    <li><a href="bookmark-list.jsp">북마크 보기</a></li>
    <li><a href="bookmark-group.jsp">북마크 그룹 관리</a></li>
</ul>
<h4>북마크를 삭제하시겠습니까?</h4>
<%
    String id = request.getParameter("id");

    BookmarkDAO bookmarkDAO = new BookmarkDAO();
    BookmarkDTO bookmarkDTO = bookmarkDAO.selectBookmark(Integer.parseInt(id));

    BookmarkGroupDAO bookmarkGroupDAO = new BookmarkGroupDAO();
    BookmarkGroupDTO bookmarkGroupDTO = bookmarkGroupDAO.selectBookMarkGroup(bookmarkDTO.getGroupId());

    WifiDAO wifiDAO = new WifiDAO();
    WifiDTO wifiDTO = wifiDAO.selectWifiInfo(bookmarkDTO.getMgrNo(), 0);
%>
<form method="post" action="bookmark-delete-data.jsp">
    <table>
        <tr>
            <th>북마크 이름</th>
            <td><%=bookmarkGroupDTO.getBookmarkName()%></td>
        </tr>
        <tr>
            <th>와이파이명</th>
            <td><%=wifiDTO.getXSwifiMainNm()%></td>
        </tr>
        <tr>
            <th>등록일자</th>
            <td><%=bookmarkDTO.getRegisteredDttm()%></td>
        </tr>
        <tr>
            <td colspan="2">
                <input type="submit" name="delete" value="삭제">
                <button type="button" id="backButton">돌아가기</button>
                <input type="hidden" name="id" value="<%=bookmarkDTO.getId()%>">
            </td>
        </tr>
    </table>
</form>
</body>
<script>
    document.getElementById('backButton').addEventListener('click', function (){
        window.location.href = 'bookmark-list.jsp';
    });
</script>
</html>
