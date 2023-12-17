<%@ page import="com.example.servletjsp.BookmarkGroupDAO" %><%--
  Created by IntelliJ IDEA.
  User: dbtnr
  Date: 2023-12-18
  Time: 오전 3:36
  To change this template use File | Settings | File Templates.
--%>
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
    button{
      margin-right: 20px;
    }
  </style>
</head>
<body>
<h1>
    북마크 그룹 수정
</h1>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String bookmarkName = request.getParameter("bookmarkName");
    String orderNo = request.getParameter("orderNo");

    BookmarkGroupDAO bookmarkGroupDAO = new BookmarkGroupDAO();
    boolean affected = bookmarkGroupDAO.updateBookmarkGroup(id, bookmarkName, Integer.parseInt(orderNo));
%>
</body>
<script>
    <%
        String text = affected ? "북마크 그룹 데이터를 수정하였습니다." : "북마크 그룹 데이터를 수정하지 못했습니다.";
    %>
    alert("<%= text %>");
    location.href = "bookmark-group.jsp";
</script>
</html>
