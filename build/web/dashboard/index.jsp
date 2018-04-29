<%-- 
    Document   : dashboard
    Created on : Apr 28, 2018, 7:01:33 PM
    Author     : captain_kirk
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="com.classproject.resources.Product" %>
<!DOCTYPE html>
<html>
      <head>
        <title>Inventory System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=PT+Sans:400,700" rel="stylesheet"> 
        <link href="css/main.css" rel="stylesheet" />
        
    </head>
    <%
        if(session.getAttribute("username") == null){
            response.sendRedirect(request.getContextPath() + "/");
        }   
        
        ArrayList<Product> products = Product.GetAll();       
        
    %>
    <body style="background-color: #EEEEEE;min-height: 100vh; height: auto;" class="has-navbar-fixed-top">
        <nav class="navbar is-dark is-fixed-top" role="navigation" aria-label="main navigation">
         <div class="container">
          <div class="navbar-brand">
          <a class="navbar-item" href="<%=request.getContextPath()%>/dashboard/">
              <img src="<%=request.getContextPath()%>/img/logo.png"/>
          </a>

            <a role="button" class="navbar-burger" aria-label="menu" aria-expanded="false">
              <span aria-hidden="true"></span>
              <span aria-hidden="true"></span>
              <span aria-hidden="true"></span>
            </a>
            </div>
             <div class="navbar-menu">
                 <div class="navbar-start">
                     <a class="navbar-item" href="<%=request.getContextPath()%>/dashboard/">Home</a>
                 </div> 
                 
                 <div class="navbar-end">
                     <a class="navbar-item">Logged in as <% out.print(session.getAttribute("username"));%></a>
                     <a class="navbar-item" href="<%=request.getContextPath()%>/?logout=true">Logout</a>
                 </div>
               
             </div>
        </div>
      </nav>
        
        <div class="container">            
            <div style="margin-top: 40px;padding-bottom: 100px">
            <h2 class="title is-4">Products (<% out.print(products.size()); %>)</h2>
            
             <div class="product-list">
                 <% if(products.size() < 1){%>
                 <div class="notification">There are <strong><%=products.size()%></strong> products in the database.</div>
                 <% }else{ %>
             <table class="table is-hoverable is-fullwidth">
                 <thead>
                 <th>ID</th>
                 <th>Name</th>
                 <th>Description</th>
                 <th>Selling Price</th>
                 <th>Quantity in Stock</th>
                 </thead>
             <%for(int i = 0; i < products.size(); i++){%>
             <tr>
                 <td><% out.print(products.get(i).getId());%></td>
                 <td><% out.print(products.get(i).getName()); %></td>   
                 <td><% out.print(products.get(i).getDescription()); %></td>
                 <td>$<% out.print(String.format("%.2f", products.get(i).getPrice())); %></td>
                 <td><% out.print(products.get(i).getQuantity()); %></td>
             </tr>
            <%}%>
            <%}%>
            </table>            
            </div>
            </div>
        </div>        
    </body>
</html>
