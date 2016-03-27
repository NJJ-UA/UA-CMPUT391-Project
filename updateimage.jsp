<html>
<head>
<title>Update</title>

</head>
<body>

<% 
if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
{
  out.println("<a href=\"main.jsp\">Home</a>");
  String pic_id;
  if(request.getParameter("") == null){
    
    out.println("<H1>Upload Successfully!</H1>");
    out.println("<H3>You can add some other infomations or press HOME to get back to home page.</H1>");
    pic_id=session.getAttribute("PICID").toString();
    
  }
%>

  <form  name="update" method="POST"  action="updateimageBack.jsp">
    <table>
      <tbody><tr valign="TOP" align="LEFT">
	<td><b><i>PERMITTED:</i></b></td>
	<td><input name="PERMITTED" type="text"><br></td>
      </tr>
      <tr valign="TOP" align="LEFT">
	<td><b><i>SUBJECT:</i></b></td>
	<td><input name="SUBJECT" type="text"></td>
      </tr>
      <tr valign="TOP" align="LEFT">
	<td><b><i>PLACE:</i></b></td>
	<td><input name="PLACE" type="text"></td>
      </tr>
      <tr valign="TOP" align="LEFT">
	<td><b><i>TIMING:</i></b></td>
	<td><input name="TIMING" type="text"></td>
      </tr>
      <tr valign="TOP" align="LEFT">
	<td><b><i>DESCRIPTION:</i></b></td>
	<td><input name="DESCRIPTION" type="text"></td>
      </tr>
      </tbody></table>
   
    <input name="Submit" value="Submit" type="submit"></td>
      
  </form>



<%
}
else
{
  out.println("<a href=\"login.html\">You need login first!</a>");
}      
%>



</BODY>
</HTML> 


