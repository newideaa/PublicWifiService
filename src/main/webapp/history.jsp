<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servletjsp.HistoryDAO" %>
<%@ page import="com.example.servletjsp.HistoryDTO" %>
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
    <h1>와이파이 정보 구하기</h1>
    <ul class = "horizontal-menu">
        <li><a href="http://localhost:8080">홈</a></li>
        <li><a href="history.jsp">위치 히스토리 목록</a></li>
        <li><a href="load-wifi.jsp">Open API 와이파이 정보 가져오기</a></li>
        <li><a href="bookmark-list.jsp">북마크 보기</a></li>
        <li><a href="bookmark-group.jsp">북마크 그룹 관리</a></li>
    </ul>
    <br>
    <%
        HistoryDAO historyDAO = new HistoryDAO();
        List<HistoryDTO> historyDTOList = historyDAO.selectHistoryList();

        String id = request.getParameter("id");
        if(id != null){
            historyDAO.deleteHistory(id);
        }
    %>
    <table>
        <thead>
            <tr>
                <th>ID</th>
                <th>X 좌표</th>
                <th>Y 좌표</th>
                <th>조회일자</th>
                <th>비고</th>
            </tr>
        </thead>
        <tbody>
        <%
            if(historyDTOList.isEmpty()){
        %>
            <tr>
                <td colspan="5"></td>
            </tr>
        <%
            } else {
                for(HistoryDTO historyDTO : historyDTOList){
        %>
            <tr>
                <td><%=historyDTO.getId()%></td>
                <td><%=historyDTO.getLat()%></td>
                <td><%=historyDTO.getLnt()%></td>
                <td><%=historyDTO.getSearchDttm()%></td>
                <td><button onclick="deleteHistory(<%=historyDTO.getId()%>)">삭제</button></td>
            </tr>
        <%
            }}
        %>
        </tbody>
    </table>
    <script>
        function deleteHistory(id){
            if(confirm('히스토리를 삭제하시겠습니까?')) {
                $.ajax({
                    url:'http://localhost:8080/history.jsp',
                    data:{id : id},
                    success:function (){
                        console.log('히스토리 삭제 완료');
                        window.location.reload();
                    },
                    error:function (request, response, error){
                        console.error(error);
                    }
                });
            }
        }
    </script>
</body>
</html>
