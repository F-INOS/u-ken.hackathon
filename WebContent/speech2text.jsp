<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=device-width,initial-scale=1,maximum-scale=1,minimum-scale=1,user-scalable=no"/>

    <link rel="stylesheet" href="style.css" />
    <title>結果</title>
  </head>

  <body>
    <h1>結果</h1>


<%
ArrayList<String> resultOutput = (ArrayList<String>)request.getAttribute("resultOutput");
for (int i = 0; i < resultOutput.size(); i++) {
    String strRes = resultOutput.get(i);
    out.println(strRes + "<br>") ;
  }
%>


  </body>
</html>