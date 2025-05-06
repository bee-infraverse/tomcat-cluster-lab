<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
	<TITLE>Cluster Test session show</TITLE>
<meta http-equiv="Content-Type" content="text/html;CHARSET=iso-8859-1">
<meta name="description" content="Tomcat Server Clustertest">
<meta name="keywords" content="Tomcat Server">
<% 	
   response.setDateHeader("Expires",0);
   response.setHeader("Pragma","no-cache");
   response.setHeader("Cache-Control","no-cache,must-revalidate");
%>
</HEAD>

<BODY BGCOLOR="#FFFFFF" LINK="#406E6E" ALINK="#406E6E" VLINK="#406E6E">
<CENTER>
<FONT FACE="Arial,Helvtica" SIZE="2">
<FONT SIZE="5" COLOR="#406E6E"><B><I>Cluster Test session show</I></B></FONT>
<BR>
<BR>

<H1>Delete replicated session information</H1>
<BR>
<table width="600"  border=1>
  <tr>
	<td bgColor="#C9C9C9">SessionID</td><td><%=session.getId()%></td>
	</tr>
  <tr>
	<td bgColor="#C9C9C9">req SessionID</td><td><%=request.getParameter("Session")%></td>
	</tr>
	<tr>
	<td bgColor="#C9C9C9">ServerName</td><td><%=request.getServerName() %></td>
	</tr>
	<tr>
	<td bgColor="#C9C9C9">ServerPort</td><td><%=request.getServerPort() %></td>
  </tr>
	<tr>
	<td bgColor="#C9C9C9">Session Attribut <I>"Hello"</I></td><td><%=session.getAttribute("Hello")%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">Current Server:</td><td><%=java.net.InetAddress.getLocalHost().getHostAddress()%></td>
  </tr>

  </table>


<FONT COLOR="red"><B>Session is now invalidated!!</B></FONT>
<% 	
   session.invalidate();
   session = null;
%> 
<BR>
<H1>Links</H1>
<a href="index.jsp" >back</a></td></tr><br>
<%@ include file="/includes/copyright.html"%>
</CENTER>
</BODY>
</HTML>