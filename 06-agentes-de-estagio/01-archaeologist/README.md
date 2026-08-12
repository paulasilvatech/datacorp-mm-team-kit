<!-- markdownlint-disable MD013 MD033 MD041 -->

# @archaeologist — Estágio 1: Arqueologia

> **Trilha:** [Kit do Time](../../README.md) › [Agentes de Estágio](../README.md) › **@archaeologist**

**O agente `@archaeologist` guia o time na leitura sistemática do código legado Natural/Adabas, extraindo regras de negócio rastreáveis e mapeando dependências para o recorte do Estágio 2.**

| Campo | Valor |
|---|---|
| **Público-alvo** | Time inteiro durante o Estágio 1 — todos os pares em paralelo |
| **Pré-requisitos** | Pasta `01-arqueologia/legado-sifap/` disponível no workspace |
| **Tempo estimado** | 11:00–12:00 + 13:30–14:00 |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | Catálogo de regras com fonte, DDMs mapeados, perguntas abertas e recorte de feature definido |

![Estágio 1](https://img.shields.io/badge/Est%C3%A1gio-1%20%C2%B7%20Arqueologia-171717?style=flat-square)
![Postura investigativa](https://img.shields.io/badge/Postura-Investigativa-404040?style=flat-square)

---

## Quando usar

Use este agente quando o time estiver lendo o código legado. O `@archaeologist` ajuda a observar, catalogar e formular perguntas. Ele não escreve código moderno nem inventa regras de negócio.

- **Protagonista:** Requirements Engineer
- **Suporte forte:** Tech Writer, Enterprise Architect e DBA
- **Pré-requisito hard gate:** ler os programas Natural atribuídos antes de qualquer especificação

---

## O que o agente faz

- Acompanha a leitura linha a linha de programas `.NSN` e estruturas DDM Adabas
- Identifica entradas, processamento, saídas e regras de negócio em cada programa
- Mapeia dependências entre programas via `CALLNAT`
- Sugere mapeamento de campos DDM para PostgreSQL (MU, PE, DE)
- Registra evidências com caminho e linha de referência
- Aponta perguntas abertas sem inventar respostas

---

## O que o agente NÃO faz

- Não lê o código legado sem que o time abra o arquivo
- Não transforma hipótese em requisito confirmado
- Não sugere arquitetura moderna (isso é papel do `@architect` no Estágio 2)
- Não edita arquivos dentro de `01-arqueologia/legado-sifap/` (somente leitura)

---

## Entradas

| Entrada | Onde encontrar |
|---|---|
| Programas Natural atribuídos | `01-arqueologia/legado-sifap/natural-programs/*.NSN` |
| DDMs Adabas | `01-arqueologia/legado-sifap/adabas-ddms/*.ddm` |
| Checklist de exploração | `01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md` |

---

## Saídas esperadas

| Artefato | Localização |
|---|---|
| Catálogo de regras de negócio | `01-arqueologia/business-rules-catalog.md` |
| Mapa de dependências (Mermaid) | Dentro do catálogo ou em arquivo separado |
| Lista de perguntas abertas | Seção dedicada no catálogo |
| Recorte da feature escolhida | Registrado antes da passagem de bastão às 14:00 |

---

## Como selecionar o agente no Copilot Chat

- [ ] **Abrir o Copilot Chat** no VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Clicar no seletor de agentes** e selecionar `@archaeologist`.
- [ ] **Abrir o primeiro programa Natural atribuído** no editor antes de enviar o primeiro prompt.
- [ ] **Colar o prompt de abertura** abaixo e pressionar Enter.

```text
Estou iniciando o Estágio 1 — Arqueologia.
Temos código Natural/Adabas em 01-arqueologia/legado-sifap/.
Ajude o time a examinar os programas atribuídos e registrar apenas evidências
e perguntas abertas para o recorte que escolheremos. Não infira respostas.
```

---

## Prompts de exemplo

| Situação | Prompt útil |
|---|---|
| Programa Natural desconhecido | "Leia este programa comigo e separe entrada, processamento, saída e regra de negócio." |
| DDM Adabas | "Explique estes campos, marque MU/PE/DE e sugira mapeamento PostgreSQL." |
| Regra ambígua | "Não invente. Registre como mistério, com hipótese, evidência e impacto." |
| CALLNAT | "Mapeie quem chama quem e gere um diagrama Mermaid simples." |

---

## Definition of Done

- [ ] Os programas Natural atribuídos ao par foram lidos integralmente.
- [ ] O catálogo de regras tem `source_legacy:` (arquivo e linha) para cada regra candidata ao recorte.
- [ ] DDMs e dependências foram consultados quando afetam a feature escolhida.
- [ ] Perguntas abertas estão registradas sem resposta inventada.
- [ ] Relatório de descoberta está pronto para a passagem de bastão às 14:00.

---

## Erros comuns

| Sintoma | Causa | Correção |
|---|---|---|
| Copilot responde com generalizações vagas | Prompt sem arquivo aberto no editor | Abra o arquivo `.NSN` e cite o trecho específico no prompt |
| Regra de negócio sem fonte | O time aceitou hipótese como fato | Marque o item como mistério até ter evidência no código |
| Perda de tempo detalhando partes fora do recorte | Nenhuma decisão de escopo foi tomada | Decida a feature fina antes das 12:00 e limite a leitura a ela |
| Edições no legado | Confusão sobre o papel desta etapa | `01-arqueologia/legado-sifap/` é somente leitura |

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Agentes de Estágio — visão geral](../README.md)<br/><sub>Os 4 agentes, cronograma e matriz de responsabilidade.</sub> | [@architect](../02-architect/README.md)<br/><sub>Estágio 2: transformar evidências em especificação moderna.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
