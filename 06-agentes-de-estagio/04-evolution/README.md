<!-- markdownlint-disable MD013 MD033 MD041 -->

# @evolution — Estágio 4: Evolução

> **Trilha:** [Kit do Time](../../README.md) › [Agentes de Estágio](../README.md) › **@evolution**

**O agente `@evolution` orienta o time a transformar o trabalho local do Estágio 3 em entrega revisável: Issues bem escritas para o modo Agent do Copilot, revisão de PR, registro de CI/CD e relatório de experiência.**

| Campo | Valor |
|---|---|
| **Público-alvo** | Technical Lead (protagonista), DevOps Engineer, Tech Writer, Developer e QA Engineer |
| **Pré-requisitos** | Passagem de bastão do Estágio 3 com backend/frontend funcionando e testes relevantes |
| **Tempo estimado** | 16:10–16:50 |
| **Estágio** | Estágio 4 — Evolução |
| **Resultado esperado** | Issue criada ou em rascunho, PR revisado ou próximo passo registrado, relatório de experiência preenchido |

![Estágio 4](https://img.shields.io/badge/Est%C3%A1gio-4%20%C2%B7%20Evolu%C3%A7%C3%A3o-171717?style=flat-square)
![Postura operacional](https://img.shields.io/badge/Postura-Operacional-404040?style=flat-square)

---

## Quando usar

Use este agente quando o protótipo já existe e o time precisa transformar trabalho local em entrega revisável: Issues, PRs, CI/CD, IaC, runbook e relatório final.

- **Protagonista:** Technical Lead
- **Suporte forte:** DevOps Engineer, Tech Writer, Developer e QA Engineer
- **Pré-requisito hard gate:** protótipo com backend/frontend funcionando e testes relevantes

---

## O que o agente faz

- Ajuda a estruturar Issues pequenas e revisáveis para o modo Agent do Copilot
- Orienta a revisão de PRs com foco em bug, risco, regressão e teste faltante
- Cria workflows GitHub Actions para build, test e validação de Terraform
- Converte comandos avulsos em runbook para a equipe de operação
- Produz o relatório de experiência do modo Agent (`agent-experience-report.md`)

---

## O que o agente NÃO faz

- Não delega Issue vaga ao modo Agent: exige contexto, escopo e critérios de aceitação
- Não aprova PR de IA sem revisão humana explícita
- Não cria features novas no Estágio 4 (coloca no backlog)
- Não esconde pendências: documenta risco e registra próximo passo

---

## Entradas

| Entrada | Onde encontrar |
|---|---|
| Backend/frontend do Estágio 3 | `backend/`, `frontend/` |
| Pendências conhecidas | Seção de notas da passagem de bastão do Estágio 3 |
| `spec.md` da feature | `specs/<NNN>-<feature>/spec.md` |
| ADRs e plano técnico | `02-spec-moderna/` ou `docs/adr/` |

---

## Saídas esperadas

| Artefato | Localização |
|---|---|
| Issue para o modo Agent | GitHub Issues do repositório |
| Revisão de PR (se disponível) | GitHub Pull Requests |
| Workflow CI/CD (se pertinente) | `.github/workflows/` |
| Runbook (se pertinente) | `docs/runbook/` |
| Relatório de experiência do Agent | `docs/agent-experience-report.md` |

---

## Como selecionar o agente no Copilot Chat

- [ ] **Abrir o Copilot Chat** no VS Code (`Ctrl+Alt+I` / `Cmd+Alt+I`).
- [ ] **Clicar no seletor de agentes** e selecionar `@evolution`.
- [ ] **Abrir a lista de pendências** do Estágio 3 no editor.
- [ ] **Colar o prompt de abertura** abaixo e pressionar Enter.

```text
Estou iniciando o Estágio 4 — Evolução.
Temos um protótipo com backend, frontend e testes.
Ajude a revisar uma Issue pequena para o Copilot Agent e a registrar o
resultado da delegação. Não invente requisitos, arquitetura ou critérios.
```

---

## Prompts de exemplo

| Situação | Prompt útil |
|---|---|
| Issue para o modo Agent | "Escreva uma Issue pequena com contexto, arquivos relevantes, critérios de aceitação e fora de escopo." |
| Revisão de PR | "Revise este PR priorizando bug, risco, regressão e teste faltante." |
| CI/CD | "Crie workflow GitHub Actions para build, test e validação de Terraform." |
| Runbook | "Transforme estes comandos em runbook para pessoa de operação iniciante." |
| Relatório final | "Escreva o `agent-experience-report` com o que funcionou, o que falhou e o que aprendemos." |

---

## Definition of Done

- [ ] Uma Issue pequena foi criada ou ficou como rascunho revisável com contexto, escopo e critérios de aceitação.
- [ ] Um PR disponível recebeu revisão humana; se não há PR, o próximo passo está documentado.
- [ ] Situação de CI/IaC foi registrada sem criar infraestrutura apenas por meta.
- [ ] Relatório de experiência do modo Agent está preenchido.

---

## Erros comuns

| Sintoma | Causa | Correção |
|---|---|---|
| Modo Agent entrega resultado fora do escopo | Issue vaga sem critérios explícitos | Reescreva a Issue com contexto, arquivos relevantes e fora de escopo |
| PR de IA mergeado sem revisão | Confiança excessiva no resultado do Agent | Revise exatamente como revisaria um PR humano |
| Feature nova surgindo no final | Falta de controle de escopo | Registre no backlog; não implemente no Estágio 4 |
| Pendência escondida para não afetar a demo | Medo de julgamento | Documente o risco e o workaround; transparência é o objetivo |

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [@builder](../03-builder/README.md)<br/><sub>Estágio 3: construir a implementação rastreável.</sub> | [Agentes de Estágio — visão geral](../README.md)<br/><sub>Visão dos 4 agentes e cronograma do workshop.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
