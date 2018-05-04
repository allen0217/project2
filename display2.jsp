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
    public class NumberSeat{
        String URL = "jdbc:mysql://localhost:3306/airline";
        String USERNAME = "root";
        String PASSWORD = "";
        
        Connection connection = null;
        PreparedStatement selectNumberSeats = null;
        ResultSet resultSet = null;
        
        public NumberSeat()
        {
           try {
               connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
               selectNumberSeats = connection.prepareStatement(
           
                      "SELECT (SELECT Total_number_of_seats FROM AIRPLANE,FLIGHT_INSTANCE WHERE AIRPLANE.AIRPLANE_ID = flight_instance.AIRPLANE_id AND FLIGHT_NUMBER = ? AND DATE= ?) - (SELECT COUNT(*) FROM FLIGHT_INSTANCE WHERE FLIGHT_NUMBER = ? AND DATE= ? ) AS Number from Flight_instance WHERE FLIGHT_NUMBER = ? AND DATE= ?");
                         
  
           }
           catch (SQLException e)
           {
               e.printStackTrace();
           }
           }
            
       public ResultSet getNumberSeats(String Flight_number,String Date)
               {
                   try{
                        selectNumberSeats.setString(1,Flight_number);
                        selectNumberSeats.setString(2,Date);  
                        selectNumberSeats.setString(3,Flight_number);
                        selectNumberSeats.setString(4,Date); 
                        selectNumberSeats.setString(5,Flight_number);
                        selectNumberSeats.setString(6,Date); 
                         resultSet = selectNumberSeats.executeQuery();
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
     
      NumberSeat numberSeat = new NumberSeat();
      ResultSet numberSeats = numberSeat.getNumberSeats(flightNumber,Date);

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
           
            <td>Number_of_available_seats</td>
            <td><%=Date%></td>
            
        </tr>
        <%while (numberSeats.next())    { %>
        <tr>
           
            <td><%=numberSeats.getString("Number")%>  </td>
            
        </tr>
        <% }%>
    </tbody>
</table>

</html>

