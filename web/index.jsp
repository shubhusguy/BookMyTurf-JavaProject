<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*,java.sql.*,java.io.*,java.lang.*,UsersTurf.*,DBConnection.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Book My Turf</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }

        .middle {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }

        .flex-container {
            display: flex;
            flex-wrap: wrap;
            justify-content: space-around;
        }

        .gallery {
            margin: 15px;
            border: 1px solid #ccc;
            float: left;
            width: 180px;
        }

        .gallery:hover {
            border: 1px solid #777;
        }

        .gallery img {
            width: 100%;
            height: auto;
        }

        .desc {
            padding: 15px;
            text-align: center;
        }

        form input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        form input[type="submit"]:hover {
            opacity: 0.8;
        }
    </style>
</head>
<%@ include file="header.jsp" %> 
<body>
    
<%
    session.setAttribute("alertFlag", 1);
    session.setAttribute("checkFlag", 0);
    session.setAttribute("date", null);

    String query = "select * from turf";
    
    try (Connection conn = DBConnection.makeConnection();
         PreparedStatement ps = conn.prepareStatement(query);
         ResultSet rs = ps.executeQuery()) {
        
        String V = "V";
        
        while (rs.next()) {
            int turfId = rs.getInt("tid");
            
            String verificationQuery = "select verificationstatus from users where uid = ?";
            try (PreparedStatement psVerification = conn.prepareStatement(verificationQuery)) {
                psVerification.setInt(1, turfId);
                try (ResultSet rsVerification = psVerification.executeQuery()) {
                    while (rsVerification.next()) {
                        String verificationStatus = rsVerification.getString("verificationstatus");
                        if (V.equals(verificationStatus)) {
%>
                            <div class='middle'>
                                <div class="flex-container">
                                    <div class="gallery">
                                        <a target="_blank" href="images/TurfLogo/<%= rs.getString("logo") %>">
                                            <img src="images/TurfLogo/<%= rs.getString("logo") %>" width="800" height="600">
                                        </a>
                                          
                                        <center>
                                            <span style="background-color: #A5C1E1;">
                                                <b><%= rs.getString("tname") %> / <%= rs.getString("addr") %></b><br>
                                                  <b>Price/Hr: <%= rs.getInt("rph") %></b>
                                            </span>
                                        </center>
                                        <div class="desc">
                                            <form action="bookturf.jsp" method="post">
                                                <input type="hidden" name="tid" value="<%= rs.getString("tid") %>">
                                                <input type="submit" value="Book Now">
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
<%
                        }
                    }
                }
            }
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>

</body>
</html>
<%@ include file="footer.jsp" %> 
