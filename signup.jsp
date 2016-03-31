<HTML>
<HEAD>


<TITLE>Your Sign up Result</TITLE>


</HEAD>

<BODY>

<%@ page import="java.sql.*" %>
<% 

	
if(request.getParameter("Submit") != null)
        {

          String userName = (request.getParameter("UNAME")).trim();
	  String password = (request.getParameter("PASSWD")).trim();
	  String firstName = (request.getParameter("FNAME")).trim();
	  String lastName = (request.getParameter("LNAME")).trim();
	  String address = (request.getParameter("ADDR")).trim();
	  String email = (request.getParameter("EMAIL")).trim();
	  String phone = (request.getParameter("PHONE")).trim();

	  
	  if(userName==""||password==""){
		out.println("<a href=\"signup.html\">Username and password can't be empty!</a>");
		return;
	}

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
            conn.setAutoCommit(false);
	  }
          catch(Exception ex){
	    
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    return;
          }
	  

	  //select the user table from the underlying db and validate the user name and password
          Statement stmt = null;
	  

	  String sql = "insert into USERS values('"+userName+"','"+password+"',SYSDATE)";

          try{
	    stmt = conn.createStatement();
	    stmt.executeUpdate(sql);
          }
	  
	  catch(Exception ex){

	    out.println("<p><b>User Name may be dumplicate!</b></p>");
	    out.println("<a href=\"signup.html\" >Back to sign up</a>");
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    conn.rollback();
	    return;
          }


	  sql = "insert into PERSONS values('"+userName+"','"+firstName+"','"+lastName+"','"+address+"','"+email+"','"+phone+"')";

          try{
	    stmt = conn.createStatement();
	    stmt.executeUpdate(sql);
	    conn.commit();
	    out.println("<p><b>Your Sign up is Successful!</b></p>");
	    out.println("<a href=\"login.html\" >Go to login</a>");
          }
	  
	  catch(Exception ex){
	    
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    conn.rollback();
	    return;
          }
	  
	  try{
	    conn.close();
	  }
	  catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    return;
	  }
        }
        else
        {
        	
          out.println("<a href=\"signup.html\" >Back to sign up</a>");

        }	
	
%>



</BODY>
</HTML>

