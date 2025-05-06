<%@ page import="java.text.DateFormat,
                 java.util.Locale,
                 java.util.Date"%>
<%@page session="true" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
	<TITLE>Cluster Test set session replication attribute </TITLE>
<meta http-equiv="Content-Type" content="text/html;charset=iso-8859-1">
<meta name="description" content="Tomcat  Server Clustertest">
<meta name="keywords" content="Tomcat Server">
<% 	
   response.setDateHeader("Expires",0);
   response.setHeader("Pragma","no-cache");
   response.setHeader("Cache-Control","no-cache,must-revalidate");
   String jvmRoute = System.getProperty("jvmRoute", "no route");
   int index = -1 ;

   java.net.InetAddress localhost = java.net.InetAddress.getLocalHost();
   String serverAddr = localhost.getHostAddress();

   boolean isFirst = (null == session.getAttribute("Hello")) ;
   if(isFirst)
      session.setAttribute("Hello", 
        "say Hello World created on: " + 
        serverAddr+"/"+
        jvmRoute );
   String sessionID = request.getRequestedSessionId() ;
   index =  sessionID.lastIndexOf(".") ;
   String session_jvmRoute = "no route" ;
    if ( index > -1)
        session_jvmRoute =  sessionID.substring(index+1);
%>
</HEAD>

<BODY BGCOLOR="#FFFFFF" LINK="#406E6E" ALINK="#406E6E" VLINK="#406E6E">
<CENTER>
<FONT FACE="Arial,Helvtica" SIZE="2">
<FONT SIZE="5" COLOR="#406E6E"><B><I>Cluster Test set session test value</I></B></FONT>
<BR>

  <H1>set or show hello session attribute</H1>
  <table width="800" border=1>
  <tr><th>Attribute</th><th width="600" >Value</th></tr>
  <tr>
	<td bgColor="#C9C9C9">SessionID</td><td><%=session.getId()%></td>
	</tr>
 <tr>
	<td bgColor="#C9C9C9">Session Creatation Date</td><td><%= DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL,
            Locale.US).format(new Date(session.getCreationTime()))%></td>
	</tr>
	<tr>
	<td bgColor="#C9C9C9">Session Attribut <I>"Hello"</I></td><td><%=session.getAttribute("Hello")%></td>
  </tr>
	<td bgColor="#C9C9C9">First creation</td><td><%=isFirst%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">Cluster Node</td><td bgColor="#80FFFF"><%=jvmRoute.toLowerCase()%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">JVM Route</td><td bgColor="#80FFFF"><%=session_jvmRoute.toLowerCase()%></td>
  </tr>
  </table>
  <H1>Links</H1>
  <table border="1" >
  <tr>
    <td><a href="session.jsp?Session=<%=session.getId()%>" >next request</a></td>
    <td><a href="setsession.jsp" >set session attribute hello</a></td>
    <td><a href="clearsession.jsp" >clear session attribute hello</a></td>
    <td><a href="index.jsp" >back</a></td>
   </tr>
   </table>

<%@ include file="/includes/copyright.html"%>
</CENTER>
</BODY>
</HTML>