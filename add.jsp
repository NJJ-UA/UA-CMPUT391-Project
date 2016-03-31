<%@ page import="java.sql.*" %>
<%
if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
{
	Connection conn = null;
  	Statement stmt = null;
	ResultSet rset;	

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
	    stmt = conn.createStatement();
	}
	catch(Exception ex){
	    
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    return;
	}
	//response.getWriter().write(id);
	String group_id = request.getParameter("gid");
	//response.getWriter().write(id);
  
	String cmd = "INSERT INTO group_lists VALUES ('"+ group_id +"','"+ request.getParameter("user") +"',sysdate,null)";
	try{
	    stmt = conn.createStatement();
	    stmt.executeUpdate(cmd);
	    conn.commit();
	    out.println("<p><b>Add Friend to Group Successful!</b></p>");
	    out.println("<a href=\"main.jsp\" >Go to main page</a>");
	    conn.close();

    }  
	catch(Exception ex){
	    out.println("<p3>You may add some user not in database</p3>");
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	    conn.rollback();//redo the operation
	    return;
    }
}
else{
	 out.println("<a href=\"login.html\">You need login first!</a>");
}
%>
