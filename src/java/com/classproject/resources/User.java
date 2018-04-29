/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.classproject.resources;
import com.classproject.data.DatabaseConnection;
import com.classproject.utilities.BCrypt;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
/**
 *
 * @author captain_kirk
 */
public class User {
    String email;
    String password;
    String name;
    
    public User(){
        this.email = "test@gmail.com";
        this.password = "password";
        this.name = "default name";
    }
    
    public User(String email, String password, String name){
        this.email = email;
        this.password = password;
        this.name = name;
    }
    
    public String getEmail(){
        return this.email;
    }
    
    public String getPassword(){
        return this.password;
    }
    
    public void setEmail(String email){
        this.email = email;
    }
    
    public void setPassword(String password){
        this.password = password;
    }
    
    public String getName(){
        return this.name;
    }
    
    public void setName(String name){
        this.name = name;
    }
    
    @Override
    public String toString(){
        return "Email: '" + this.email + "', Password: '" + this.password + "'";
    }
    
    public int Create() throws SQLException{
      DatabaseConnection db = new DatabaseConnection();
      Connection connection = null; 
      PreparedStatement statement = null;
      int inserted = 0;
      try{
          connection = db.GetConnection();
            String query = "INSERT INTO users (email, password, name) VALUES(?,?,?)";
            statement = connection.prepareStatement(query);
            statement.setString(1, this.getEmail());
            statement.setString(2, BCrypt.hashpw(this.getPassword(), BCrypt.gensalt()));
            statement.setString(3, this.getName());            
            inserted = statement.executeUpdate();
         
      }catch(SQLException e){
          System.out.println(e.getMessage());
      }finally{
          if(connection != null) connection.close();
          if(statement != null) statement.close();
      }
      return inserted;
    }
    
    public static User Get(String email) throws SQLException{
      ResultSet rs;
      DatabaseConnection db = new DatabaseConnection();
      Connection connection = null; 
      PreparedStatement statement = null;
        
      User user = new User();
       try{
            connection = db.GetConnection();
            String query = "SELECT email, password, name FROM users WHERE email = ?";
            statement = connection.prepareStatement(query);
            statement.setString(1, email);
            rs = statement.executeQuery(); 
            while(rs.next()){
                String retrievedEmail = rs.getString("email");
                String retrievedPassword = rs.getString("password");
                String retrievedName = rs.getString("name");
                user.setEmail(retrievedEmail);
                user.setPassword(retrievedPassword);  
                user.setName(retrievedName);
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());            
        }finally{
           if(statement != null) statement.close();
           if(connection != null) connection.close();
       }
       return user;
    }
    
   public static ArrayList<User> GetAll() throws SQLException{
        ArrayList<User> list = new ArrayList<>();
        ResultSet rs;
        Statement statement = null;
        DatabaseConnection db = new DatabaseConnection();
        Connection connection = null;
        try{
            connection = db.GetConnection();    
            statement = connection.createStatement();
                String query = "SELECT email, password FROM users";
                rs = statement.executeQuery(query); 
                while(rs.next()){
                    User user = new User();
                    user.setPassword(rs.getString("password"));
                    user.setEmail(rs.getString("email"));
                    list.add(user);
                }
        }catch(SQLException e){
            System.out.println(e.getMessage());
            
        }finally{
            if(statement != null) statement.close();
            if(connection != null) connection.close();
        }
       return list;
    }
   
}
