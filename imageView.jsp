<html>
<head>
<title>Photo View</title>

</head>
<body  bgcolor=\"#000000\" text=\"#cccccc\" >
<center>
<%@ page import="java.sql.*" %>
<% 
if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin"))
{
  out.println("<a href=\"main.jsp\">Home</a>");

  if (request.getParameter("p_id") == null) {
    out.println("Should come from photo list!");
    return;
  } else {
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
    String sql = "select * from IMAGES where PHOTO_ID = '"+request.getParameter("p_id")+"'";

    try{
      
      stmt = conn.createStatement();

      String cmd = "INSERT INTO IMAGES_VIEWED VALUES("+request.getParameter("p_id")+",'"+session.getAttribute("USERNAME").toString()+"')";
      stmt.executeUpdate(cmd);
      conn.commit();
    }catch(Exception ex){

    }

    try{
      stmt = conn.createStatement();
      rset = stmt.executeQuery(sql);
    }catch(Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
      return;
    }

    rset.next();

    String owner=rset.getString(2);
    String perm=String.valueOf(rset.getInt(3));
    String subj=rset.getString(4);
    String place=rset.getString(5);
    String time;
    Date date=rset.getDate(6);
    if (date==null){
      time="";
    }else{
      time=date.toString();
    }
    
    String desc=rset.getString(7);
    out.println("<h3>Photo ID: "+request.getParameter("p_id")+ "</h3>");
    out.println("<h3>Owner Name: "+owner+ "</h3>");
    out.println("<h3>Permitted: "+perm+ "</h3>");
    out.println("<h3>Subject: "+subj+ "</h3>");
    out.println("<h3>Place: "+place+ "</h3>");
    out.println("<h3>Timing: "+time+ "</h3>");
    out.println("<h3>Description: "+desc+ "</h3>");
    out.println("<a href=\"updateimage.jsp?p_id="+request.getParameter("p_id")+"\">Update</a>");
    out.println("<br>");
    out.println("<a href=\"removeimage.jsp?p_id="+request.getParameter("p_id")+"\">Remove</a>");
    out.println("<br>");
    out.println("<img src=\"GetOnePic?big"+request.getParameter("p_id")+"\"></a>");
    try{
      conn.close();
    }
    catch(Exception ex){
      out.println("<hr>" + ex.getMessage() + "<hr>");
      return;
    }
  }
  
%>



<%
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
