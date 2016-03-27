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
 
  String permitted = (request.getParameter("PERMITTED")).trim();
  String subj = (request.getParameter("SUBJECT")).trim();
  String place = (request.getParameter("PLACE")).trim();
  String timing = (request.getParameter("TIMING")).trim();
  String desc = (request.getParameter("DESCRIPTION")).trim();

  String pic_id=session.getAttribute("PICID").toString();

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
    stmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,	
      ResultSet.CONCUR_UPDATABLE);
  }
  catch(Exception ex){
    
    out.println("<hr>" + ex.getMessage() + "<hr>");
    return;
  }
  

  try{


    String cmd = "SELECT IMAGES.* FROM IMAGES WHERE photo_id = "+pic_id;
    ResultSet rset = stmt.executeQuery(cmd);
    rset.next();

    

    if (permitted != ""){
      int perm;
      try {
	perm = Integer.parseInt(permitted);
      } catch (NumberFormatException e) {
	//Will Throw exception!
	//do something! anything to handle the exception.
	out.println("<h3>permitted should be number!</h3>");
	out.println("<a href=\"updateimage.jsp\">Back to update!</a>");
	conn.rollback();
	return;
      }
      rset.updateInt(3,perm);

    }


    if(subj != ""){
      rset.updateString(4,subj);
    }

    if(place != ""){
      rset.updateString(5,place);
    }
    
    if(timing != ""){
      Date date=null;
      
      try{
	date = Date.valueOf(timing);
      }catch ( IllegalArgumentException e) {
	out.println("<h3>Invalid Date format!Should be yyyy-mm-dd.</h3>");
	out.println("<a href=\"updateimage.jsp\">Back to update!</a>");
	conn.rollback();
	return;
      }

      rset.updateDate(6,date);
    }

    if(desc !=""){
      rset.updateString(7,desc);
    }
    rset.updateRow();
    conn.commit();
    out.println("<h1>Update successul.</h>");
    try{
      conn.close();
    }
    catch(Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
      
    }
    
  }catch (SQLException e) {
    conn.rollback();
    out.println("<h3>The permitted may not in database.</h3>");
    out.println("<a href=\"updateimage.jsp\">Back to update!</a>");
    out.println(e.getMessage());
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


