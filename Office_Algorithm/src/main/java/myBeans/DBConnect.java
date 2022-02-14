package myBeans;

import java.sql.*;

public class DBConnect {


    //String driver = "org.postgresql.Driver";
    String driver = "com.mysql.jdbc.Driver";
    String url = "jdbc:mysql://db-office-algorithm.cgdvjzyfe0ri.us-east-1.rds.amazonaws.com:3306/office_algorithm";
    String user = "bflanz";
    String pwd = "BF575CEA668DA492";
    
    Connection conn;
    Statement stm;
    ResultSet rst;
    ResultSetMetaData rsmd;
    PreparedStatement pstm;

    private String openDB() {
        try {
            Class.forName(driver); // loads the driver into memory.
            conn = DriverManager.getConnection(url, user, pwd);
            stm = conn.createStatement();
            return "connected";
        } catch (Exception e) {
            return e.getMessage();
        }
    }

    private void closeDB() {
        try {
            stm.close();
            conn.close();
        } catch (Exception e) {

        }
    }

    public String updateDB(String sql) {
        String message = openDB();
        if (message.equals("connected")) {
            try {
                stm.executeUpdate(sql);
                closeDB();
                return "Update Successful";
            } catch (Exception e) {
                return e.getMessage();
            }
        } else {
            return message;
        }
    }
    
    public ResultSet validatePwd(String sql) {
        String message = openDB();
        if (message.equals("connected")) {
            try {
                return stm.executeQuery(sql);
            } catch (Exception e) {
                return null;
            }
        } else {
            return null;
        }
    }

    public ResultSet DBQuery(String sql) {
        String message = openDB();
        if (message.equals("connected")) {
            try {
                return stm.executeQuery(sql);
            } catch (Exception e) {
                return null;
            }
        } else {
            return null;
        }
    }
}

