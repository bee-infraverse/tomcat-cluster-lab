<%@ page session="true" import="java.util.Enumeration"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<%
String operation = request.getParameter("operation") ;
String key = request.getParameter("Key") ;
String message = request.getParameter("Message") ;
if("New".equals(operation)) {
   session.setAttribute(key,message) ;
} else { if("Delete".equals(operation) ){
   session.removeAttribute(key) ;
  }
}
%>
<html>
<head>
	<title>Session Operation</title>
</head>

<BODY BGCOLOR="#FFFFFF" LINK="#406E6E" ALINK="#406E6E" VLINK="#406E6E">
<CENTER>
<FONT FACE="Arial,Helvtica" SIZE="2">
<FONT SIZE="5" COLOR="#406E6E"><B><I>Cluster Test operation</I></B></FONT>
<BR>        
<H1>Session Request</H1><BR>
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Operation</td>
    <td><%=operation%></td>
</tr>
<tr>
    <td>Key</td>
    <td><%=key%></td>
</tr>
<tr>
    <td>Message</td>
    <td><%=message%></td>
</tr>
</table>

        <H1>Session Attributes</H1><BR>
        <%
        StringBuffer _buf = new StringBuffer("SessionID : " + session.getId() + "<BR/><table border='1'>" );
        Enumeration en = session.getAttributeNames();

		
        while ( en.hasMoreElements() ) {
              String key1 = (String) en.nextElement();
              if ( key1 != null ) {
        		      _buf.append("<tr>");			
		              Object value = session.getAttribute( key1 );
                      if ( value == null) value = "null" ;
                      _buf.append( "<TD>" + key1 + "</TD><TD>" + value + "</TD>" );
					  _buf.append("</tr>");			
              }
            }
        _buf.append("</table>");			
        out.println( _buf.toString() );
        _buf.delete( 0, _buf.length() );
%>

<H1>Links</H1>
  <table>
  <tr><td><a href="newAttribute.jsp" >next attribute</a></td></tr>
  <tr><td><a href="snoopy.jsp" >snoop</a></td></tr>  
  <tr><td><a href="clearsession.jsp" >clear session attributes</a></td></tr>
  <tr><td><a href="index.jsp" >back</a></td></tr>
  </table>
<%@ include file="/includes/copyright.html"%>
</CENTER>
</body>

</html>
