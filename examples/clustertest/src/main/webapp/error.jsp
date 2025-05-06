<%@ page isErrorPage="true" import="java.io.*"%>
<%
  if (exception == null)
     exception = new Exception("Exception UNAVAILABLE: Tracing Stack...");
%>
<html>
<head>
  <title>Error</title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
  <meta http-equiv="expires" content="0">
</head>

<font face="Arial,Helvetica,Geneva,Swiss,SunSans-Regular">

  <table bgcolor="white" width="75%" cellpadding="5" cellspacing="5" height="" align="center" background="#CECECE">
    <tr>
      <td>

        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="80%">
        <TR>
          <td BGCOLOR=lightgrey ALIGN=CENTER>
            <h1 ALIGN=CENTER><FONT COLOR=RED>Error</FONT></H1>
            </TD></TR>
          <TR><TD>&nbsp;</TD></TR>
          <TR><TD><B>The following error has occured: <%= exception.getMessage() %></TD></TR>
          <TR>
            <TD>
                  <P>Oops! Your request cannot be completed.  The server got the
                  following error</B>
                  <H2>Stack Trace:</H2>
                  <PRE>

                  <% exception.printStackTrace(new PrintWriter(out)); %>


                  </PRE>

                  <p> Please notify the administrator. Thank you and good luck!</p>
          </TD>
        </TR>
        </TABLE>
      </td>
    </tr>
  </table>

</FONT>

<CENTER>
<%@ include file="/includes/copyright.html"%>
</CENTER>
</body>
</html>
