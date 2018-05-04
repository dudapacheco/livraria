<%-- 
    Document   : Login
    Created on : 04/05/2018, 19:52:16
    Author     : Aluno
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    //logando direto
    String msg ="";
 
    if(request.getMethod().equals("POST")){
    
        if(request.getParameter("txtLogin").equals("admin") && request.getParameter("txtSenha").equals("123")){
            //salvar session
            session.setAttribute("administrador", request.getParameter("txtLogin"));
            //vai p página inicial
            response.sendRedirect("home/");
            return;
            
            }
        else{
            
            msg = "Login/senha incorretos";
            
        }
        
    }
   
    //consultar
    out.print(session.getId());
    out.print(session.getAttribute("administrador"));


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Livraria</h1>
        <h3>Login</h3>
        <%=msg%>
        <form action="#" method="post">
            <label>Login:</label>
            <input type="text" name="txtLogin"/>
            <br/>
            <label>Senha:</label>
            <input type="password" name="txtSenha"/>
            <br/>
            <button type="submit">Ok</button>
            
        </form>
    </body>
</html>
