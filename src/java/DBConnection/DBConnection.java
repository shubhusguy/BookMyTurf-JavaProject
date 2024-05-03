package DBConnection;

import java.sql.*;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/";
    private static final String DATABASE_NAME = "turf";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";

    protected static PreparedStatement ps = null;
    protected static Statement stmt = null;
    protected static ResultSet rs = null;

    public static Connection makeConnection() {
        Connection conn = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish connection to the MySQL database
            conn = DriverManager.getConnection(URL + DATABASE_NAME, USERNAME, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
        return conn;
    }
}
