<!-- markdownlint-disable MD013 MD033 MD041 -->

# @builder — Estágio 3: Implementação

> **Trilha:** [Kit do Time](../../README.md) › [Agentes de Estágio](../README.md) › **@builder**

**O agente `@builder` executa a especificação produzida no Estágio 2, transformando requisitos EARS em código Java 21 + Spring Boot + Next.js 15, com testes rastreáveis e migrations Flyway.**

| Campo | Valor |
|---|---|
| **Público-alvo** | Developer (protagonista) e Technical Lead, DBA, QA Engineer durante o Estágio 3 |
| **Pré-requisitos** | Passagem de bastão do Estágio 2 com `spec.md`, `plan.md`, `tasks.md` e primeiro incremento priorizado |
| **Tempo estimado** | 15:00–16:10 |
| **Estágio** | Estágio 3 — Implementação |
| **Resultado esperado** | Backend e frontend compilando, testes passando, commits com `Implements REQ-...` |

![Estágio 3](https://img.shields.io/badge/Est%C3%A1gio-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-171717?style=flat-square)
![Postura construtiva](https://img.shields.io/badge/Postura-Construtiva-404040?style=flat-square)

---

## Quando usar

Use este agente quando a especificação já existe e o time precisa construir. O `@builder` não substitui o design: ele executa `spec.md`, `plan.md` e `tasks.md` com código, testes e rastreabilidade.

- **Protagonista:** Developer
- **Suporte forte:** Technical Lead, DBA, QA Engineer e Software Architect
- **Pré-requisito hard gate:** `spec.md`, `plan.md` e `tasks.md` existem e o primeiro incremento está priorizado

---

## O que o agente faz

- Traduz regras Natural/Adabas para Java 21 com rastreabilidade de REQ-ID
- Gera entidades JPA a partir de DDMs Adabas, explicando cada mapeamento
- Cria controllers REST `/api/v1/...` com DTOs, validação Bean Validation e annotations OpenAPI
- Escreve testes JUnit 5 com Testcontainers para regras de negócio críticas
- Gera migrations Flyway idempotentes
- Cria páginas Next.js 15 (App Router) consumindo endpoints REST

---

## O que o agente NÃO faz

- Não escreve código sem REQ-ID referenciado na spec
- Não cria nova arquitetura; segue os ADRs e o plano técnico do Estágio 2
- Não loga CPF, valores de benefício ou qualquer dado sensível
- Não pula testes para acelerar: ao menos o teste mínimo da regra crítica é obrigatório

---

## Entradas

| Entrada | Onde encontrar |
|---|---|
| Especificação da feature | `specs/<NNN>-<feature>/spec.md` |
| Plano técnico | `specs/<NNN>-<feature>/plan.md` |
| Lista de tarefas | `specs/<NNN>-<feature>/tasks.md` |
| ADRs de arquitetura | `02-spec-moderna/` ou `docs/adr/` |
| DDMs mapeados | `01-arqueologia/business-rules-catalog.md` |

---

## Saídas esperadas

| Artefato | Localização |
|---|---|
| Código backend Java 21 | `backend/src/main/java/` |
| Migrations Flyway | `backend/src/main/resources/db/migration/` |
| Testes JUnit 5 | `backend/src/test/java/` |
| Código frontend Next.js | `frontend/` |
| Commits rastreáveis | Mensagem: `Implements REQ-NNN: <descrição curta>` |

---

## Como selecionar o agente no Copilot Chat

- [ ] **Abrir o Copilot Chat** no VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Clicar no seletor de agentes** e selecionar `@builder`.
- [ ] **Abrir `tasks.md`** no editor e identificar a próxima task a implementar.
- [ ] **Colar o prompt de abertura** abaixo e pressionar Enter.

```text
Estou iniciando o Estágio 3 — Implementação.
Temos spec.md, plan.md, tasks.md, ADRs e modelo de dados.
Ajude a implementar a próxima task rastreável para Java 21 + Spring Boot,
PostgreSQL/JPA e Next.js, começando pelos testes quando houver regra de negócio.
```

---

## Prompts de exemplo

| Situação | Prompt útil |
|---|---|
| Entidade JPA | "Gere a entidade a partir deste DDM e explique cada mapeamento." |
| Regra Natural | "Traduza esta regra para Java mantendo nomes claros e teste de equivalência." |
| Controller REST | "Crie controller `/api/v1/...` com DTOs, validação e OpenAPI." |
| Frontend | "Crie página Next.js App Router consumindo este endpoint, sem expor segredo." |
| Testes | "Escreva teste JUnit para REQ-NNN e adicione o comentário de rastreabilidade." |

---

## Definition of Done

- [ ] Backend compila e `mvn test` (ou equivalente) passa sem erros.
- [ ] Frontend compila e `npm test` (ou equivalente) passa quando houver frontend.
- [ ] O primeiro incremento da feature funciona dentro do escopo escolhido.
- [ ] Interface ou endpoint existe somente quando o recorte o exige.
- [ ] Migrations Flyway aplicam sem erro em banco limpo.
- [ ] Testes citam REQ-IDs em comentários inline.
- [ ] Commits mencionam `Implements REQ-...` onde implementam comportamento.

---

## Erros comuns

| Sintoma | Causa | Correção |
|---|---|---|
| Código sem REQ-ID | Task iniciada sem verificar a spec | Volte a `tasks.md` e encontre o requisito correspondente |
| Nova decisão arquitetural no Estágio 3 | Spec incompleta chegou ao builder | Pause, resolva no Estágio 2 via `@architect`, retome |
| Teste pulado por falta de tempo | Pressão de entrega | Escreva ao menos o teste mínimo da regra crítica antes do commit |
| CPF ou valor em log | Falta de atenção à política de dados | Use máscara em logs; nunca logue `cpf`, `valor`, `beneficio` diretamente |

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [@architect](../02-architect/README.md)<br/><sub>Estágio 2: especificação moderna com Spec-Kit.</sub> | [@evolution](../04-evolution/README.md)<br/><sub>Estágio 4: delegar, revisar e registrar o resultado.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
