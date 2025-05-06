<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Hello Session</title>
</head>
<body>
<h1>Display the session value on this page</h1>
<%
String name=(String)session.getAttribute("user");
if (name != null) {
  out.println("Hello user "+name);
} else {
  out.println("Hello World");
}
String rname = request.getParameter("name");
if (rname != null) {
  session.setAttribute("user", rname);
}
%>
</body>
</html>