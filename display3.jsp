<%@taglib prefix ="sql" uri= "http://java.sun.com/jsp/jstl/sql"%>
<%-- 
    Document   : display
    Created on : Mar 25, 2015, 4:26:01 PM
    Author     : Yilun
--%>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");   %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>selecting specific data from a DB</title>
    </head>
    <body>
        <h1>Fare information</h1>
    </body>
    <%!
    public class FareInfo{
        String URL = "jdbc:mysql://localhost:3306/airline";
        String USERNAME = "root";
        String PASSWORD = "";
        
        Connection connection = null;
        PreparedStatement selectFareInfos = null;
        ResultSet resultSet = null;
        
        public FareInfo()
        {
           try {
               connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
               selectFareInfos = connection.prepareStatement(
                       "SELECT Fare_code,Amount,Restrictions FROM Fare WHERE Flight_number =?");
               
  
           }
           catch (SQLException e)
           {
               e.printStackTrace();
           }
           }
            
       public ResultSet getFareInfos(String Flight_number)
               {
                   try{
                       selectFareInfos.setString(1,Flight_number);
                            
                         resultSet = selectFareInfos.executeQuery();
                          }
                   catch (SQLException e)
                   {
                              e.printStackTrace();
                              
               }
                   return resultSet;
               }
  
    }
    %>
    <%
        
        String Flight_number = new String();
    
    
      if (request.getParameter("flightNumber")!= null){
         Flight_number = request.getParameter("flightNumber");
      }
     
      FareInfo fareInfo = new FareInfo();
      ResultSet fareInfos = fareInfo.getFareInfos(Flight_number);

%> 
<table border="1">
    <thead>
        <tr>
            <th></th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
           
            <td>Fare_code</td>
            <td>Amount</td>
            <td>Restrictions</td>
        </tr>
        <%while (fareInfos.next())    { %>
        <tr>
           
            <td><%=fareInfos.getString("Fare_code")%>  </td>
            <td><%=fareInfos.getString("Amount")%>   </td>
            <td><%=fareInfos.getString("Restrictions")%>   </td>
        </tr>
        <% }%>
    </tbody>
</table>

</html>
