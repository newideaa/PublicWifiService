<%@ page import="com.example.servletjsp.BookmarkDTO" %>
<%@ page import="com.example.servletjsp.BookmarkDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
</head>
<body>
<h1>북마크 그룹 추가</h1>
<%
    request.setCharacterEncoding("UTF-8");

    String mgrNo = request.getParameter("mgrNo");
    String bGroupName = request.getParameter("bGroupName");

    if(bGroupName.equals("#")){
        response.sendRedirect(request.getHeader("Referer"));
        return;
    }

    BookmarkDTO bookmarkDTO = new BookmarkDTO();
    bookmarkDTO.setMgrNo(mgrNo);
    bookmarkDTO.setGroupId(Integer.parseInt(bGroupName));

    BookmarkDAO bookmarkDAO = new BookmarkDAO();
    boolean affected = bookmarkDAO.insertBookmark(bookmarkDTO);
%>
</body>
<script>
    <%
        String text = affected ? "북마크 데이터 추가하였습니다." : "북마크 데이터 추가 실패하였습니다.";
    %>
    alert("<%= text %>");
    location.href = "bookmark-list.jsp";
</script>
</html>
