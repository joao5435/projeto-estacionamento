<%@page import="java.sql.*" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Cadastro de carros</title>
        </head>

        <body>  

            <% 

       String placa = request.getParameter("placa");
boolean placaValida = false;


if (placa != null) {
    placa = placa.toUpperCase().trim();

    if (placa.length() != 7) {
        out.print("<p style='color: red; font-family: fantasy;'>Erro: A placa deve conter exatamente 7 caracteres.</p>");
    } else if (placa.matches("[A-Z]{3}[0-9]{4}")) {
        placaValida = true;
    } else if (placa.matches("[A-Z]{3}[0-9]{1}[A-Z]{1}[0-9]{2}")) {
        placaValida = true;
    } else {
        out.print("<p style='color: red; font-family: fantasy;'>Erro: A placa não corresponde a um formato válido.</p>");
    }
} else {
    out.print("<p style='font-family: fantasy;'>Digite a placa no formulário para validar.</p>");
}

String data_entrada = request.getParameter("data_entrada");
boolean dataValida = true;

if (data_entrada != null && placaValida) {
    try {
        java.time.LocalDate dataAtual = java.time.LocalDate.now();
        java.time.LocalDate dataEntrada = java.time.LocalDate.parse(data_entrada);

        if (dataEntrada.isBefore(dataAtual)) {
            out.print("<p style='color:red; font-family: fantasy;'>❌ Erro: A data de entrada não pode ser anterior ao dia de hoje.</p>");
            dataValida = false;
        } else if (dataEntrada.isAfter(dataAtual)) {
            out.print("<p style='color:red; font-family: fantasy;'>❌ Erro: A data de entrada não pode ser posterior ao dia de hoje</p>");
            dataValida = false;
        }
    } catch (Exception e) {
        out.print("<p style='color:red; font-family: fantasy;'>❌ Erro: Data em formato inválido.</p>");
        dataValida = false;
    }
} else {
    dataValida = false;
}

if ("POST".equalsIgnoreCase(request.getMethod()) && placaValida && dataValida) {
    String hora_entrada = request.getParameter("hora_entrada");

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        String url = "jdbc:mysql://localhost:3306/estacionamento_administrador";
        String user = "root";
        String password = "";

        Connection connecta = DriverManager.getConnection(url, user, password);
        String sql = "INSERT INTO carro (placa, hora_entrada, data_entrada) VALUES (?, ?, ?)";
        PreparedStatement ps = connecta.prepareStatement(sql);
        ps.setString(1, placa);
        ps.setString(2, hora_entrada);
        ps.setString(3, data_entrada);

        int linhasAfetadas = ps.executeUpdate();

        if (linhasAfetadas > 0) {
            if (placa.matches("[A-Z]{3}[0-9]{4}")) {
                out.print("<p style='font-family: fantasy;'>Placa válida no modelo antigo (ABC1234).</p>");
            } else if (placa.matches("[A-Z]{3}[0-9]{1}[A-Z]{1}[0-9]{2}")) {
                out.print("<p style='font-family: fantasy;'>Placa válida no modelo Mercosul (ABC1D23).</p>");
            }
            out.print("<p style='font-family: fantasy;'>✅ Carro cadastrado com sucesso!</p>");
        } else {
            out.print("<p>❌ Erro ao cadastrar o carro.</p>");
        }

        ps.close();
        connecta.close();
    } catch (Exception e) {
        if (e.getMessage().contains("Duplicate entry")) {
            out.print("<p style='color: red; font-family: fantasy;'>⚠️ Este carro já está cadastrado.</p>");
        } else {
            out.print("<p style='color: red;'>Erro: " + e.getMessage() + "</p>");
        }
    }
}
            %>
        </body>
        </html>