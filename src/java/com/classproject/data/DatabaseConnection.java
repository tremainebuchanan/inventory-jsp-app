/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.classproject.data;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    private final String _password = "H1gh53cur1ty";
    private final String _user = "root";
    private final String _connection_string = "jdbc:mysql://localhost:3306/inventory";
    private boolean _jdbcDriver = false;
    public Connection connection = null;
       
    private void GetDriver(){
        try{
            Class.forName("com.mysql.jdbc.Driver");
            _jdbcDriver = true;
        }catch(ClassNotFoundException e){
            System.out.println("Mysql JDBC driver not found");
        }
    }
     
    private Connection Create(){
        Connection conn = null;   
        if(_jdbcDriver){
            try{
            conn = DriverManager.
                    getConnection(_connection_string, _user, _password);
            System.out.println("Connection made");
            }catch(SQLException e){
                System.out.println("Connection failed");
            }
        }        
        return conn;
    }
    
    public Connection GetConnection(){
        GetDriver();
        return Create();
    }
    
    
}