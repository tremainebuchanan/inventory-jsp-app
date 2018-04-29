<%@page import="com.classproject.resources.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
         <title>Inventory System</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bulma/0.7.1/css/bulma.min.css" rel="stylesheet" />
        <link href="https://fonts.googleapis.com/css?family=PT+Sans:400,700" rel="stylesheet"> 
        <link href="<%=request.getContextPath()%>/css/main.css" rel="stylesheet" />
    </head>
    <%
        if("POST".equalsIgnoreCase(request.getMethod())){
            String pageRedirect = "success=false";
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String name = request.getParameter("username");
            User user = new User(email, password, name);
            if(user.Create() == 1) pageRedirect = "success=true";
            response.sendRedirect(request.getContextPath() + "/register?" + pageRedirect);
        }  
        
    %>
    <body class="login"> 
        <div class="container">
            <div class="register-form">
                <%  String success = request.getQueryString();
                    if(null != success && success.equalsIgnoreCase("success=true")){%>
                     <div class="notification is-info">
                        Your account was successfully created!
                        <a href="<%=request.getContextPath()%>/">Log In</a>
                    </div>
                <%}%>
                <h1 class="title">Register</h1> 
                <hr />
                <form novalidate method="POST" action="">
               
                  <div class="field">
                    <label class="label">Email Address</label>
                    <div class="control">
                        <input class="input is-rounded"
                               name="email" 
                               type="email" 
                               placeholder="e.g wayne.smith@email.com">
                    </div>
                </div>
                 
                <div class="field">
                    <label class="label">Full Name</label>
                    <div class="control">
                      <input class="input is-rounded"
                             name="username"
                             type="text" 
                             placeholder="e.g Wayne Smith">
                    </div>
                </div>
                 
                                 
                <div class="field">
                 <label class="label">Password</label>
                 <div class="control">
                   <input class="input is-rounded" name="password" type="password">
                 </div>
               </div>
              <div class="field">
              <p class="control">
                  <button class="button is-rounded" type="submit">
                  Register
                </button>
              </p>
            </div> 
                    
                </form>

                

                

                
           
    
                <hr />
                <p>
                    Already have an account? 
                    <a href="<%=request.getContextPath()%>/">
                        <strong>Log in</strong>
                    </a>
                </p>
                
            </div>
        </div>
    </body>
</html>

