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
| ```guimsk```               | Guilherme Muller Schweitzer Klauberg  | 0000000000  |
| ```chicosbg```             | Luis Francisco Brum Gomes             | 0000000000  |
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

Consideramos três papéis na interação. Para a análise estratégica, **plataforma e operador formam o lado defensor**: o software aplica as regras de compra, enquanto o operador define e ajusta essas regras. Essa distinção será mantida no diagrama de contexto.

| Ator | Objetivo | Ações ou capacidades | Informações observáveis | Restrições ou custos |
| --- | --- | --- | --- | --- |
| **Comprador legítimo** | Comprar até quatro ingressos para si e seus acompanhantes, sem impedimentos indevidos. | Criar e acessar uma conta; consultar disponibilidade; selecionar e comprar ingressos; cumprir verificações solicitadas. | Preço e disponibilidade exibidos; limite informado; pedidos de verificação; confirmação ou recusa da compra. | Preço dos ingressos; tempo de espera; estoque limitado; esforço e possível exposição de dados nas verificações. |
| **Revendedor** | Obter mais de quatro ingressos para o mesmo evento, reunindo-os para revenda. | Criar ou controlar várias contas; coordenar compras por outras pessoas; variar a origem das conexões; repetir tentativas após recusas. | Regras divulgadas; disponibilidade; solicitações de verificação; aceitação, limitação ou recusa das compras. Não conhece diretamente os critérios internos de detecção. | Capital para comprar ingressos; tempo e custo para manter contas, conexões e intermediários; estoque limitado; risco de bloqueio ou recusa. |
| **Plataforma e operador** | Distribuir os ingressos conforme as regras do evento e manter a compra acessível aos usuários legítimos. | Definir limites; registrar tentativas; relacionar sinais de contas e conexões; solicitar verificações; aceitar ou recusar compras; ajustar controles. | Cadastros, tentativas e resultados de compra; endereços de rede utilizados; resultados das verificações; estoque. Não observa com certeza quem controla cada conta. | Custo operacional das verificações; necessidade de tratar dados pessoais; risco de barrar compradores legítimos ou permitir compras coordenadas. |

## ♟️ 2. Modelo estratégico estático

[...]

## 🔀 3. Modelo estratégico dinâmico

[...]

## ⚠️ 4. Ameaças e riscos

[...]
