<html>
  <head>
    <TITLE>Admin Manage</TITLE>
  </head>
  <body>

    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.Calendar" %>
    <%@ page import="java.text.SimpleDateFormat" %>
    <%@ page import="java.util.Date" %>

    <%
    if( session.getAttribute("isLogin")!=null && (Boolean)session.getAttribute("isLogin") && session.getAttribute("USERNAME").toString().equals("admin")){
    %>
      <form>
	<table>
	  <tr>
	    <td>Filter:</td>
	  </tr>
	  <tr>
	    <td><input type = "checkbox", name = "user", value = "user">user<br></td>
	    <td> Key words:</td>
      	    <td><input type="text" name="userString" ></td>
	  </tr>
	  <tr>
	    <td><input type = "checkbox", name = "subject", value = "subject">subject<br></td>
     	    <td> Key words:</td>
      	    <td><input type="text" name="subjectString" ></td>
    	  </tr>
    	  <tr>
	    <td><input type = "checkbox", name = "time", value = "weekly">weekly<br></td>
	    <td><input type = "checkbox", name = "time", value = "monthly">monthly<br></td>
	    <td><input type = "checkbox", name = "time", value = "yearly">yearly<br></td>
	    <td><input type = "checkbox", name = "time", value = "all">ALL<br></td>
      	  </tr>
    	  <tr>
      	    <td> From:</td>
	    <td><input name="FROM" type="text"></td>
    	  </tr>
    	  <tr>
      	    <td>To:</td>
	    <td><input name="TO" type="text"></td>
	  </tr>

      	  <tr>
      	    <td><input type = "submit", name = "submit", value = "submit"></td>
      	    <tr>
	</table>
      </form>
      

      <%     if( request.getParameter("submit") != null){
	
	String userCheck = request.getParameter("user");
	String subjectCheck = request.getParameter("subject");
	String timeCheck = request.getParameter("time");
	String userStr = request.getParameter("userString");
	String subStr = request.getParameter("subjectString");
	String from = request.getParameter("FROM");
	String to = request.getParameter("TO");

	Connection conn = null;
	Statement stmt = null;
	ResultSet rset = null;	

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
	  stmt = conn.createStatement();
	}
	catch(Exception ex){
	  out.println("<hr>" + ex.getMessage() + "<hr>");
	  return;
	}

	String sql = null;
	String groupby = null;
	String where = null;
	String execute = null;
	int column = 1;

	if(userCheck != null){
	  column++;
	}
	if(subjectCheck != null){
	  column++;
	}
	if(timeCheck != null){
	  column++;
	}
	
	String usersql = null;/////user sql
	if(userStr != ""){
	  usersql = " owner_name = '"+ userStr +"' ";		
	}
	String subsql = null;/////subject sql
	if(subStr != ""){
	  subsql = " subject = '"+ subStr +"' ";
	}
	
	String timesql = null;//////time sql
	if(from == "" && to != ""){
	  try{
            java.sql.Date date1 = java.sql.Date.valueOf(to);
          }catch ( IllegalArgumentException e) {
            out.println("Invalid Date format!Should be yyyy-mm-dd.");
            return;
          }

          timesql=" timing<=to_date('"+to+"','yyyy-mm-dd') ";
	}
	else if(from != "" && to == ""){
	  try{
            java.sql.Date date = java.sql.Date.valueOf(from);
          }catch ( IllegalArgumentException e) {
            out.println("Invalid Date format!Should be yyyy-mm-dd.");
            return;
          }

          timesql=" timing>=to_date('"+from+"','yyyy-mm-dd') ";
	}
	else if(from != "" && to != ""){
	  try{
            java.sql.Date date = java.sql.Date.valueOf(from);
	    java.sql.Date date1 = java.sql.Date.valueOf(to);
          }catch ( IllegalArgumentException e) {
            out.println("Invalid Date format!Should be yyyy-mm-dd.");
            return;
          }
	  timesql = " timing>=to_date('"+from+"','yyyy-mm-dd') and timing<=to_date('"+to+"','yyyy-mm-dd') ";
	}
	else{
	  timesql = null;
	}




	///////////////////to generate where sql
	if(usersql != null && subsql == null && timesql== null){
	  where = " where " + usersql;
	}
	else if(usersql == null && subsql != null && timesql== null){
	  where = " where " + subsql;
	}
	else if(usersql == null && subsql == null && timesql!= null){
	  where = " where " + timesql;
	}
	else if(usersql != null && subsql != null && timesql== null){
	  where = " where " + usersql + " and " + subsql;
	  out.println("1");
	}
	else if(usersql == null && subsql != null && timesql!= null){
	  where = " where " + subsql + " and " + timesql;
	}
	else if(usersql != null && subsql == null && timesql!= null){
	  where = " where " + usersql + " and " + timesql;
	}
	else if(usersql != null && subsql != null && timesql!= null){
	  where = " where " + usersql + " and " + subsql + " and " + timesql;
	}
	else where = null;

	///////////////////

	///////////////////////////////generate the execute sql query

	////////////////////if time checkbox is choosed
	if(timeCheck != null){
	  ////////to determine which time hierarchy is checked
	  if(timeCheck.equals("yearly")){////////////yearly checked
	    sql = " extract(year from timing) as year ,count(photo_id) ";
	    groupby = " group by extract(year from timing)";
	  }
	  else if(timeCheck.equals("monthly")){//////////////monthly checked
	    sql = " extract(month from timing) as month, count(photo_id) ";
	    groupby = " group by extract(month from timing)";
	  }
	  else if(timeCheck.equals("weekly")){////////////////weekly checked
	    sql = "to_number(to_char(timing+1,'IW')) as week,  count(photo_id) ";
	    groupby = " GROUP BY to_number(to_char(timing+1,'IW'))";
	  }else if(timeCheck.equals("all")){////////////////weekly checked
	    sql = "timing,  count(photo_id) ";
	    groupby = " GROUP BY timing";
	  }
	  /////////end of choosing one time hierarchy

	  if(userCheck == null && subjectCheck == null){////nothing checked
	    if(where == null){
	      execute = "select "+ sql + " from images " + groupby;
	    }
	    else execute = "select "+ sql + " from images " + where + groupby; 
	  }
	  else if(userCheck == null && subjectCheck != null){/////subject checked
	    if(where == null){
	      execute = " select subject, " + sql +  " from images " + groupby + " , subject";
	    }
	    else execute = " select subject ," + sql + " from images " + where + groupby + " , subject";
	  }
	  else if(userCheck != null && subjectCheck == null){//////user checked
	    if(where == null){
	      execute = " select owner_name ," + sql +  " from images " + groupby + " , owner_name";
	    }
	    else execute = " select owner_name ," + sql + " from images " + where + groupby + " , owner_name ";
	  }
	  else if(userCheck != null && subjectCheck != null){//////user and subject checked
	    if(where == null){
	      execute = " select owner_name , subject, " + sql +  " from images " + groupby + " , subject, owner_name ";
	    }
	    else execute = " select owner_name , subject, " + sql + " from images " + where + groupby + " , subject, owner_name ";
	  }
	}

	///////////////////////time checkbox is not checked
	else{
	  if(userCheck == null && subjectCheck == null){////nothing checked
	    if(where == null){
	      execute = " select count(photo_id) " + " from images ";
	    }
	    else execute = " select count(photo_id) " + " from images " + where; 
	  }
	  else if(userCheck == null && subjectCheck != null){///////subject checked
	    if(where == null){
	      execute = "select subject,  count(photo_id)  " + " from images " +" group by subject";
	    }
	    else execute = "select subject, count(photo_id)  " + " from images " + where  + " group by subject";

	  }
	  else if(userCheck != null && subjectCheck == null){/////////////user checked
	    if(where == null){
	      execute = " select owner_name , count(photo_id) " + "  from images " + " group by owner_name";
	    }
	    else execute = "select owner_name, count(photo_id) " + " from images " + where + " group by owner_name";
	  }
	  else if(userCheck != null && subjectCheck != null){//////////user and subject checked
	    if(where == null){
	      execute = "select owner_name , subject, count(photo_id) " + " from images " + "group by subject, owner_name";
	    }
	    else execute = "select owner_name , subject, count(photo_id) " + "from images " + where + " group by subject, owner_name";
	  }
	}
	////////////////end of creating an execute query


	try{
	  //out.println(execute);
	  stmt = conn.createStatement();
	  rset = stmt.executeQuery(execute);
	  int i;
	  
	  out.println("<table border = 2>");
	  while(rset.next()){
	    String num = rset.getString(1);
	    int k=1; 
	    out.println("<tr>");
	    while(k<=column) {
	      out.println("<td>"+rset.getString(k)+"</td>");
	      k += 1;
	      //i=i+1;
	    }
	    //out.println("<td>"+num+"</td>");
	    out.println("</tr>");
	  }
	  out.println("</table>");
	  conn.close();
	  out.println("<a href=\"main.jsp\" >Go to main page</a>");
	}
	catch(Exception ex){
	  out.println("<hr>" + ex.getMessage() + "<hr>");
	  return;
	}

      }

      }else{

	out.println("<a href=\"main.jsp\">You need to login as admin!</a>");

      }


      %>

  </body>
</html>
