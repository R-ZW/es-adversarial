# Engenharia de Software Adversarial - Sistema de compra de ingressos

Análise de uma plataforma hipotética de venda de ingressos para diferentes eventos. O trabalho recorta a compra em um evento de alta demanda e examina como um revendedor pode superar o limite de quatro ingressos por conta, além das respostas da plataforma e seus efeitos sobre compradores legítimos.

## 🆔 Identificação 

> **Nome do sistema:** ``ScalperObliterator3000`` - Aplicativo de compra de ingressos <br>
> **Repositório:** [https://github.com/R-ZW/tc-seminario](https://github.com/R-ZW/tc-seminario)<br>
> **Vídeo de apresentação T1:** [link](#) <br>
> **Vídeo de apresentação T2:** [link](#) <br>
> **Justificativa:** A venda de ingressos em eventos de alta demanda expõe um conflito concreto entre distribuição justa e aquisição em escala para revenda. O limite por conta pode ser contornado com múltiplas contas; verificações adicionais provocam novas adaptações do revendedor e podem dificultar compras legítimas. O recorte permite analisar esse ciclo e é viável para uma implementação simulada no Trabalho 2. 

### 👥 Integrantes:

| Username do GitHub         | Nome Completo                         | Matrícula   |
|----------------------------|---------------------------------------|-------------|
| ```INARI18```              | Beatriz Roland Machado                | 2310101585  |
| ```CristhianKapelinski```  | Cristhian Eduardo Kapelinski de Avila | 0000000000  |
| ```guimsk```               | Guilherme Muller Schweitzer Klauberg  | 2310101588  |
| ```chicosbg```             | Luis Francisco Brum Gomes             | 2310100558  |
| ```R-ZW```                 | Reinaldo Zimmer Wendt                 | 2310100642  |

---

## Sumário

### 1. [📋 Descrição do sistema adversarial](#)
### 2. [♟️ Modelo estratégico estático](#)
### 3. [🔀 Modelo estratégico dinâmico](#)
### 4. [⚠️ Ameaças e riscos](#)

---

## 📋 1. Descrição do sistema adversarial

### 1.1 Sistema e recorte da interação

O ``ScalperObliterator3000`` é uma plataforma hipotética de venda online de ingressos para diferentes eventos. Pessoas interessadas podem criar uma conta, consultar a disponibilidade, selecionar ingressos e concluir uma compra. Após a confirmação, a plataforma emite ingressos digitais. Para esta análise, consideramos **a venda de ingressos de um evento específico de alta demanda**, com quantidade limitada de ingressos e sem assentos numerados. Nesse evento, a regra inicial permite comprar **até quatro ingressos por conta**, com a intenção de distribuir as oportunidades de compra entre mais pessoas.

O recorte deste trabalho é a **aquisição de ingressos acima desse limite por um mesmo interessado**, que pode controlar ou coordenar várias contas para reunir ingressos destinados à revenda. Analisaremos como a plataforma decide aceitar, limitar ou submeter compras a verificações adicionais, quais respostas o interessado consegue observar, e como ambos podem ajustar suas decisões nas tentativas seguintes. Compradores legítimos também participam desse cenário, pois medidas contra compras coordenadas podem dificultar o acesso de pessoas que seguem as regras.

A análise se concentra no processo de compra, da criação ou utilização de uma conta até a emissão do ingresso. A revenda fora da plataforma, o processamento real de pagamentos e a operação de entrada no evento não serão modelados como fluxos principais. A validação do ingresso na entrada poderá ser considerada como controle posterior, caso ajude a avaliar os efeitos e limites das defesas adotadas durante a compra.

> - **Sistema:** plataforma de venda de ingressos para diferentes eventos.
> - **Recorte:** compra em um evento de alta demanda, limitada a quatro ingressos por conta.
> - **Conflito:** um revendedor coordena contas para superar o limite, a plataforma busca preservar o acesso dos compradores legítimos.

### 1.2 Atores, objetivos e capacidades

Consideramos três papéis na interação. Para a análise estratégica, **a plataforma e seu administrador formam o lado defensor**: o software aplica as regras de compra, enquanto o administrador da plataforma define e ajusta essas regras. Essa distinção será mantida no diagrama de contexto.

| Ator | Objetivo | Ações ou capacidades | Informações observáveis | Restrições ou custos |
| --- | --- | --- | --- | --- |
| **Comprador legítimo** | Comprar até quatro ingressos para si e seus acompanhantes, sem impedimentos indevidos. | Criar e acessar uma conta; consultar disponibilidade; selecionar e comprar ingressos; cumprir verificações solicitadas. | Preço e disponibilidade exibidos; limite informado; pedidos de verificação; confirmação ou recusa da compra. | Preço dos ingressos; tempo de espera; estoque limitado; esforço e possível exposição de dados nas verificações. |
| **Revendedor** | Obter mais de quatro ingressos para o mesmo evento, reunindo-os para revenda. | Criar ou controlar várias contas; coordenar compras por outras pessoas; variar a origem das conexões; repetir tentativas após recusas. | Regras divulgadas; disponibilidade; solicitações de verificação; aceitação, limitação ou recusa das compras. Não conhece diretamente os critérios internos de detecção. | Capital para comprar ingressos; tempo e custo para manter contas, conexões e intermediários; estoque limitado; risco de bloqueio ou recusa. |
| **Plataforma e administrador** | Distribuir os ingressos conforme as regras do evento e manter a compra acessível aos usuários legítimos. | Definir limites; registrar tentativas; relacionar sinais de contas e conexões; solicitar verificações; aceitar ou recusar compras; ajustar controles. | Cadastros, tentativas e resultados de compra; endereços de rede utilizados; resultados das verificações; estoque. Não observa com certeza quem controla cada conta. | Custo operacional das verificações; necessidade de tratar dados pessoais; risco de barrar compradores legítimos ou permitir compras coordenadas. |

### 1.3 Regras e pressupostos

A propriedade a preservar é a **distribuição justa do estoque de ingressos**, sem impor obstáculos desproporcionais aos compradores legítimos. A **regra inicial** limita a quatro o total de ingressos comprados por uma mesma conta para o evento analisado, somando compras anteriores dessa conta. Ela não identifica, por si só, quem controla contas diferentes ou quem receberá os ingressos.

Para reconhecer compras possivelmente relacionadas, a plataforma pode observar **conta utilizada, horário das tentativas, quantidade solicitada e endereço IP**. Nas rodadas seguintes, o administrador pode usar esses sinais para solicitar verificações adicionais, inclusive de identidade. Esses dados são **indícios**, não provas de que duas compras pertencem à mesma pessoa; o limite por conta é o único controle obrigatório no cenário inicial.

| ID | Pressuposto | Como pode falhar | Consequência para o sistema |
| --- | --- | --- | --- |
| **P1** | Cada interessado usa uma única conta para comprar ingressos do evento. | Um revendedor cria ou controla várias contas e compra até quatro ingressos em cada uma. | O limite é respeitado em cada conta, mas um mesmo interessado acumula mais de quatro ingressos. |
| **P2** | O endereço IP ajuda a reconhecer compras coordenadas sem confundir compradores diferentes. | O revendedor muda de rede ou usa VPN; compradores legítimos compartilham uma rede doméstica ou pública. | Compras relacionadas podem passar despercebidas, enquanto compras legítimas podem ser sinalizadas. |
| **P3** | Verificar a identidade de cada comprador impede que uma pessoa concentre os ingressos. | O revendedor recruta pessoas reais para comprar até quatro ingressos cada uma e repassá-los depois. | As identidades são distintas e válidas, mas os ingressos continuam concentrados pelo mesmo interessado. |

> - **Regra inicial:** até quatro ingressos por conta no evento analisado.
> - **Sinais possíveis:** conta, horário, quantidade, IP e, se exigida, identidade verificada.
> - **Limite dos controles:** contas, redes e identidades distintas não garantem compradores independentes.

### 1.4 Diagrama de contexto

O diagrama de contexto segue o [modelo C4](https://c4model.com/diagrams/system-context) e foi definido em [Structurizr DSL](https://docs.structurizr.com/dsl/cookbook/system-context-view/): o **ScalperObliterator3000** é o sistema em análise; comprador legítimo, revendedor e administrador são pessoas que interagem com ele. O serviço de pagamento aparece apenas como dependência externa da compra, sem detalhar seu processamento. A verificação de identidade é uma integração **eventual**, acionada somente se esse controle for adotado em uma rodada posterior.

![Diagrama C4 de contexto do ScalperObliterator3000](diagramas/contexto.png)

[Arquivo-fonte editável do diagrama em Structurizr DSL](diagramas/contexto.dsl).

### 1.5 Por que a interação é adversarial

A interação é adversarial porque o revendedor tenta **deliberadamente contornar o limite de quatro ingressos por conta** para concentrar ingressos e revendê-los, enquanto a plataforma busca distribuí-los de forma justa sem prejudicar compradores legítimos. Ao observar compras aceitas, recusas ou pedidos de verificação, o revendedor pode mudar de conta, rede ou comprador intermediário; a plataforma, por sua vez, observa as tentativas e ajusta seus controles. Portanto, o conflito não decorre de um erro isolado: os participantes têm objetivos diferentes e adaptam suas decisões às respostas um do outro.

### ♟️ 2. Modelo estratégico estático

### 2.1 Jogadores, informação e recorte

O modelo estático fixa uma única janela de venda do evento de alta demanda e analisa uma decisão simultânea entre dois jogadores: o revendedor e o defensor (plataforma e administrador, conforme a seção 1.2). Cada um escolhe sua estratégia sem observar a escolha do outro. É um jogo de informação imperfeita: a plataforma não sabe com certeza quem controla cada conta (P1 a P3), e o revendedor não conhece os critérios internos de detecção.

O comprador legítimo não é jogador estratégico, porque segue as regras e não adapta seu comportamento ao conflito. Seus custos entram na utilidade do defensor como atrito: demora, recusas indevidas e exposição de dados.

### 2.2 Estratégias

As estratégias correspondem aos meios das quatro rodadas da seção 3, tratados aqui como alternativas simultâneas.

### Revendedor (ID: Descrição)

A1:	Conta única	Compra até o limite de quatro ingressos em uma só conta, sem tentar contornar a regra.

A2:	Várias contas, mesma rede	Controla várias contas e compra quatro ingressos em cada uma, a partir do mesmo IP.

A3:	Várias contas, redes distintas	Igual a A2, mas distribui as tentativas por VPN ou redes diferentes.

A4:	Intermediários reais	Recruta pessoas com identidades válidas para comprar em seus nomes e repassar os ingressos.

### Defensor (ID: Descrição)

D1: Limite por conta	Aplica apenas o limite de quatro ingressos por conta.

D2: Limite + correlação por IP	Correlaciona contas pelo IP e retém compras suspeitas para revisão.

D3: Identidade verificada	Exige identidade verificada para comprar ingressos do evento.

D4: Ingressos nominais	Além da identidade, vincula o ingresso ao titular, restringe transferências e prevê conferência na entrada.

### 2.3 Utilidades

As utilidades usam uma escala ordinal de 0 a 10, que só compara resultados e não mede valores monetários.

Revendedor: receita esperada da revenda, menos o custo de operar o esquema (contas, VPN, recrutamento de intermediários) e menos as perdas por retenção ou recusa.
Defensor: parcela do estoque que chega a compradores legítimos, menos o atrito imposto a eles e o custo operacional dos controles.

###  Premissas que sustentam os valores:

A1: rende pouco ao revendedor (só quatro ingressos), mas não custa nada nem gera atrito.

A2: é lucrativa contra D1 e barata, mas é neutralizada por D2, D3 e D4.

A3: custa mais que A2 (VPN, gestão de redes). Escapa de D2, mas não de D3 e D4, que não dependem do IP.

A4: tem custo fixo de recrutamento e repasse. Atravessa D1, D2 e D3 porque as identidades são válidas, e perde valor sob D4 porque a revenda fica difícil.

D2: cria atrito moderado (redes compartilhadas podem ser retidas). D3 e D4 criam atrito crescente (tempo, dados, restrição de transferência e conferência na entrada), e D4 é a defesa mais custosa para quem compra legitimamente.

### 2.4 Matriz de payoffs

Cada célula traz **(revendedor, defensor)**. Os valores em **negrito** marcam a melhor resposta do jogador naquela linha ou coluna.

| Revendedor \ Defensor | **D1** Limite por conta | **D2** + correlação por IP | **D3** + identidade | **D4** + ingressos nominais |
| :-- | :--: | :--: | :--: | :--: |
| **A1** Conta única | (1, **8**) | (1, 7) | (1, 5) | (1, 4) |
| **A2** Várias contas, mesma rede | (**8**, 2) | (1, **7**) | (0, 5) | (0, 4) |
| **A3** Várias contas, redes distintas | (7, 2) | (**6**, 3) | (1, **5**) | (0, 4) |
| **A4** Intermediários reais | (5, 3) | (5, 2) | (**5**, 2) | (**2**, **4**) |

### 2.5 Análise

Melhores respostas. Cada defesa tem uma melhor resposta do revendedor, e vice-versa:

Contra D1, o revendedor responde com A2; contra D2, com A3; contra D3 e D4, com A4.
Contra A1, o defensor responde com D1; contra A2, com D2; contra A3, com D3; contra A4, com D4.

A sequência A2 → D2 → A3 → D3 → A4 → D4 reproduz as quatro rodadas da seção 3, ou seja, o ciclo adaptativo aparece aqui como a cadeia de melhores respostas.

Equilíbrio de Nash em estratégias puras. O único é (A4, D4), com payoffs (2, 4). É a única célula em que ambos estão em melhor resposta, e nenhum tem incentivo a desviar sozinho. Isso coincide com o risco residual da rodada 4: mesmo sob a defesa mais forte, o revendedor ainda prefere recrutar intermediários a desistir.

Dominância. A4 domina estritamente A1 (5, 5, 5, 2 contra 1, 1, 1, 1). Neste modelo, "cumprir a regra" nunca é a melhor escolha de um revendedor. As demais estratégias do revendedor não se dominam entre si, porque cada uma é a melhor resposta a alguma defesa.

Custo do equilíbrio para o defensor. No equilíbrio, o defensor recebe 4, contra 8 em (A1, D1). A defesa mais robusta é a que mais pesa sobre os compradores legítimos, que absorvem o atrito da verificação, das restrições de transferência e da espera na entrada. O defensor não consegue eliminar a concentração; ele só a torna menos lucrativa, ao custo de dificultar a compra honesta.

Sensibilidade. O equilíbrio depende do payoff do revendedor em (A4, D4). Se ele cair abaixo de 1, por exemplo com fiscalização forte na entrada ou intermediários caros, A1 passa a ser preferível a A4 e o equilíbrio em estratégias puras deixa de existir. Nesse caso, os jogadores teriam de alternar entre estratégias, o que dá sentido ao modelo dinâmico.

### 2.6 Limitações

Os valores são ordinais e ilustrativos. As conclusões qualitativas (cadeia de melhores respostas, equilíbrio em A4/D4, custo para o legítimo) dependem da ordem entre os payoffs, e não dos números exatos. No Trabalho 2, a simulação pode calibrá-los.
O jogo é de uma rodada: não captura aprendizado, reputação nem a descoberta gradual dos critérios de detecção, tratados na seção 3.
Não há estratégias mistas nem crença do defensor sobre a proporção de revendedores, e os erros de classificação (P2) entram apenas indiretamente, via atrito.
O comprador legítimo é modelado só pelo atrito e não escolhe estratégia.

## 🔀 3. Modelo estratégico dinâmico

### 3.1 Rodadas adversariais

As rodadas partem do limite inicial de quatro ingressos por conta. Em cada uma, o revendedor mantém o objetivo de concentrar ingressos, mas altera o meio usado após observar a resposta da plataforma.

| Rodada | Ação do participante | Resposta do sistema ou defensor | O que se torna observável? | Adaptação para a rodada seguinte |
| :--- | :--- | :--- | :--- | :--- |
| **1 — Limite por conta** | O revendedor tenta comprar mais de quatro ingressos para o mesmo evento usando uma conta. | A plataforma aplica o limite de quatro ingressos por conta e recusa o excedente. | A recusa revela que a cota é aplicada à conta, inclusive quando há compras anteriores. | O revendedor cria ou controla várias contas e compra até quatro ingressos em cada uma. |
| **2 — Correlação por IP** | O revendedor usa contas diferentes para comprar mais ingressos do mesmo evento. | Ao identificar tentativas vindas do mesmo IP, a plataforma correlaciona as contas e retém temporariamente essas compras para revisão, sem tratar o IP como prova de identidade. | O revendedor percebe que compras no mesmo IP ficam retidas. Compradores legítimos que compartilham uma rede também podem sofrer atrasos. | O revendedor distribui as tentativas por VPN ou por redes diferentes. |
| **3 — Verificação de identidade** | O revendedor continua as compras por contas e IPs diferentes. | Ao reconhecer que o IP não basta para limitar compras coordenadas, o administrador passa a exigir uma identidade verificada para comprar ingressos desse evento. | Fica visível que mudar de IP já não elimina a exigência. Compradores legítimos passam a gastar mais tempo e fornecer dados para concluir a compra. | O revendedor recruta pessoas reais para comprar em seus próprios nomes e depois repassar os ingressos. |
| **4 — Ingressos nominais** | O revendedor coordena compras feitas por intermediários com identidades válidas. | A plataforma vincula cada ingresso ao titular identificado, restringe a transferência e prevê a conferência do titular na entrada como controle posterior. | Os ingressos são emitidos, mas seu repasse se torna mais difícil. Compradores legítimos também podem enfrentar restrições de transferência e demora na entrada. | O revendedor testa as transferências permitidas ou tenta coordenar compras já em nome dos destinatários finais; permanece risco residual. |

### 3.2 Diagrama do ciclo adaptativo

O fluxograma em raias acompanha as quatro rodadas da tabela. As respostas da plataforma revelam informações ao revendedor; as tentativas observadas também orientam as mudanças do lado defensor. As notas indicam efeitos das defesas sobre compradores legítimos. A conferência na entrada aparece apenas como controle posterior, fora do fluxo principal de compra.

![Fluxograma em raias do ciclo adaptativo entre revendedor e plataforma](diagramas/ciclo-adaptativo.png)

[Arquivo-fonte editável do diagrama em PlantUML](diagramas/src/ciclo-adaptativo.puml).

## ⚠️ 4. Ameaças e riscos

### 4.1 Pontos de exploração

Os pontos de exploração foram extraídos do fluxo de compra (seção 1.1), dos pressupostos P1 a P3 (seção 1.3) e das rodadas da seção 3. Cada um é uma interface, regra ou componente da plataforma que o revendedor usa para atingir o mesmo objetivo: concentrar ingressos acima da cota.

| ID | Ponto de exploração | Componente ou fluxo | Fraqueza explorada | Rodada em que aparece |
| --- | --- | --- | --- | --- |
| **E1** | Criação de contas | Cadastro de contas | Criar uma conta nova não custa quase nada ao revendedor (P1). | 1 e 2 |
| **E2** | Regra de quatro ingressos por conta | Compra e checkout | A cota é contada por conta, não por pessoa (P1). | 1 e 2 |
| **E3** | Correlação de contas pelo IP | Registro de tentativas | O IP é um indício fraco: muda com VPN e é compartilhado por compradores legítimos (P2). | 2 e 3 |
| **E4** | Respostas observáveis da compra | Aceite, retenção, recusa e pedido de verificação | Cada resposta dá pistas de qual sinal o sistema usa e de qual variação passa, embora o revendedor não conheça diretamente os critérios internos (seção 1.2). | Todas |
| **E5** | Verificação de identidade | Integração eventual com o serviço externo | Uma identidade válida não prova que o comprador age por conta própria (P3). | 3 e 4 |
| **E6** | Titularidade e transferência do ingresso | Emissão de ingresso nominal e conferência na entrada | As transferências permitidas e a conferência na entrada podem ser usadas para repassar ingressos. | 4 |

### 4.2 Diagrama de superfície de ataque

O diagrama segue o fluxo de compra da esquerda para a direita, do cadastro à emissão do ingresso, e mostra os sistemas externos envolvidos. Componentes com borda vermelha são pontos de exploração, com a fraqueza correspondente (E1 a E6) escrita no próprio componente. Setas laranja são ações do revendedor; a seta laranja tracejada que volta da resposta da compra representa o canal de observação usado em todas as rodadas. O painel do administrador aplica os controles ajustados nas rodadas da seção 3: o limite na compra, os sinais da correlação e a emissão de ingressos nominais. Elementos cinza tracejados são controles eventuais (verificação de identidade) ou posteriores à compra (conferência na entrada).

![Diagrama de superfície de ataque do ScalperObliterator3000](diagramas/superficie-de-ataque.png)

[Arquivo-fonte editável do diagrama em SVG](diagramas/src/superficie-de-ataque.svg).

### 4.3 Cenários de ameaça

Os cenários usam o prefixo **AM** para não serem confundidos com as estratégias A1 a A4 do revendedor na seção 2.

- **AM1:** Um **revendedor** pode **comprar quatro ingressos em cada uma de várias contas que controla** por meio do **cadastro de contas e da regra de limite por conta (E1, E2)**, aproveitando **o pressuposto de que cada interessado usa uma única conta (P1)**, causando **a concentração de ingressos acima da cota** sobre **a distribuição justa do estoque**.
- **AM2:** Um **revendedor** pode **distribuir as compras de suas contas por VPN ou redes diferentes** por meio da **correlação por IP (E3)**, aproveitando **o pressuposto de que o IP revela compras coordenadas (P2)**, causando **compras coordenadas não detectadas enquanto compradores legítimos em redes compartilhadas são retidos** sobre **a distribuição justa e o acesso dos compradores legítimos**.
- **AM3:** Um **revendedor** pode **recrutar intermediários reais para comprar em seus próprios nomes e repassar os ingressos** por meio da **verificação de identidade (E5)**, aproveitando **o pressuposto de que identidade verificada impede a concentração (P3)**, causando **concentração com identidades válidas, difícil de distinguir de compras legítimas** sobre **a distribuição justa do estoque**.
- **AM4:** Um **revendedor** pode **fazer compras de teste e comparar aceites, retenções e recusas** por meio das **respostas observáveis da compra (E4)**, aproveitando **o fato de que respostas detalhadas dão pistas dos critérios internos de detecção**, causando **a adaptação mais rápida e barata às defesas** sobre **a eficácia dos controles da plataforma**.
- **AM5:** Um **revendedor** pode **repassar ingressos nominais por transferências permitidas ou comprar já em nome do destinatário final** por meio da **titularidade e transferência do ingresso (E6)**, aproveitando **o pressuposto de que o titular registrado é quem vai ao evento**, causando **a revenda de ingressos que passaram por todos os controles da compra** sobre **a distribuição justa e a confiança no ingresso nominal**.