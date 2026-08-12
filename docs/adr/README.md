<!-- markdownlint-disable MD013 MD033 MD041 -->

# Registros de Decisão de Arquitetura (ADRs)

> **Trilha:** [Kit do Time](../../README.md) › [Docs](../README.md) › **ADRs**

**Índice dos registros de decisão arquitetural do time** — uma decisão por arquivo, numerados em sequência.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time, especialmente Software Architect e Technical Lead |
| **Quando criar** | A cada decisão difícil de revisitar depois (mais de 1 hora para desfazer) |
| **Resultado esperado** | Histórico auditável das decisões tomadas sob pressão de tempo |

---

## Por que escrever ADRs

Decisões tomadas sob pressão de tempo são esquecidas. O you do futuro vai redescobrir as mesmas opções e perder horas. Um ADR leva 5 minutos para escrever agora e economiza 50 minutos depois.

## Quando escrever um ADR

Escreva quando:

- Uma decisão for difícil de revisitar depois (mais de 1 hora para desfazer).
- Duas ou mais pessoas do time chegariam a escolhas diferentes por padrão.
- Uma decisão afetar mais de um bounded context ou persona.

Não escreva ADR para: nomes de variáveis, configurações de formatação, versões menores de bibliotecas.

---

## Índice

| ADR | Título | Status | Data |
|---|---|---|---|
| 0000 | [Modelo](0000-template.md) | modelo | 2026-04-29 |

> [!NOTE]
> Adicione novos ADRs nesta tabela conforme criá-los, com status `proposto` primeiro e `aceito` após acordo do time.

---

## Como adicionar um ADR

- [ ] **Abrir issue** usando o [template de issue de ADR](../../.github/ISSUE_TEMPLATE/adr.yml).
- [ ] **Copiar o template** — `0000-template.md` → `NNNN-seu-titulo.md` (próximo número sequencial).
- [ ] **Preencher todas as seções** — contexto, decisão, alternativas, consequências e status.
- [ ] **Abrir pull request** — exigir pelo menos 1 revisão de uma persona de arquitetura.
- [ ] **Fazer merge com status `aceito`** — atualizar este índice.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Documentação transversal](../README.md)<br/><sub>Glossário, sdlc-flow, persona-agent-matrix, runbook.</sub> | [Estágio 2 — Spec Moderna](../../02-spec-moderna/GUIDE.md)<br/><sub>14:00–15:00 — Escrever EARS, ADRs e diagramas C4.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
