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
           
            "Select FLIGHT_INSTANCE.Flight_number,FLIGHT_INSTANCE.Date,Airplane_id,Departure_time,Arrival_time FROM FLIGHT_INSTANCE,SEAT_RESERVATION WHERE FLIGHT_INSTANCE.Flight_number= seat_reservation.flight_number and flight_instance.date = seat_reservation.date and CUSTOMER_NAME = ?");                         
  
           }
           catch (SQLException e)
           {
               e.printStackTrace();
           }
           }
            
       public ResultSet getPassengerNames(String Customer_name)
               {
                   try{
                       
                         selectPassengerNames.setString(1,Customer_name);
                         
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
        String Customer_name = new String();
        
    
      if (request.getParameter("name")!= null){
         Customer_name = request.getParameter("name");
      }
      
     
      PassengerName passengerName = new PassengerName();
      ResultSet passengerNames = passengerName.getPassengerNames(Customer_name);

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
           
            <td>Flight_number</td>
            <td>Flight_Date</td>
           
            <td>Airplane_id</td>
            <td>Departure_time</td>
            <td>Arrival_time</td>
        </tr>
        <%while (passengerNames.next())    { %>
        <tr>
           
            <td><%=passengerNames.getString("FLIGHT_INSTANCE.Flight_number")%>  </td>
            <td><%=passengerNames.getString("FLIGHT_INSTANCE.Date")%>  </td>
            <td><%=passengerNames.getString("Airplane_id")%>  </td>
            <td><%=passengerNames.getString("Departure_time")%>  </td>
            <td><%=passengerNames.getString("Arrival_time")%>  </td>
            
        </tr>
        <% }%>
    </tbody>
</table>

</html>


