<%@ page import="com.example.servletjsp.BookmarkGroupDAO" %>
<%@ page import="com.example.servletjsp.BookmarkGroupDTO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>북마크 그룹 수정</title>
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
        button{
            margin-right: 20px;
        }
    </style>
</head>
<body>
<h1>북마크 그룹 수정</h1>
<ul class = "horizontal-menu">
    <li><a href="http://localhost:8080">홈</a></li>
    <li><a href="history.jsp">위치 히스토리 목록</a></li>
    <li><a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
    <li><a href="bookmark-list.jsp">북마크 보기</a></li>
    <li><a href="bookmark-group.jsp">북마크 그룹 관리</a></li>
</ul>
<br>
<%
    String id = request.getParameter("id");

    BookmarkGroupDAO bookmarkGroupDAO = new BookmarkGroupDAO();
    BookmarkGroupDTO bookmarkGroupDTO = bookmarkGroupDAO.selectBookMarkGroup(Integer.parseInt(id));

%>
<form method="post" action="bookmark-group-edit-data.jsp">
<table>
    <tr>
        <th>북마크 이름</th>
        <td><input type="text" name="bookmarkName" value="<%=bookmarkGroupDTO.getBookmarkName()%>"></td>
    </tr>
    <tr>
        <th>순서</th>
        <td><input type="number" name="orderNo" value="<%=bookmarkGroupDTO.getOrderNo()%>"></td>
    </tr>
    <tr>
        <td style="text-align: center;" colspan="2"><input type="submit" name="update" value="수정">
            <button type="button" id="backButton">돌아가기</button></td>
        <input type="hidden" name="id" value="<%=bookmarkGroupDTO.getId()%>">
    </tr>
</table>
</form>
<script>
    document.getElementById('backButton').addEventListener('click', function (){
        window.location.href = 'bookmark-group.jsp';
    });
</script>
</body>
</html>
