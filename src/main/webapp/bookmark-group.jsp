<%--
  Created by IntelliJ IDEA.
  User: dbtnr
  Date: 2023-12-13
  Time: 오전 5:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servletjsp.BookmarkGroupDAO" %>
<%@ page import="com.example.servletjsp.BookmarkGroupDTO" %>
<%@ page import="java.util.List" %>

<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
<br>
<%
    BookmarkGroupDAO bookmarkGroupDAO = new BookmarkGroupDAO();
    List<BookmarkGroupDTO> bookmarkGroupDTOList = bookmarkGroupDAO.selectBookmarkGroupList();

    String id = request.getParameter("id");
    if(id != null){
        bookmarkGroupDAO.deleteBookmarkGroup(id);
    }
%>
<button onclick="goToAddPage()">북마크 그룹 이름 추가</button>
<br>
<table>
    <thead>
        <tr>
            <th>ID</th>
            <th>북마크 이름</th>
            <th>순서</th>
            <th>등록일자</th>
            <th>수정일자</th>
            <th>비고</th>
        </tr>
    </thead>
    <tbody>
    <%
        if(bookmarkGroupDTOList.isEmpty()){
    %>
        <tr>
            <td colspan="6"></td>
        </tr>
        <%
            } else {
                for(BookmarkGroupDTO bookmarkGroupDTO : bookmarkGroupDTOList){
                    String updatedDttm = bookmarkGroupDTO.getUpdatedDttm() == null ? "" : bookmarkGroupDTO.getUpdatedDttm();
        %>
        <tr>
            <td><%=bookmarkGroupDTO.getId()%></td>
            <td><%=bookmarkGroupDTO.getBookmarkName()%></td>
            <td><%=bookmarkGroupDTO.getOrderNo()%></td>
            <td><%=bookmarkGroupDTO.getRegisteredDttm()%></td>
            <td><%=updatedDttm%></td>
            <td><a href="bookmark-group-edit.jsp?id=<%=bookmarkGroupDTO.getId()%>">수정</a> <a href="#" onclick="deleteBookmarkGroup(<%=bookmarkGroupDTO.getId()%>)">삭제</a></td>
        </tr>
        <%
                }}
        %>
    </tbody>
</table>
<script>
    function goToAddPage(){
        window.location.href = "bookmark-group-add.jsp";
    }

    function deleteBookmarkGroup(id){
        if(confirm('북마크 그룹을 삭제하시겠습니까?')){
            $.ajax({
                url:'http://localhost:8080/bookmark-group.jsp',
                data:{id : id},
                success:function (){
                    console.log("북마크 그룹 삭제 완료");
                    window.location.reload();
                },
                error:function (request,response,error){
                    console.log(error);
                }
            });
        }
    }
</script>
</body>
</html>
