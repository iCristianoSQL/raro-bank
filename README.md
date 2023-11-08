# Raro Bank
Projeto prático Trabalho final Raro Academy.

### **`Setup inicial`**

Antes de iniciar a aplicação, recomenda-se a execução da seguinte sequência de comandos:

```bash
rvm use 3.2.1
cd raro_bank
bundle install
rails db:create
rails db:migrate
rails db:seed
sudo service postgresql start
```
-Para iniciar o servidor, recomenda-se a utilização do comando `./bin/dev`, pois ele garante que os assets serão todos devidamente processados.

-Para subir o MailCatcher no terminal, execute o seguinte comando:

```bash
mailcatcher
```
Depois, acesse a porta http://127.0.0.1:1080/.

**Se estiver usando a versão Ruby 3.2.1, pode ser necessário fazer algumas modificações para o mailcatcher funcionar corretamente:**

```bash
gem uninstall mailcatcher
gem uninstall thin
gem install mailcatcher --pre
```
## Descrição do Projeto
O projeto Raro Academy tem como objetivo mudar a vida das pessoas por meio da tecnologia, oferecendo cursos modernos que preparam os alunos para ingressar de forma imersiva no mercado com tecnologias de ponta. A duração média das aulas é de 2 horas, porém o instrutor Paulo frequentemente excede esse tempo de forma desequilibrada. O tempo é valioso e os alunos exigiram um pagamento da Raro Academy pelo tempo excedido pelo professor. Foi então que o Raro Bank surgiu: para cada minuto excedido por Paulo em aula, serão distribuídas Pauloedas para os alunos daquela turma. Essas moedas digitais servirão para adquirir investimentos na plataforma do Raro Bank, permitindo que os alunos rentabilizem suas Pauloedas. Além disso, os alunos também poderão realizar transferências e consultar o extrato. Com as Pauloedas, eles também poderão adquirir WillCrypto e AndradeCoin.

## Requisitos Acessórios
- Recuperação de Senha

  O usuário poderá solicitar a recuperação de senha informando seu e-mail.

  Um e-mail de recuperação será enviado ao usuário contendo as instruções para redefinir sua senha.

  O link de recuperação de senha terá validade de 2 horas.

- Confirmação de Conta

  Após o cadastro, o usuário receberá um e-mail de confirmação de conta.

  O usuário precisará confirmar sua conta clicando no link enviado por e-mail para ativar seu acesso à plataforma.

## Cadastro de Turmas
- Telas de gestão de turmas estarão disponíveis para os usuários administradores.
- Os usuários serão considerados premium quando estiverem associados a uma turma, e terá mais beneficios para fazer investimentos.
## Cadastro de Saldo
- Os usuários administradores poderão adicionar saldo de Pauloeda$ ao final de uma aula que tenha se estendido além do horário normal.
- O depósito de moedas poderá ser feito individualmente para cada usuário ou para toda a turma.
## Consulta de Saldo e Extrato
- Os usuários poderão consultar seu saldo e extrato de transações.
- Cada usuário só terá acesso às suas próprias informações.
O menu lateral sidebar exibirá um pequeno histórico do saldo do usuário.
## Transferências
- O sistema permite realizar transferências de uma conta para outra, identificadas pelo CPF do usuário.
- As transferências são acessíveis apenas pelo remetente e destinatário envolvidos na transação.
  - Cada transferência é identificada por um ID único.
O remetente e o destinatário têm acesso ao path específico da transferência, por exemplo: /transfer/1.
  - Caso um usuário que não esteja envolvido na transferência tente acessar o path, será exibida uma mensagem de erro informando que o acesso é restrito.
- Antes de efetuar a transferência, o remetente receberá um token por e-mail, com 6 caracteres numéricos, que deve ser digitado para confirmar a transferência.
- O token tem duração limitada de 1 minuto.
- As transferências são permitidas apenas entre as 08hs e 18hs dos dias de semana (segunda-feira a sexta-feira). Fora desse horário, as transferências serão programadas para o próximo dia útil, às 08hs da manhã. Feriados não são considerados para o agendamento de transferências.
- Ao iniciar uma transferência, o usuário tem acesso a uma lista de "meus contatos", que contém os dados das contas que já receberam transferências. - Caso a transferência seja destinada a uma nova conta, o usuário pode utilizar a opção "novo contato", que busca um novo usuário na lista de contas existentes no sistema.
- Após a conclusão da transferência, tanto o remetente quanto o destinatário receberão uma notificação por e-mail para confirmar a transação.
## Cadastro de Produtos de Investimentos (Exclusivo para Admins)
- Os usuários administradores poderão cadastrar produtos de investimentos.
- Cada produto terá um nome, data de início e fim de vigência, valor mínimo de investimento e um indexador baseado em índices coletáveis na API do Banco Central.
- Todos os produtos de investimento cadastrados estarão disponíveis no catálogo de investimentos.
- Os produtos poderão ser exclusivos para usuários premium, permitindo apenas que esses usuários visualizem e invistam neles.
- Os usuários alunos (premium) terão acesso a todos os produtos do catálogo, incluindo os registrados como premium.
- Todos os produtos serão de renda fixa, ou seja, o valor do índice aplicado será somado ao montante acumulado pelo investidor a cada dia do período investido.
## Integração com a API do Banco Central
- Será realizada uma consulta à API do Banco Central para buscar os valores dos indicadores econômicos, como SELIC, CDI, IPCA, etc.
- Esses indicadores serão utilizados para calcular os valores parciais do investimento e no momento do saque dos valores.
- Os valores dos indicadores serão obtidos diariamente por meio de um job, que capturará os valores dos indicadores na API e os armazenará no banco de dados.
## Outras características
- Ícones, imagens e telas foram padronizados para oferecer uma experiência intuitiva ao usuário final.
- A lógica do banco de dados está bem estruturada, garantindo um bom desempenho e organização das informações.
- Os investimentos ativos e resgatados do usuário são exibidos de forma detalhada para uma melhor visualização.
- O Raro Bank oferece uma listagem de produtos extremamente intuitiva para o usuário final.
- O administrador tem acesso a um painel administrativo para gerenciar as configurações do sistema.
## Produtos disponíveis no Raro Bank
- Precatórios estaduais
- Recebíveis judiciais
- Precatórios federais
- Cotas de consórcios
- WillCrypto
- AndradeCoin
