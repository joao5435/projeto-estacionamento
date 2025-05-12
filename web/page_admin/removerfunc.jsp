<%@page import="java.sql.*" %>
<%@page import="java.time.*" %>
<%@page import="java.time.format.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
       //recebe o código do produto a ser alterado e 
       // na variavel.
       String email;
       email = request.getParameter("email");
       try{
       
       Connection  conecta;
       PreparedStatement st;
       Class.forName("com.mysql.cj.jdbc.Driver");
       String url="jdbc:mysql://localhost:3306/estacionamento_administrador";
       String user="root";
       String password="root";
       
       conecta=DriverManager.getConnection(url,user,password);
       //Buscar o produto pelo código recebido
       String sqlresultado = ("SELECT * FROM usuario WHERE email = ?");
       st = conecta.prepareStatement(sqlresultado);
       //ResultSet serve para guardar aquilo que é trazido pelo BD
       st.setString(1, email);
       ResultSet resultado = st.executeQuery();
       //Verifica se o produto de codigo informado foi encontrado
       if (!resultado.next()){
           out.print("Este funcionario não foi localizado");
           
            }else{ 
             String sql = "DELETE FROM usuario WHERE email = ?";
                st = conecta.prepareStatement(sql);
                st.setString(1,email);
                
                
                int resultadoUpdate = st.executeUpdate();
                
                if (resultadoUpdate == 0){
                    out.print("Este funcionario não está cadastrado no banco");
            }else{
                    out.print("O Funcionario : " + email + " , foi excluido com sucesso");
            }
            }
            
             }catch (Exception erro){
                String mensagemErro = erro.getMessage();
                out.print( mensagemErro  + "Entre em contato com o administrador e informe o erro");
            }
      
            %>
    </body>
</html>
