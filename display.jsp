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
        <h1>Flight information</h1>
    </body>
    <%!
    public class AirportCode{
        String URL = "jdbc:mysql://localhost:3306/airline";
        String USERNAME = "root";
        String PASSWORD = "";
        
        Connection connection = null;
        PreparedStatement selectAirportCodes = null;
        PreparedStatement selectAirportCodes2 = null;
        PreparedStatement selectAirportCodes3 = null;
        ResultSet resultSet = null;
        
        
        public AirportCode()
        {
            
                 try {
               connection = DriverManager.getConnection(URL,USERNAME,PASSWORD);
               
               
                selectAirportCodes = connection.prepareStatement(
                       
                "SELECT Flight_number,Weekdays FROM flight WHERE Departure_airport_code =? AND Arrival_airport_code =?");
               
                selectAirportCodes2 = connection.prepareStatement(
                       
                "select f1.flight_number,f1.weekdays,f2.flight_number, f2.weekdays from flight as f1, flight as f2 where f1.departure_airport_code =? AND f2.arrival_airport_code = ?  AND f1.arrival_airport_code = f2.departure_airport_code AND timediff(f2.scheduled_arrival_time,f1.scheduled_departure_time) >time('1:00:00')");
              
                
             
               selectAirportCodes3 = connection.prepareStatement(
                       
                "  select f1.flight_number,f1.weekdays,f2.flight_number, f2.weekdays,f3.flight_number,f3.weekdays from flight as f1, flight as f2,flight as f3 where f1.departure_airport_code =? AND f3.arrival_airport_code = ?  AND f1.arrival_airport_code = f2.departure_airport_code AND f2.arrival_airport_code = f3.departure_airport_code and f1.arrival_airport_code !=f3.arrival_airport_code AND timediff(f2.scheduled_arrival_time,f1.scheduled_departure_time) >time('1:00:00') And timediff(f3.scheduled_arrival_time,f2.scheduled_departure_time) >time('1:00:00')");
             
                
                
                
                
           }
           catch (SQLException e)
           {
               e.printStackTrace();
           }
           }
          
        public String getWeekdays(String a,String b)
                
                { 
                    String c = "";
                    
                    if ( a.contains("Sun") && b.contains("Sun"))
                        c += "Sun_";
                    if ( a.contains("Mon") && b.contains("Mon"))
                        c += "Mon_";
                     if ( a.contains("Tue") && b.contains("Tue"))
                        c += "Tue_";
                     if ( a.contains("Wed") && b.contains("Wed"))
                        c += "Wed_";
                     if ( a.contains("Thu") && b.contains("Thu"))
                        c += "Thu_";
                     if ( a.contains("Fri") && b.contains("Fri"))
                        c += "Fri_";
                     if ( a.contains("Sat") && b.contains("Sat"))
                        c += "Sat_";
                     return (c.substring(0,c.length()-1));
                     
                    
                }
                    
                    
                 
        
        
        
        
         public ResultSet getAirportCodes(String Departure_airport_code,String Arrival_airport_code,String selectoption)
               {
                   try{
                       selectAirportCodes.setString(1,Departure_airport_code);
                        selectAirportCodes.setString(2,Arrival_airport_code); 
                        selectAirportCodes2.setString(1,Departure_airport_code);
                        selectAirportCodes2.setString(2,Arrival_airport_code);
                        selectAirportCodes3.setString(1,Departure_airport_code);
                        selectAirportCodes3.setString(2,Arrival_airport_code);
                        
                                
                          if(selectoption.equals("nonstop") ){
                         resultSet = selectAirportCodes.executeQuery();}
                          
                           if(selectoption.equals("onestop"))
                           {
                         resultSet = selectAirportCodes2.executeQuery();
                           }
                            if(selectoption.equals("twostop"))
                            {
                          resultSet = selectAirportCodes3.executeQuery();
                          }
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
        String Departure_airport_code = new String();
        String Arrival_airport_code = new String();
        String selectoption = new String();
              
    
      if (request.getParameter("Departure")!= null){
         Departure_airport_code = request.getParameter("Departure");
      }
      if (request.getParameter("Arrival")!= null){
         Arrival_airport_code = request.getParameter("Arrival");
      }
      
       if (request.getParameter("connectflights")!= null){
           selectoption= request.getParameter("connectflights");
        
          
      }
     
      AirportCode airportcode = new AirportCode();
      ResultSet airportcodes = airportcode.getAirportCodes(Departure_airport_code,Arrival_airport_code,selectoption);
      
    %> 
 <% 
    if(selectoption.equals("nonstop"))
    {
   %> 
<table border="1">
    <thead>
        <tr>
            <th></th>
            <th></th>
            
        </tr>
    </thead>
    <tbody>
        <tr>
           
            <td>Flight_number</td>
            <td>Weekdays</td>
          
            
            
            
        </tr>
        <%while (airportcodes.next())    { %>
        <tr>
           
            <td><%=airportcodes.getString(1)%>  </td>
            <td><%=airportcodes.getString(2)%>   </td>
            
        </tr>
        <% }%>
    </tbody>
</table>
    <%
}
     if(selectoption.equals("onestop"))
    {
        
 %>       
<table border="1">
    <thead>
        <tr>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody>
        <tr>
           
            <td>Flight_number</td>
            <td>Weekdays</td>
             <td>Flight_number</td>
            <td>Weekdays</td>
            
            
            
        </tr>
        <%while (airportcodes.next())    { %>
        <tr>
           
            <td><%=airportcodes.getString(1)%>  </td>
            <td><%=airportcode.getWeekdays(airportcodes.getString(2),airportcodes.getString(4))%>   </td>
            <td><%=airportcodes.getString(3)%>  </td>
            <td><%=airportcode.getWeekdays(airportcodes.getString(2),airportcodes.getString(4))%>  </td>
        </tr>
        <% }%>
    </tbody>
</table>
    <%
}
 if(selectoption.equals("twostop"))
    {
    %>
    <table border="1">
    <thead>
        <tr>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            <th></th>
            
        </tr>
    </thead>
    <tbody>
        <tr>
           
            <td>Flight_number</td>
            <td>Weekdays</td>
            <td>Flight_number</td>
            <td>Weekdays</td>
            <td>Flight_number</td>
            <td>Weekdays</td>
            
            
        </tr>
        <%while (airportcodes.next())    { %>
        <tr>
           
            <td><%=airportcodes.getString(1)%>  </td>
            <td><%=airportcode.getWeekdays(airportcodes.getString(2),airportcodes.getString(4))%>   </td>
            <td><%=airportcodes.getString(3)%>  </td>
            <td><%=airportcode.getWeekdays(airportcodes.getString(2),airportcodes.getString(4))%>  </td>
            <td><%=airportcodes.getString(5)%>  </td>
            <td><%=airportcode.getWeekdays(airportcode.getWeekdays(airportcodes.getString(2),airportcodes.getString(4)),airportcodes.getString(6))%>   </td>
        </tr>
        <% }%>
    </tbody>
</table>
<%    
}
    %> 
    
</html>
