<html>
  <head>
    <title>Update profile</title>
    <script language = "JavaScript" type = "text/javascript">
     function checkPhone(form) {
       if (form.PHONE.value.trim()==""){
	 return true;
       }
       if ((form.PHONE.value.trim().length) > 10){
	 alert("The phone number should not be more than 10 digits!");
	 form.PHONE.focus();
	 return false;
       }else{
	 return true;
       }
     }

    </script>
  </head>
  <body>
    <%@ page import="java.sql.*" %>
    <% 
    if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
    {
      out.println("<a href=\"main.jsp\">Home</a>");
      
    %>
    <form onSubmit = "return checkPhone(this);">
      <table>
	<tr valign="TOP" align="LEFT">
	  <td><b><i>First Name:</i></b></td>
	  <td><input name="FNAME" type="text"></td>
	</tr>
	<tr valign="TOP" align="LEFT">
	  <td><b><i>Last Name:</i></b></td>
	  <td><input name="LNAME" type="text"></td>
	</tr>
	<tr valign="TOP" align="LEFT">
	  <td><b><i>Address:</i></b></td>
	  <td><input name="ADDR" type="text"></td>
	</tr>
	<tr valign="TOP" align="LEFT">
	  <td><b><i>E-mail:</i></b></td>
	  <td><input name="EMAIL" type="text"></td>
	</tr>
	<tr valign="TOP" align="LEFT">
	  <td><b><i>Phone Number:</i></b></td>
	  <td><input name="PHONE" type="text"></td>
	</tr>
	</tbody></table>
      <input type = "submit" value="Change" name = "Change"><br>
    </form>


    <%

    if(request.getParameter("Change")!=null){
      String firstName = (request.getParameter("FNAME")).trim();
      String lastName = (request.getParameter("LNAME")).trim();
      String address = (request.getParameter("ADDR")).trim();
      String email = (request.getParameter("EMAIL")).trim();
      String phone = (request.getParameter("PHONE")).trim();


      //establish the connection to the underlying database
      Connection conn = null;
      Statement stmt = null;

      String driverName = "oracle.jdbc.driver.OracleDriver";
      String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
      
      
      String update = "update persons set ";
      String where = "where user_name = '"+ session.getAttribute("USERNAME").toString()+"'";

      boolean empty=true;


      if(!address.equals("")){
	empty = false;
	update=update+" ADDRESS ='"+ address +"',";
      }

      if(!email.equals("")){
	empty = false;
	update=update+" EMAIL ='"+ email +"',";
      }

      
      if(!firstName.equals("")){
	empty = false;
	update=update+" FIRST_NAME ='"+ firstName +"',";
      }

      if(!lastName.equals("")){
	empty = false;
	update=update+" LAST_NAME ='"+ lastName +"',";
      }
      
      if (!phone.equals("")){
	empty = false;

	update=update+" phone ='"+ phone +"',";

      }
 
      if(empty){
	out.println("<h1>All empty,no need to update</h>");
	return;
      }
      update=update.substring(0, update.length()-1);
      String sql = update + where;



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
	conn.setAutoCommit(false);
	stmt = conn.createStatement();
      }
      catch(Exception ex){
	
	out.println("<hr>" + ex.getMessage() + "<hr>");
	return;
      }
      

      try{

	stmt.executeUpdate(sql);

	conn.commit();
	out.println("<h1>Change successul.</h>");
	try{
	  conn.close();
	}
	catch(Exception ex){
	  out.println("<hr>" + ex.getMessage() + "<hr>");
	  
	}
	
      }catch (SQLException e) {
	conn.rollback();
	out.println(e.getMessage());
	return;
      }
    }


    }
    else
    {
      out.println("<a href=\"login.html\">You need login first!</a>");
    }      
    %>


<br>
<a target="_blank" href="userDocumentation.html">Help</a>
  </BODY>
</HTML>
