<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
	<TITLE>Cluster Test set new session replication attribute or delete one</TITLE>
</head>

<BODY BGCOLOR="#FFFFFF" LINK="#406E6E" ALINK="#406E6E" VLINK="#406E6E">
<CENTER>
<FONT FACE="Arial,Helvtica" SIZE="2">
<FONT SIZE="5" COLOR="#406E6E"><B><I>Input your Session Key</I></B></FONT>
<H1>Operation</H1>
<form action="sessionOperation.jsp" name="SetSession" >
<table cellspacing="2" cellpadding="2" border="0">
<tr>
    <td>Key</td>
    <td><input type="text" name="Key" maxlength="30"></td>
</tr>
<tr>
    <td>Message</td>
    <td><textarea cols="50" rows="10" name="Message" ></textarea></td>
</tr>
<tr><td></td>
<td><table>
<tr>
    <td><input type="submit" name="operation" value="New"></td>
    <td><input type="submit" name="operation" value="Delete"></td>
	<td><input type="reset" name="Reset"></td>
</tr>
</table>
</td>
</tr></table>

</form>

<H1>Links</H1>
  <table>
  <tr><td><a href="clearsession.jsp" >clear session attributes</a></td></tr>
  <tr><td><a href="index.jsp" >back</a></td></tr>
  </table>
<%@ include file="/includes/copyright.html"%>
</CENTER>
</body>
</html>
