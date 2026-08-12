<!-- markdownlint-disable MD013 MD033 MD041 -->

# @architect — Estágio 2: Especificação

> **Trilha:** [Kit do Time](../../README.md) › [Agentes de Estágio](../README.md) › **@architect**

**O agente `@architect` transforma as evidências coletadas no Estágio 1 em uma especificação moderna rastreável, usando o GitHub Spec-Kit para produzir `spec.md`, `plan.md` e `tasks.md`.**

| Campo | Valor |
|---|---|
| **Público-alvo** | Par de arquitetos (Enterprise Architect + Software Architect) durante o Estágio 2 |
| **Pré-requisitos** | Passagem de bastão do Estágio 1 com catálogo de regras e `source_legacy:` disponíveis |
| **Tempo estimado** | 14:00–15:00 |
| **Estágio** | Estágio 2 — Especificação |
| **Resultado esperado** | `spec.md`, `plan.md` e `tasks.md` em `specs/<NNN>-<feature>/`, assinados pelo Product Owner |

![Estágio 2](https://img.shields.io/badge/Est%C3%A1gio-2%20%C2%B7%20Especifica%C3%A7%C3%A3o-171717?style=flat-square)
![Postura analítica](https://img.shields.io/badge/Postura-Anal%C3%ADtica-404040?style=flat-square)

---

## Quando usar

Use este agente quando o time já tem descobertas do legado e precisa transformá-las em especificação moderna. O `@architect` ajuda a delimitar bounded contexts (unidades coesas de domínio com fronteiras explícitas), escrever requisitos no padrão EARS (Easy Approach to Requirements Syntax), registrar ADRs e preparar o terreno para implementação.

- **Protagonista:** Software Architect
- **Suporte forte:** Requirements Engineer, Enterprise Architect, Product Owner e Technical Lead
- **Pré-requisito hard gate:** evidências do Estágio 1 com `source_legacy:` para cada regra

---

## O que o agente faz

- Transforma regras de negócio catalogadas em requisitos EARS com `source_legacy:`
- Compara alternativas de bounded contexts e aponta prós e contras
- Gera ADRs com contexto, opções, decisão, consequências e riscos
- Executa `/speckit.specify`, `/speckit.clarify` e `/speckit.plan` orientado pela spec
- Identifica lacunas na especificação antes de seguir para implementação

---

## O que o agente NÃO faz

- Não aceita requisito sem evidência no legado ou justificativa `[GREENFIELD]`
- Não escreve código de implementação (isso é papel do `@builder`)
- Não preenche campos ou fluxos ambíguos sem resolução explícita
- Não decide escopo sem validação do Product Owner

---

## Entradas

| Entrada | Onde encontrar |
|---|---|
| Catálogo de regras do Estágio 1 | `01-arqueologia/business-rules-catalog.md` |
| Mapa de dependências | Dentro do catálogo ou arquivo Mermaid separado |
| Perguntas abertas | Seção do catálogo |
| Checklist de exploração do legado | `01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md` |

---

## Saídas esperadas

| Artefato | Localização |
|---|---|
| Especificação da feature | `specs/<NNN>-<feature>/spec.md` |
| Plano técnico | `specs/<NNN>-<feature>/plan.md` |
| Lista de tarefas implementáveis | `specs/<NNN>-<feature>/tasks.md` |
| Decisões de escopo de apoio | `02-spec-moderna/` (apenas apoio; não é segunda localização de spec) |

---

## Como selecionar o agente no Copilot Chat

- [ ] **Abrir o Copilot Chat** no VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Clicar no seletor de agentes** e selecionar `@architect`.
- [ ] **Abrir o catálogo de regras** do Estágio 1 no editor.
- [ ] **Colar o prompt de abertura** abaixo e pressionar Enter.

```text
Estou iniciando o Estágio 2 — Especificação.
Temos relatório de descoberta, catálogo de regras, glossário, DDMs e mapa de dependências.
Ajude a transformar a evidência confirmada em `spec.md`, `plan.md` e
`tasks.md` de uma feature fina. Não preencha requisitos ou arquitetura sem
fonte e registre perguntas abertas separadamente.
```

---

## Prompts de exemplo

| Situação | Prompt útil |
|---|---|
| Regra de negócio bruta | "Confirme a fonte desta regra antes de propor uma EARS com `source_legacy:`." |
| Limite de bounded context incerto | "Compare 2 ou 3 bounded contexts possíveis e mostre prós/contras." |
| Decisão arquitetural | "Gere um ADR com contexto, opções, decisão, consequências e riscos." |
| Plano técnico | "Prepare `/speckit.plan` considerando modular monolith, JPA e PostgreSQL." |

---

## Definition of Done

- [ ] `spec.md`, `plan.md` e `tasks.md` existem em `specs/<NNN>-<feature>/`.
- [ ] Todo requisito tem `source_legacy:` apontando para `.NSN` ou `.ddm`, ou `[GREENFIELD]` com justificativa.
- [ ] Decisões de escopo de apoio estão em `02-spec-moderna/`.
- [ ] Escopo revisado e assinado pelo Product Owner na passagem de bastão às 15:00.

---

## Erros comuns

| Sintoma | Causa | Correção |
|---|---|---|
| Requisito sem `source_legacy:` | Regra inferida sem evidência no legado | Volte ao catálogo do Estágio 1 e encontre a linha de referência |
| Arquitetura complexa demais para o tempo | Ambição além do escopo do workshop | Prefira decisões simples, testáveis e implementáveis em 1 hora |
| ADR misturado com opinião solta | Falta de estrutura no registro | Use o template: contexto, opções, decisão, consequências |
| Spec sem critério de aceitação | Requisito não testável | Todo requisito precisa ter ao menos um cenário verificável |

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [@archaeologist](../01-archaeologist/README.md)<br/><sub>Estágio 1: leitura do legado Natural/Adabas.</sub> | [@builder](../03-builder/README.md)<br/><sub>Estágio 3: construir a implementação rastreável.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
