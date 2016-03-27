<HTML>
<HEAD>


<TITLE>Your Login Result</TITLE>
</HEAD>

<BODY>
<!--A simple example to demonstrate how to use JSP to 
    connect and query a database. 
    @author  Hong-Yu Zhang, University of Alberta
 -->
<%@ page import="java.sql.*" %>
<% 

        if(request.getParameter("Submit") != null)
        {

	  //get the user input from the login page
          String userName = (request.getParameter("UNAME")).trim();
	  String passwd = (request.getParameter("PASSWD")).trim();
          out.println("<p>Your input User Name is "+userName+"</p>");
          out.println("<p>Your input password is "+passwd+"</p>");

	  
	  session.setAttribute("USERNAME",userName);
	 
	  session.setAttribute("isLogin",false);

	  
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
	  ResultSet rset = null;
          String sql = "select PASSWORD from USERS where USER_NAME = '"+userName+"'";
	  out.println(sql);
          try{
	    stmt = conn.createStatement();
	    rset = stmt.executeQuery(sql);
          }
	  
	  catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    return;
          }

	  String truepwd = "";
	  
          while(rset != null && rset.next())
	  truepwd = (rset.getString(1)).trim();
	  
          //display the result
	  if(passwd.equals(truepwd)){
	    out.println("<p><b>Your Login is Successful!</b></p>");
	    session.setAttribute("isLogin",true);
	    String redirectURL = "main.jsp";
    	    response.sendRedirect(redirectURL);
	  }
          else{
	    out.println("<p><b>Either your userName or Your password is inValid!</b></p>");
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
          out.println("<a href=\"login.html\">Back to login page</a>");
        }      
%>



</BODY>
</HTML>

