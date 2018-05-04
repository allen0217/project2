<<%@taglib prefix ="sql" uri= "http://java.sun.com/jsp/jstl/sql"%>
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
        <h1>Flight information</h1>
    </body>
    <%!
    public class PassengerName{
        String URL = "jdbc:mysql://localhost:3306/airline";
        String USERNAME = "root";
        String PASSWORD = "";
        
        Connection connection = null;
        PreparedStatement selectPassengerNames = null;
        ResultSet resultSet = null;
        
        public PassengerName()
        {
           try {
               connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
               selectPassengerNames = connection.prepareStatement(
           
                      "SELECT Customer_name,Customer_phone FROM SEAT_RESERVATION WHERE FLIGHT_NUMBER =? AND DATE =?");
                         
  
           }
           catch (SQLException e)
           {
               e.printStackTrace();
           }
           }
            
       public ResultSet getPassengerNames(String Flight_number,String Date)
               {
                   try{
                        selectPassengerNames.setString(1,Flight_number);
                        selectPassengerNames.setString(2,Date);  
                         
                         resultSet = selectPassengerNames.executeQuery();
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
        String flightNumber = new String();
        String Date = new String();
    
    
      if (request.getParameter("flightNumber")!= null){
         flightNumber = request.getParameter("flightNumber");
      }
      if (request.getParameter("date")!= null){
         Date = request.getParameter("date");
      }
     
      PassengerName passengerName = new PassengerName();
      ResultSet passengerNames = passengerName.getPassengerNames(flightNumber,Date);

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
           
            <td>Customer_name</td>
            <td>Customer_phone</td>
            
        </tr>
        <%while (passengerNames.next())    { %>
        <tr>
           
            <td><%=passengerNames.getString("Customer_name")%>  </td>
            <td><%=passengerNames.getString("Customer_phone")%>  </td>
        </tr>
        <% }%>
    </tbody>
</table>

</html>

