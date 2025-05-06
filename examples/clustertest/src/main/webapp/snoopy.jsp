<%@ page
  language="java"
  import="java.io.*,java.net.*,java.util.*,javax.servlet.*,javax.servlet.http.*"
  isErrorPage="false" errorPage="/error.jsp"
%>
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
<BR>
<BR>
<FONT SIZE="5" COLOR="#406E6E"><B><I>Cluster Test session show</I></B></FONT>
<BR>
</CENTER>

<H1 align="center">Status</H1>

  <table width="800"  bgcolor="white" width="75%" cellpadding="5" cellspacing="5" height="" align="center" background="#CECECE">
    <tr>
      <td>

        <h1> Request Information </h1>
        <font size="4">
        JSP Request Method: <%= request.getMethod() %>
        <br>
        Request URI: <%= request.getRequestURI() %>
        <br>
        Request Protocol: <%= request.getProtocol() %>
        <br>
        Servlet path: <%= request.getServletPath() %>
        <br>
        <% String path = request.getServletPath(); %>
        Request Scheme: <%= request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path.substring(0,path.lastIndexOf('/') )+"/" %>
        <br>
        Path info: <%= request.getPathInfo() %>
        <br>
        Path translated: <%= request.getPathTranslated() %>
        <br>
        Query string: <%= request.getQueryString() %>
        <br>
        Content length: <%= request.getContentLength() %>
        <br>
        Content type: <%= request.getContentType() %>
        <br>
        Server name: <%= request.getServerName() %>
        <br>
        Server IP: <%
        java.net.InetAddress inetaddr = java.net.InetAddress.getByName( request.getServerName() );
        String ipstr = inetaddr.getHostAddress();
        out.println( ipstr );
        %>
        <br>
        Server port: <%= request.getServerPort() %>
        <br>
        Remote user: <%= request.getRemoteUser() %>
        <br>
        Remote address: <%= request.getRemoteAddr() %>
        <br>
        Remote host: <%= request.getRemoteHost() %>
        <br>
        Authorization scheme: <%= request.getAuthType() %>
        <br>
        Authenticated user: <%= request.getUserPrincipal() %>
        <br>
        <br><B>Request Header:</B><BR>
        <%
        Enumeration e = request.getHeaderNames();
        while (e.hasMoreElements() ) {
          String key = (String)e.nextElement();
          out.println( key + "= " +request.getHeader( key ) + "<BR>" );
        }

        out.println( "<BR><B>Request Parameter:</B><BR>");
        e = request.getParameterNames();
        while (e.hasMoreElements() ) {
          String key = (String)e.nextElement();
          out.println( key + "=" + request.getParameter( key ) + "<BR>");
        }

        out.println( "<BR><B>Request Attributes:</B><BR>");
        e = request.getAttributeNames();
        while (e.hasMoreElements() ) {
          String key = (String)e.nextElement();
          out.println( key + "=" + request.getAttribute( key ) + "<BR>");
        }
        
        Object version = request.getAttribute("apache.version") ;
        if(version != null)
           out.println("apache.version=" + version) ;
        %>

        <br>
        <B>Session Attributes:</B><BR>
        <%
        StringBuffer _buf = new StringBuffer("SessionID : " + session.getId() + "<BR>" );
        Enumeration en = session.getAttributeNames();
        while ( en.hasMoreElements() ) {
              String key = (String) en.nextElement();
              if ( key != null ) {
                      Object value = session.getAttribute( key );
                      if ( value == null) value = new String( "null" );
                      _buf.append( key + " 	  : " + value + "<BR>" );
              }
            }
        out.println( _buf.toString() );

        %>
        <hr>
        The browser you are using is <%= request.getHeader("User-Agent") %>
        <hr>
        </FONT>

      </td>
    </tr>
  </table>

<CENTER>
<H1>Links</H1>
<a href="index.jsp" >back</a></td></tr><br>
<%@ include file="/includes/copyright.html"%>
</CENTER>
</FONT>

</BODY>
</HTML>
