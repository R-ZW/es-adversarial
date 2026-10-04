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
| ```INARI18```              | Beatriz Roland Machado                | 0000000000  |
| ```CristhianKapelinski```  | Cristhian Eduardo Kapelinski de Avila | 0000000000  |
| ```guimsk```               | Guilherme Muller Schweitzer Klauberg  | 23101015  |
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

As estratégias são alternativas simultâneas para uma única janela de venda; portanto, não representam literalmente cada etapa temporal da seção 3. A1 e D1 descrevem as opções de referência (compra dentro da cota e controle básico). A tentativa inicial de exceder a cota, na rodada 1, serve para revelar a regra e não é uma estratégia adicional da matriz. As adaptações das rodadas seguintes são representadas pelas alternativas A2–A4 e D2–D4.

| Jogador | ID | Estratégia | Descrição |
| --- | --- | --- | --- |
| Revendedor | A1 | Conta única | Compra até quatro ingressos em uma conta, sem contornar a regra. |
| Revendedor | A2 | Várias contas, mesma rede | Controla várias contas e compra até quatro ingressos em cada uma, a partir da mesma rede. |
| Revendedor | A3 | Várias contas, redes distintas | Como A2, mas distribui as tentativas por redes distintas. |
| Revendedor | A4 | Intermediários reais | Recruta pessoas com identidades válidas para comprar em seus nomes e repassar os ingressos. |
| Defensor | D1 | Limite por conta | Aplica apenas o limite de quatro ingressos por conta. |
| Defensor | D2 | Limite e correlação por IP | Correlaciona contas pelo IP e retém compras suspeitas para revisão. |
| Defensor | D3 | Identidade verificada | Exige identidade verificada para comprar ingressos do evento. |
| Defensor | D4 | Ingressos nominais | Além da identidade, vincula o ingresso ao titular, restringe transferências e prevê conferência na entrada. |

### 2.3 Utilidades

Os payoffs são ordinais, de 0 a 10: servem para comparar preferências, não representam dinheiro nem probabilidades. Em cada par, o primeiro valor é do revendedor e o segundo é do defensor. O payoff do revendedor resume o benefício esperado da revenda menos os custos e perdas; o do defensor resume a distribuição do estoque a compradores legítimos menos o atrito e o custo dos controles.

### Premissas que sustentam os valores

- **A1:** rende pouco ao revendedor (no máximo quatro ingressos), mas não custa nada nem gera atrito adicional.
- **A2:** é lucrativa contra D1 e barata, mas é contida por D2, D3 e D4.
- **A3:** custa mais que A2 (gestão de redes distintas), escapa da correlação por IP, mas não das defesas baseadas em identidade ou titularidade.
- **A4:** tem custo de recrutamento e repasse. Pode contornar D1, D2 e D3 por meio de pessoas com identidades válidas, mas perde valor sob D4, que dificulta a transferência.
- **D2:** cria atrito moderado, pois compras legítimas em redes compartilhadas também podem ser retidas. D3 e D4 elevam o atrito com verificações, restrições de transferência e conferência na entrada; D4 é a defesa mais custosa para compradores legítimos.

### 2.4 Matriz de payoffs

Cada célula traz **(revendedor, defensor)**. O valor do revendedor em negrito indica sua melhor resposta na coluna; o valor do defensor em negrito indica sua melhor resposta na linha.

| Revendedor \ Defensor | **D1** Limite por conta | **D2** + correlação por IP | **D3** + identidade | **D4** + ingressos nominais |
| :-- | :--: | :--: | :--: | :--: |
| **A1** Conta única | (1, **8**) | (1, 7) | (1, 5) | (1, 4) |
| **A2** Várias contas, mesma rede | (**8**, 2) | (1, **7**) | (0, 5) | (0, 4) |
| **A3** Várias contas, redes distintas | (7, 2) | (**6**, 3) | (1, **5**) | (0, 4) |
| **A4** Intermediários reais | (5, 3) | (5, 2) | (**5**, 2) | (**2**, **4**) |

**Justificativa dos resultados.** A1 rende 1 ao revendedor em qualquer coluna por limitar a compra à cota. A2 rende 8 sob D1, mas cai para 1 ou 0 quando as contas são retidas ou a identidade é exigida. A3 rende menos que A2 contra D1 (7) por custar mais, mantém retorno 6 contra D2 porque redes distintas reduzem a eficácia da correlação, e cai para 1 ou 0 sob D3 e D4. A4 rende 5 contra D1–D3 porque os intermediários têm identidades válidas, mas o custo de recrutamento reduz o retorno; sob D4, o retorno cai para 2 devido à dificuldade de repasse.

Os payoffs do defensor refletem tanto a parcela de ingressos que permanece acessível a compradores legítimos quanto o atrito dos controles. Por isso, D1 recebe 8 contra A1, mas apenas 2–3 contra estratégias que concentram ingressos; D2 recebe 7 contra A1–A2 e menos contra estratégias que escapam à correlação ou usam intermediários; D3 recebe 5 contra A1–A3 e 2 contra A4; D4 recebe 4 em todas as linhas, representando a contenção adicional da revenda compensada pelo maior custo e atrito para compradores legítimos. Os números são ordinais e ilustrativos, não medições empíricas.

### 2.5 Análise

**Melhores respostas.** Para cada defesa, as melhores respostas do revendedor são: A2 contra D1, A3 contra D2 e A4 contra D3 ou D4. Para cada estratégia do revendedor, as melhores respostas do defensor são: D1 contra A1, D2 contra A2, D3 contra A3 e D4 contra A4.

A cadeia A2 → D2 → A3 → D3 → A4 → D4 ilustra as adaptações estratégicas das rodadas 2 a 4. A rodada 1 é anterior a essa cadeia: nela, a tentativa de exceder a cota revela a regra por conta e motiva o uso de várias contas.

**Equilíbrio de Nash em estratégias puras.** O único é (A4, D4), com payoffs (2, 4). É a única célula em que ambos estão em melhor resposta, e nenhum tem incentivo a desviar sozinho. Isso coincide com o risco residual da rodada 4: mesmo sob a defesa mais forte, o revendedor ainda prefere recrutar intermediários a desistir.

**Dominância.** A4 domina estritamente A1: seus payoffs contra D1–D4 (5, 5, 5, 2) são maiores que os de A1 (1, 1, 1, 1). Isso não significa que A4 seja estratégia dominante, pois A2 é melhor contra D1 e A3 é melhor contra D2. O revendedor, portanto, não tem uma estratégia dominante entre as quatro opções. O defensor também não tem estratégia dominante: sua melhor resposta depende da escolha do revendedor.

**Custo do equilíbrio para o defensor.** No equilíbrio, o defensor recebe 4, contra 8 em (A1, D1). A defesa mais robusta é a que mais pesa sobre os compradores legítimos, que absorvem o atrito da verificação, das restrições de transferência e da espera na entrada. O defensor não consegue eliminar a concentração; ele só a torna menos lucrativa, ao custo de dificultar a compra honesta.

**Sensibilidade.** O equilíbrio depende do payoff do revendedor em (A4, D4). Se ele cair de 2 para 0, por exemplo devido ao custo dos intermediários ou à dificuldade de repasse, A1 passa a ser preferível a A4 contra D4 e deixa de existir equilíbrio em estratégias puras. Seria então necessário analisar estratégias mistas ou rever o conjunto de estratégias; a ausência de equilíbrio puro, por si só, não implica que os jogadores tenham de alternar de forma determinística.

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

[...]
