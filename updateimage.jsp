<html>
<head>
<title>Update</title>

</head>
<body>

<% 
if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
{
  out.println("<a href=\"main.jsp\">Home</a>");

  String p_id=request.getParameter("p_id");
  if (p_id.contains(" ")){
    String[] p=p_id.split(" ");
    out.println("<form  name=\"update\" method=\"POST\"  action=\"updateimageMult.jsp?p_id="+p[0]+"+"+p[1]+"\">");
    
  }else{
    out.println("<form  name=\"update\" method=\"POST\"  action=\"updateimageBack.jsp?p_id="+p_id+"\">");
  }
%>

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


