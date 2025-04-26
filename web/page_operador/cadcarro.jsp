<%@page import="java.sql.*" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <title>Cadastro de carros</title>
        </head>

        <body>
            <style>
                .cad_carro {
                    background-color: rgba(240, 237, 237, 0.801);
                    font-family: fantasy;
                    padding: 20px;
                    border-radius: 20px;
                }

                .botao {
                    background-color: #000099;
                    font-family: fantasy;
                    color: white;
                    border: none;
                    padding: 10px;
                    font-size: 12px;
                    border-radius: 6px;
                    cursor: pointer;
                    margin-left: 150px;
                }

                .botao:hover {
                    transform: scale(1.04);
                }
            </style>
            
            <form action="cadcarro.jsp" method="post">
                
            <h1 style="font-family: fantasy;"> Cadastro do carro </h1>
            
                <div class="cad_carro">
                    <p>
                        <label for="placa">Placa do carro: </label>
                        <input type="text" name="placa" id="placa" maxlength="7" required>
                    </p>
                    <p>
                        <label for="hora_entrada">Hora de Entrada do carro do carro: </label>
                        <input type="time" name="hora_entrada" id="hora_entrada" required>
                    </p>
                    <p>
                    <label for="Data de entrada">Data de Entrada do carro do carro: </label>
                    <input type="date" name="data_entrada" id="data_entrada" required>
                    </p>
                    <input type="submit" class="botao" value="Enviar/Salvar">
                </div>
            </form>


            <% 

        String placa = request.getParameter("placa");

        boolean placaValida = false;

     
        
        if (placa != null) {
            placa = placa.toUpperCase().trim();

            if (placa.length() != 7) {
                out.print("<p style='color: red; font-family: fantasy;'>Erro: A placa deve conter exatamente 7 caracteres.</p>");
            } else if (placa.matches("[A-Z]{3}[0-9]{4}")) {
                out.print("<p style='font-family: fantasy';>Placa válida no modelo antigo (ABC1234).</p>");
                placaValida = true;
                return;
            } else if (placa.matches("[A-Z]{3}[0-9]{1}[A-Z]{1}[0-9]{2}")) {
                out.print("<p style='font-family: fantasy;'>Placa válida no modelo Mercosul (ABC1D23).</p>");
                placaValida = true;
                return;
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
            // Pega a data atual
            java.time.LocalDate dataAtual = java.time.LocalDate.now();

            // Converte a string do formulário para LocalDate
            java.time.LocalDate dataEntrada = java.time.LocalDate.parse(data_entrada);

            // Verifica se a data é anterior à data atual
            if (dataEntrada.isBefore(dataAtual)) {
                out.print("<p style='color:red; font-family: fantasy;'>❌ Erro: A data de entrada não pode ser anterior ao dia de hoje (" + dataAtual + ").</p>");
                dataValida = false;
              
            } else if (dataEntrada.isAfter(dataAtual)){
            out.print("<p style='color:red; font-family: fantasy;'>❌ Erro: A data de entrada não pode ser posterior ao dia de hoje");
                dataValida = false;
                return;
                }
        } catch (Exception e) {
            out.print("<p style='color:red; font-family: fantasy;'>❌ Erro: Data em formato inválido.</p>");
            dataValida = false;
        }
    } else {
        dataValida = false;
    }
        

            
            if ("POST".equalsIgnoreCase(request.getMethod()) && placaValida && dataValida) { //coloca uma condição em que a pagina so vai tentar executar o codigo, apos salvar as informações
            
                String hora_entrada = request.getParameter("hora_entrada"); 
                
                
                    try { 
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conecta;
                        String url="jdbc:mysql://localhost:3306/estacionamento_administrador" ; 
                        String user="root"; 
                        String password="";
                        
                        Connection connecta;
                        connecta = DriverManager.getConnection(url, user, password);
                        
                        String sql  = ("INSERT INTO carro (placa, hora_entrada, data_entrada) VALUES (?, ?, ?)"); PreparedStatement
                        ps = connecta.prepareStatement(sql); 
                        ps.setString(1, placa); 
                        ps.setString(2, hora_entrada); 
                        ps.setString(3,data_entrada);
                        
                        int linhasAfetadas = ps.executeUpdate(); //cria uma variavel para executar o update if 
              
                            if (linhasAfetadas> 0) {
                                out.print("<p style= 'font-family: fantasy;'>✅ Carro cadastrado com sucesso!</p>"); //atalho para pegar emoji no windows == windows + .
                            }
                            else if (linhasAfetadas == 30){
                                out.print("<p>❌ Limite de vagas atingido!!!!.</p>");
                                }

                            else {
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