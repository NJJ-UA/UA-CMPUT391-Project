<html>
  <head>
    <title>Change password</title>

  </head>
  <body>
    <%@ page import="java.sql.*" %>
    <% 
    if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
    {
      out.println("<a href=\"main.jsp\">Home</a>");
      
    %>
    <form>
      New password:<br>
      <input type = "text" name = "password"><br>
      <input type = "submit" value="Change" name = "Change"><br>
    </form>


    <%

    if(request.getParameter("Change")!=null){
      String password=(request.getParameter("password")).trim();
      if(password.equals("")){
	out.println("<h3>Password cant be empty</h3>");
	return;
      }


      //establish the connection to the underlying database
      Connection conn = null;
      Statement stmt = null;

      String driverName = "oracle.jdbc.driver.OracleDriver";
      String dbstring = "jdbc:oracle:thin:@gwynne.cs.ualberta.ca:1521:CRS";
      
      
      String sql = "update users set password ='"+password+"' where user_name = '"+ session.getAttribute("USERNAME").toString()+"'";
     
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



  </BODY>
</HTML>
