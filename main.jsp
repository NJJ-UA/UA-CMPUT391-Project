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

<%

//establish the connection to the underlying database
    Connection conn = null;
    
    String driverName = "oracle.jdbc.driver.OracleDriver";
    String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
    
    try{
      //load and register the driver
      Class drvClass = Class.forName(driverName); 
      DriverManager.registerDriver((Driver) drvClass.newInstance());
    }
    catch(Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
      return;
    }
    
    try{
      //establish the connection 
      conn = DriverManager.getConnection(dbstring,"jni1","c3912016");
    }
    catch(Exception ex){
      
      out.println("<hr>" + ex.getMessage() + "<hr>");
      return;
    }
    

    //select the user table from the underlying db and validate the user name and password
    Statement stmt = null;
    ResultSet rset = null;
    String sql = "select * from persons where user_name = '"+userName+"'";

    try{
      stmt = conn.createStatement();
      rset = stmt.executeQuery(sql);
    }catch(Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
      return;
    }

    rset.next();
    String first=rset.getString(2);
    String last=rset.getString(3);
    String addr=rset.getString(4);
    String email=rset.getString(5);
    String phone=rset.getString(6);

%>

<table>
<tbody>
<tr valign="TOP" align="LEFT">
<td><b><i>First Name:</i></b></td>
<td><%=first%><br></td>
</tr>
<tr valign="TOP" align="LEFT">
<td><b><i>Last Name:</i></b></td>
<td><%=last%><br></td>
</tr>
<tr valign="TOP" align="LEFT">
<td><b><i>Address:</i></b></td>
<td><%=addr%><br></td>
</tr>
<tr valign="TOP" align="LEFT">
<td><b><i>E-mail:</i></b></td>
<td><%=email%><br></td>
</tr>
<tr valign="TOP" align="LEFT">
<td><b><i>Phone Number:</i></b></td>
<td><%=phone%><br></td>
</tr>
</tbody></table>
<br>
<a href="password.jsp">Change Password</a>
<br>
<a href="updateuser.jsp">Update Profile</a>
<br>
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
<a href="adminManage.jsp">Data analyse!</a>
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
