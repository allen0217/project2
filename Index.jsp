<%-- 
    Document   : Index
    Created on : Mar 2, 2015, 5:27:27 PM
    Author     : Yilun
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Flight System</title>
    </head>
   
    <body>
        <h1>Airport Code</h1>
        <form name="flight query" action="display.jsp" method="POST">
            
            <table border="0">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Departure Airport Code:</td>
                        <td><input type="text" name="Departure" value="" /></td>
                    </tr>
                    <tr>
                        <td>Arrival Airport Code:</td>
                        <td><input type="text" name="Arrival" value="" /></td>
                    </tr>
                        
                </tbody>
                
                <select name="connectflights">
                <option >nonstop</option>
                <option >onestop</option>
                <option >twostop</option>
                </select>
                
                
                
                
                
                
            </table>
            
            
            
            <input type="submit" value="submit" name="submit" />
            </form>
            
            
        
            <h2>Available Seats</h2>
        <form name="seats" action="display2.jsp" method="POST">
            <table border="0">
                <thead>
                    <tr>
                        <th></th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Flight Number :</td>
                        <td><input type="text" name="flightNumber" value="" /></td>
                    </tr>
                    <tr>
                        <td>Flight Date :</td>
                        <td><input type="date" name="date" value="" /></td>
                    </tr>
                        
                </tbody>
            </table>
            <input type="submit" value="submit" name="submit" />          
        </form>
            
            
         
            
            
            
            
            
        <h3>Fare Informations</h3>
        <form name="fare" action="display3.jsp" method="POST">
            <table border="0">                
                <tbody>
                    <tr>
                        <td>Flight Number :</td>
                        <td><input type="text" name="flightNumber" value="" size="25" /></td>
                    </tr>                                      
                </tbody>
            </table>
            <input type="submit" value="submit" name="Submit" />            
        </form>
        
        
        
        
        
        
        
        
        <h4>Passenger Information</h4>
        <form name="passengers" action="display4.jsp" method="POST">
            <table border="0">                
                <tbody>
                    <tr>
                        <td>Flight Number : </td>                        
                        <td>Date : </td>                        
                    </tr> 
                    <tr>
                        <td><input type="text" name="flightNumber" value="" size="25" /></td>
                        <td><input type="date" name="date"></td>
                    </tr>
                </tbody>
            </table>
            <input type="submit" value="submit" name="Submit" />            
        </form>
        
        <h4>Passenger Information</h4>
        <form name="flightlist" action="display5.jsp" method="POST">
            <table border="0">                
                <tbody>
                    <tr>
                        <td>Passenger Name : </td>
                        <td><input type="text" name="name" value="" size="25" /></td>
                    </tr>                                       
                </tbody>
            </table>
            <input type="submit" value="submit" name="Submit" />            
        </form>
        
        
        
        
        
        
    </body>
</html>
            
            
            
            
            
            
            
      