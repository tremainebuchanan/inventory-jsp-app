/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.classproject.resources;

import com.classproject.data.DatabaseConnection;
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
public class Product {
    private int id;
    private String name;
    private String description;
    private Double price;
    private String created_on;
    private int quantity;

   public Product(int id, String name, String description, Double price, int quantity, String created_on) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.created_on = created_on;
        this.quantity = quantity;
    }
   public Product(){
       this.id = 0;
       this.name = "";
       this.description = "";
       this.price = 0.00;
       this.created_on = "";
   }
    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    
   public int getId(){
       return id;
   }
   
   public void setId(int id){
       this.id = id;
   }
   
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }
    
    public String getCreated_on() {
        return created_on;
    }

    public void setCreated_on(String created_on) {
        this.created_on = created_on;
    }
    
     @Override
    public String toString(){
        return "Id: '" + this.id + "', Name: '" + this.name + "', Price: '" + this.price + "'";
    }
    
    public static Product Get(int id) throws SQLException{
      ResultSet rs;
      DatabaseConnection db = new DatabaseConnection();
      Connection connection = null; 
      PreparedStatement statement = null;        
      Product product = new Product();
       try{
            connection = db.GetConnection();
            String query = "SELECT id, name, description, price, created_on FROM products WHERE id = ?";
            statement = connection.prepareStatement(query);
            statement.setInt(1, id);
            rs = statement.executeQuery(); 
            while(rs.next()){
                int retrievedId = rs.getInt("id");
                String retrievedName = rs.getString("name");
                Double retrievedPrice = rs.getDouble("price");
                product.setId(retrievedId);
                product.setName(retrievedName);
                product.setPrice(retrievedPrice);
                System.out.println(product.toString());
            }
        }catch(SQLException e){
            System.out.println(e.getMessage());            
        }finally{
           if(statement != null) statement.close();
           if(connection != null) connection.close();
       }
       return product;
    }
    
   public static ArrayList<Product> GetAll() throws SQLException{
        ArrayList<Product> list = new ArrayList<>();
        ResultSet rs;
        Statement statement = null;
        DatabaseConnection db = new DatabaseConnection();
        Connection connection = null;
        try{
            connection = db.GetConnection();    
            statement = connection.createStatement();
                String query = "SELECT * FROM products";
                rs = statement.executeQuery(query); 
                while(rs.next()){
                    int retrievedId = rs.getInt("id");
                    String retrievedName = rs.getString("name");
                    String retrievedDescription = rs.getString("description");
                    Double retrievedPrice = rs.getDouble("price");
                    String retrievedCreatedOn = rs.getString("created_on");
                    int retrievedQuantity = rs.getInt("qty");
                    Product product = new Product(retrievedId, retrievedName, retrievedDescription, retrievedPrice, retrievedQuantity, retrievedCreatedOn);
                    list.add(product);
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
