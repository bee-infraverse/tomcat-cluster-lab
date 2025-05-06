<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<%
   application.setAttribute("ClusterTest",application.getInitParameter("version")) ;
%>

<HTML>
<HEAD>
	<TITLE>Cluster Test index page</TITLE>
<meta http-equiv="Content-Type" content="text/html;CHARSET=iso-8859-1">
<meta name="description" content="Peter Clustertest">
<meta name="keywords" content="Cluster">
<% 	
   response.setDateHeader("Expires",0);
   response.setHeader("Pragma","no-cache");
   response.setHeader("Cache-Control","no-cache,must-revalidate");
%>
</HEAD>

<BODY BGCOLOR="#FFFFFF" LINK="#406E6E" ALINK="#406E6E" VLINK="#406E6E">
<CENTER>
<FONT FACE="Arial,Helvtica" SIZE="2">
 
  <H1>Start Cluster Test</H1>
  <table>
  <tr><td>put a value at your session</td></tr>
  <tr><td><a href="setsession.jsp" >set session attribute hello</a></td></tr>
  <tr><td>look at your session information</td></tr>
  <tr><td><a href="session.jsp?Session=<%=session.getId()%>" >next request</a></td></tr>
  <tr><td>switch off the primary cluster node</td></tr>
  <tr><td>look at your replicated session information</td></tr>
  <tr><td><a href="session.jsp?Session=<%=session.getId()%>" >next request</a></td></tr>
  <tr><td>delete session start cluster node again and play with it!</td></tr>
  <tr><td><a href="clearsession.jsp" >clear session attribute hello</a></td></tr>
  <tr><td>Set new Session Attributes</td></tr>
  <tr><td><a href="newAttribute.jsp" >new</a></td></tr>
  <tr><td>look other usefull information</td></tr>
  <tr><td><a href="snoopy.jsp" >snoop</a></td></tr>
  </table>

<%@ include file="/includes/copyright.html"%>
</CENTER>
</body>
</html>
