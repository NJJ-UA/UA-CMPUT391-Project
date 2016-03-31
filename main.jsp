<HTML>
<HEAD>


<TITLE>Main Page</TITLE>

</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<% 
if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
{

  

  String userName=session.getAttribute("USERNAME").toString();
 
%>
  <p><b>Hello,<%=userName%>!</b></p>
 <form method="post" action="logout.jsp">
    <input type="submit" value="Log Out" name="LogOut">
  </form>
<br>
<form method="post" action="PictureBrowse">
<input type="submit" value="See TOP 5 Pictures!" name="toppic">
</form>
<br>
<a href="addGroups.jsp">Add Groups!</a>
<br>
<a href="updateGroup.jsp">Manage your groups!</a>
<br>
<a href="uploadpage.jsp">Upload Pictures!</a>
<br>
 <br>


  <form method="post" action="PictureBrowse">
  Query the database to see relevant items
  <table>
    <tr>
      <td> Key words:</td>
    </tr>
    <tr>
      <td>
        <input type="text" name="query"  >
      </td>
    </tr>
    <tr>
      <td> From:</td>
    </tr>
    <tr>
	<td><input name="FROM" type="text"></td>
    </tr>
    <tr>
      <td>To:</td>
    </tr>
    <tr>

	<td><input name="TO" type="text"></td>
      </tr>

      <tr>
	<td>Rank By:</td>
      </tr>
      <tr><td> 
	<select id="rank" name="rank">
	  
	  <option value ="first">most-recent-first</option>
	  <option value="last">most-recent-last</option>
	  <option value ="rele">Relevant</option>

	</select>

      </td></tr>
      <tr>
      <td>
	
        <input type="submit" value="Search" name="search">
      </td>
    </tr>
  </table>
  

<%
}
else
{
  out.println("<a href=\"login.html\">You need login first!</a>");
}      
%>



</BODY>
</HTML>
