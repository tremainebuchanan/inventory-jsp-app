<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import ="com.classproject.resources.User" %>
<%@page import ="com.classproject.utilities.BCrypt" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
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
    <body class="login">
         <%              
             Boolean error = false;
             if("POST".equalsIgnoreCase(request.getMethod())){
                 String email = request.getParameter("email");
                 String password = request.getParameter("password");
                 User user = User.Get(email);
                 System.out.print(user.toString());
                if(user.getEmail() != null){
                    if(BCrypt.checkpw(password, user.getPassword())){
                        session.setAttribute("username", user.getName());
                        response.sendRedirect(request.getContextPath() + "/dashboard/");                        
                    }else{
                        error = true;
                    }
                } 
             }else{
                 String logout = request.getQueryString();
                 if(logout != null){
                     session.invalidate();
                 }
             }                     
          %>
           
        <div class="container">           
            
            <div class="login-form">
                <% if(error) {%>
                <div class="notification is-danger">
                    Please check your email\password.
                </div>
                <%}%>
                <form name="login_form" method="post" action="">
                    <h1 class="title" style="text-align:center">Log In</h1>
                <hr />
                <div class="field">
                    <label class="label">Email Address</label>
                    <div class="control">
                      <input class="input is-rounded"
                             id="email_address"
                             name="email" 
                             type="email" placeholder="e.g wayne.smith@email.com">
                    </div>
                </div>

            <div class="field">
              <label class="label">Password</label>
              <div class="control">
                  <input class="input is-rounded" 
                         id="password"
                         type="password" name="password">
              </div>
            </div>
                
            <div class="field">
              <p class="control">
                  <button class="button is-rounded" type="submit">
                  Log In
                </button>
              </p>
            </div> 
                    
                </form>
                
                <hr />
                <p>
                    Don't have an account? <a href="<%=request.getContextPath()%>/register/"><strong>Register here</strong></a>
                </p>
           </div>                    
        </div>
    </body>
</html>


