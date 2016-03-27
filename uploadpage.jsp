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


  
  <form  name="upload-image" method="POST" enctype="multipart/form-data" action="UploadImage">
    
    Please input or select the path of the image!	
    <table>
      <tbody><tr>
	<th>File path: </th>
	<td><input name="file-path" size="30" type="file"></td>
      </tr>
      <tr>
	<td colspan="2" align="CENTER"><input name="Submit" value="Upload" type="submit"></td>
      </tr>
      </tbody></table>
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
