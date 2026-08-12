<!-- markdownlint-disable MD013 MD033 MD041 -->

# Estágio 1 — Arqueologia

> **Trilha:** [Kit do Time](../README.md) › **Estágio 1 — Arqueologia**

**Visão geral do Estágio 1.** Leia esta página antes de abrir o GUIDE; ela apresenta o objetivo, os artefatos esperados e os participantes.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todos os 5 pares do time |
| **Pré-requisitos** | Nenhum — este é o ponto de partida |
| **Tempo estimado** | 90 min (11:00–12:00 + 13:30–14:00) |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | Catálogo de regras, mapa de dependências, glossário e relatório de descoberta |

![Estágio 1](https://img.shields.io/badge/Est%C3%A1gio-1%20%C2%B7%20Arqueologia-171717?style=flat-square) ![Portão obrigatório](https://img.shields.io/badge/Port%C3%A3o-Hard%20Gate-404040?style=flat-square) ![Pares todos em paralelo](https://img.shields.io/badge/Pares-Todos%20em%20paralelo-737373?style=flat-square)

> [!IMPORTANT]
> **Leia primeiro:** [`LEGACY-EXPLORATION-CHECKLIST.md`](LEGACY-EXPLORATION-CHECKLIST.md) — portão obrigatório antes de iniciar o Estágio 2. Nenhum requisito EARS é aceito sem rastreabilidade ao código legado.

---

## O que é o Estágio 1

**Arqueologia de software** é a prática de extrair conhecimento de sistemas legados por meio de leitura sistemática do código-fonte, sem modificá-lo. No contexto deste workshop, a arqueologia tem um objetivo preciso: coletar evidências suficientes para escrever requisitos rastreáveis no Estágio 2.

O SIFAP tem 29 anos de operação. A maior parte do conhecimento sobre suas regras de negócio está no código Natural, não em documentação. Sem ler o código, a equipe escreveria especificações baseadas em suposição — o que o CI rejeita por exigir `source_legacy:` válido.

---

## Onde isso encaixa no fluxo do workshop

![Linha do tempo do dia: pré-evento, 4 estágios e demo, com as três passagens H1, H2, H3](../assets/timeline-stages.svg)

---

## Quem trabalha aqui

Todos os 5 pares trabalham em paralelo, cada um responsável por 3 programas Natural. O Par 1 (Visão) lidera a síntese ao final do estágio. Veja [`GUIDE.md`](GUIDE.md) para a divisão completa.

---

## Artefatos do Estágio 1

| Arquivo | Propósito |
|---|---|
| [`LEGACY-EXPLORATION-CHECKLIST.md`](LEGACY-EXPLORATION-CHECKLIST.md) | **Portão obrigatório.** Posse de programa por par e critérios de conclusão antes do Estágio 2. |
| [`GUIDE.md`](GUIDE.md) | Guia passo a passo com roteiro cronometrado. |
| [`glossary.md`](glossary.md) | Glossário de termos e abreviações do domínio SIFAP. |
| [`business-rules-catalog.md`](business-rules-catalog.md) | Catálogo de regras de negócio extraídas com `Programa Fonte` obrigatório. |
| [`dependency-map.md`](dependency-map.md) | Mapa de dependências entre programas e DDMs. |
| [`discovery-report.md`](discovery-report.md) | Relatório de descoberta — consolida as evidências do estágio. |
| [`mysteries-checklist.md`](mysteries-checklist.md) | Checklist de rastreabilidade para perguntas em aberto. |
| [`mysteries-found.md`](mysteries-found.md) | Registro detalhado de perguntas em aberto com evidência e responsável. |

O código legado está em [`legado-sifap/`](legado-sifap/) (compartilhado pelo kit).

Quem quiser executar o legado, em vez de apenas lê-lo, pode provisionar o lab opcional em [`infra/adabas-natural-lab/`](../infra/adabas-natural-lab/README.md): uma VM Azure com Adabas e Natural Community Edition. É trilha avançada, exige assinatura Azure própria e nenhum artefato do Estágio 1 depende dela.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Kit do Time](../README.md)<br/><sub>Hub principal do repositório.</sub> | [GUIDE do Estágio 1](GUIDE.md)<br/><sub>Roteiro cronometrado de 90 min para ler o legado e catalogar regras.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
