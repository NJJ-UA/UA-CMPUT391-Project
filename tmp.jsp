<html>
<head>
<title>Upload</title>

</head>
<body>

<% 
if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
{
  out.println("<a href=\"main.jsp\">Home</a>");
 
%>



<%
}
else
{
  out.println("<a href=\"login.html\">You need login first!</a>");
}      
%>



</BODY>
</HTML>
