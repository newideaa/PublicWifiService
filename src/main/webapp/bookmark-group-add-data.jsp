<%@ page import="com.example.servletjsp.BookmarkGroupDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");

  String bookmarkName = request.getParameter("bookmarkName");
  String orderNo = request.getParameter("orderNo");

  BookmarkGroupDAO bookMarkGroupDAO = new BookmarkGroupDAO();
  boolean affected = bookMarkGroupDAO.insertBookmarkGroup(bookmarkName, orderNo);
%>
</body>
<script>
  <%
  String text = "";
  if(affected){
    text = "북마크 그룹 데이터를 추가";
  }else{
    text = "북마크 그룹 데이터 추가 실패";
  }
  %>
  alert("<%= text %>");
  location.href = "bookmark-group.jsp";
</script>
</html>
