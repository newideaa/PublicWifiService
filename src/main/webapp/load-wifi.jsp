<%--
  Created by IntelliJ IDEA.
  User: dbtnr
  Date: 2023-12-11
  Time: 오전 5:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.example.servletjsp.ApiExplorer" %>
<html>
<head>
    <title>와이파이 정보 구하기</title>
    <style>
        div {
            text-align: center;
        }
        h1{
            margin : 20px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <%
        ApiExplorer apiExplorer = new ApiExplorer();
        int count = apiExplorer.getWifiInfo();
    %>

    <div>
        <% if (count > 0) { %>
            <div>
                <h1><%=count%>건의 데이터를 성공적으로 저장했습니다.</h1>
                <a href="http://localhost:8080">홈으로 돌아가기</a>
            </div>
        <% } else { %>
            <h1>데이터 저장 실패</h1>
        <% } %>
    </div>
</body>
</html>
