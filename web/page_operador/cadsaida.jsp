
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
         <style>
                .saida_carro {
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
                    margin-top: 15px;
                    margin-left: 150px;
                }

                .botao:hover {
                    transform: scale(1.04);
                }
            </style>
       
            <form method="post"> <!-- não precisa do action por causa que é no proprio arquivo jsp -->
        <h1 style="font-family: fantasy;"> Cadastro saida do carro </h1>
        
            
            <div class="saida_carro">
                    <p>
                        <label for="placa">Placa do carro: </label>
                        <input type="text" name="placa" id="placa" maxlength="7" required>
                    </p>
                    <p>
                        <label for="Hora de Saida do carro">Hora de Saida do carro: </label>
                        <input type="time" name="hora_saida" id="hora_entrada" required>
                    </p>
                    <p>
                    <label for="Data de saida">Data de saida do carro do carro: </label>
                    <input type="date" name="data_saida" id="data_saida" required>
                    </p>
                    <p>
                        <label for="Preço total">Preço a se pagar: </label>
                    </p>
                    <p>
                    <label for="Forma de pagamento">Forma de pagamento:</label>
                    <select name="pagamento" id="pagamento">
                      <option value="Dinheiro">Dinheiro</option>
                      <option value="Debito">Debito</option>
                    </p>
                    <p>
                    <input type="submit" class="botao" value="Enviar/Salvar">
                    </p>
                </div>
            
        </form>
        <%   
       %>
            
            
            
    </body>
</html>
