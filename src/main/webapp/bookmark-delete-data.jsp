<%@ page import="com.example.servletjsp.BookmarkDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<%
  request.setCharacterEncoding("UTF-8");

  String id = request.getParameter("id");

  BookmarkDAO bookmarkDAO = new BookmarkDAO();
  boolean affected = bookmarkDAO.deleteBookmark(Integer.parseInt(id));
%>
</body>
<script>
  <%
      String text = affected ? "북마크 데이터를 삭제하였습니다." : "북마크 데이터를 삭제하지 못하였습니다.";
  %>
  alert("<%=text%>");
  location.href = "bookmark-list.jsp";
</script>
</html>
