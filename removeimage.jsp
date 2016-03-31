<html>
  <head>
    <title>Upload</title>

  </head>
  <body>

    <%@ page import="java.sql.*" %>

    <% 
    if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
    {
      out.println("<a href=\"main.jsp\">Home</a>");
      

      String pic_id=request.getParameter("p_id");

      //establish the connection to the underlying database
      Connection conn = null;
      Statement stmt = null;

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
      

      try{


	String cmd = "SELECT  owner_name  FROM IMAGES WHERE photo_id = "+pic_id;
	ResultSet rset = stmt.executeQuery(cmd);
	rset.next();

	String belong=rset.getString(1);
	if(!(session.getAttribute("USERNAME").toString().equals(belong))){
	  out.println("<h3>Can't modify images not belong to you!</h3>");
	  out.println("<a href=\"main.jsp\">Back to Home!</a>");
	  conn.rollback();
	  return;

	}
	
	String viewed="delete from images_viewed where photo_id = "+pic_id;
	stmt.executeUpdate(viewed);

	String dele="delete from images where photo_id = "+pic_id;
	stmt.executeUpdate(dele);

	conn.commit();
	out.println("<h1>Delete successul.</h>");
	try{
	  conn.close();
	}
	catch(Exception ex){
	  out.println("<hr>" + ex.getMessage() + "<hr>");
	  
	}
	
      }catch (SQLException e) {
	conn.rollback();
	//out.println("<h3>The permitted may not in database.</h3>");
	
	out.println(e.getMessage());
	return;
      }
      
    %>



<%
}
else
{
  out.println("<a href=\"login.html\">You need login first!</a>");
}      
%>



  </BODY>
</HTML>
