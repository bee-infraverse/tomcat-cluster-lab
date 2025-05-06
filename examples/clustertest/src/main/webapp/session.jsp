<%@ page import="java.util.Date,
                 java.text.DateFormat,
                 java.util.Locale"%>
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
  String jvmRoute = System.getProperty("jvmRoute", "no route");
   
  String hello = (String)	session.getAttribute("Hello") ;
  String clusterSession = "no cluster node" ;
  String isClusterChangedColor = "#80FFFF" ;
  int index = -1 ;

  if(hello != null) {
    index = hello.lastIndexOf("/") ;
    if(index > -1)
      clusterSession = hello.substring(index+1) ;
    if(!clusterSession.equals(jvmRoute))
    isClusterChangedColor = "#FF0000" ;
  }
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
<FONT SIZE="5" COLOR="#406E6E"><B><I>Cluster Test session show</I></B></FONT>
<BR>
  <H1>Information</H1>
<BR>
 
<table width="800" border="1">
  <tr><th>Attribute</th><th width="600" >Value</th></tr>
  <tr>
	<td bgColor="#C9C9C9">SessionID</td><td><%=session.getId()%></td>
	</tr>
  <tr>
  <tr>
	<td bgColor="#C9C9C9">Session Creatation Date</td><td><%= DateFormat.getDateTimeInstance(DateFormat.FULL, DateFormat.FULL,
                                                             Locale.US).format(new Date(session.getCreationTime()))%></td>
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
	<td bgColor="#C9C9C9">is Primay Session Node</td><td><%=request.getAttribute("org.apache.catalina.ha.tcp.isPrimarySession")%></td>
  </tr>
	<tr>
	<td bgColor="#C9C9C9">Orginal Session ID at current request</td><td><%=request.getAttribute("org.apache.catalina.ha.session.JvmRouteOrignalSessionID")%></td>
  </tr>
	<tr>
	<td bgColor="#C9C9C9">Session Attribut <I>"Hello"</I></td><td><%=session.getAttribute("Hello")%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">Session Cluster Node</td><td bgColor="<%=isClusterChangedColor%>"><%=clusterSession%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">Current Server:</td><td><%=java.net.InetAddress.getLocalHost().getHostAddress()%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">Application RealPath:</td><td><%=application.getRealPath("/session.jsp")%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">Cluster Node</td><td bgColor="#80FFFF"><%=jvmRoute%></td>
  </tr>
  <tr>
	<td bgColor="#C9C9C9">JVM Route</td><td bgColor="#80FFFF"><%=session_jvmRoute%></td>
  </tr>

  </table>
<BR>
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