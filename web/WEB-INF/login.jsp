<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Processando Login</title>
</head>
<body>
    <h2>Login Processado</h2>

    <%
        String usuario = request.getParameter("usuario");
        String senha = request.getParameter("senha");

        // Lógica de conexão com o banco de dados (exemplo simples)
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;

        try {
            // Configuração do banco de dados (ajuste os dados conforme necessário)
            String dbURL = "jdbc:mysql://localhost:3306/seubanco";
            String dbUser = "root";
            String dbPassword = "senha";

            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

            // Query para verificar se o usuário existe
            String query = "SELECT * FROM usuarios WHERE usuario = ? AND senha = ?";
            stmt = conn.prepareStatement(query);
            stmt.setString(1, usuario);
            stmt.setString(2, senha);
            rs = stmt.executeQuery();

            if (rs.next()) {
                // Se encontrar o usuário, login bem-sucedido
                out.println("<p>Bem-vindo, " + usuario + "!</p>");
                // Redirecionar para uma página principal ou painel de controle
                response.sendRedirect("paginaPrincipal.jsp");
            } else {
                // Se não encontrar o usuário, login falhou
                out.println("<p style='color:red;'>Usuário ou senha inválidos.</p>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<p style='color:red;'>Erro ao conectar ao banco de dados.</p>");
        } finally {
            // Fechar conexões de banco de dados
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    %>
</body>
</html>
