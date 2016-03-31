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

    String s = "delete from group_lists where friend_id = '"+request.getParameter("id")+"' and group_id = "+group_id;
	try{
		out.println(s);
		stmt = conn.createStatement();
	    rset = stmt.executeQuery(s);		
		conn.commit();
		conn.close();
	   	out.println("<p><b>Remove a Friend Successful!</b></p>");
	   	out.println("<a href=\"main.jsp\" >Go to main page</a>");
	}
	catch(Exception ex){
	    out.println("<hr>" + ex.getMessage() + "<hr>");
	   	conn.rollback();//redo the operation
	   	return;
	}
}
else{
	 out.println("<a href=\"login.html\">You need login first!</a>");
}
%>
