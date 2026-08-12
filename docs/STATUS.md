<!-- markdownlint-disable MD013 MD033 MD041 -->

# STATUS do Dia — Painel de Progresso

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **STATUS**

**Painel de acompanhamento em tempo real do workshop:** estado dos estágios, passagens e métricas do dia.

![Dashboard](https://img.shields.io/badge/Painel-Status%20do%20dia-171717?style=flat-square) ![Atualização](https://img.shields.io/badge/Atualizar-a%20cada%2030%20min-737373?style=flat-square) ![Responsável](https://img.shields.io/badge/Respons%C3%A1vel-Technical%20Lead-A3A3A3?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Technical Lead (preenche) e facilitador (lê de longe) |
| **Frequência de atualização** | A cada 30 minutos ou a cada transição de estágio |
| **Resultado esperado** | Visão de uma página: o que está pronto, em progresso e bloqueado |

---

## Status global

| Indicador | Estado | Observação |
|---|---|---|
| Time inteiro presente | — | Atualizar: OK ou Parcial |
| Ferramentas locais validadas em 5/5 laptops | — | — |
| Branch `develop` protegida | — | — |
| CI verde em `develop` | — | — |
| Demo ensaiada | — | — |

---

## Progresso dos 4 estágios

| Estágio | Status | Responsável | Início | DoD concluído? | Notas |
|---|---|---|---|---|---|
| **1 — Arqueologia** | Não iniciado | Todos os pares | — | Não | — |
| **2 — Especificação** | Aguardando passagem H1 | Par 2 | — | Não | — |
| **3 — Implementação** | Aguardando passagem H2 | Pares 3 e 4 | — | Não | — |
| **4 — Evolução** | Aguardando passagem H3 | Par 5 | — | Não | — |

**Legenda de status:** Não iniciado · Em progresso · Concluído · Atrasado · Bloqueado

---

## Passagens entre estágios

| Passagem | De para | Quando ocorre | Status |
|---|---|---|---|
| **H1** | Par 1 para Par 2 | Fim do Estágio 1 | Não realizada |
| **H2** | Par 2 para Pares 3 e 4 | Fim do Estágio 2 | Não realizada |
| **H3** | Pares 3 e 4 para Par 5 | Fim do Estágio 3 | Não realizada |

> [!NOTE]
> Cada passagem é uma conversa síncrona de 5 minutos entre o par que entrega e o par que recebe. O cronograma detalhado está em [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md).

---

## Métricas do dia

| Métrica | Meta | Atual |
|---|---|---|
| Fontes legadas confirmadas para o recorte | Todas as REQ-IDs | — |
| Especificação formal (`spec.md`, `plan.md`, `tasks.md`) | 1 feature completa | — |
| Decisões de escopo registradas | Ao menos 1 | — |
| Primeiro incremento implementado | 1 | — |
| Cobertura de testes — backend | Igual ou superior a 70% | — |
| Cobertura de testes — frontend | Igual ou superior a 60% | — |
| Issues criadas para Agent mode | Ao menos 1 | — |
| PRs mergeados em `develop` | — | — |

---

## Alertas ativos

> [!WARNING]
> Preencha abaixo quando um bloqueio ou risco aparecer. O Technical Lead lê em voz alta no próximo stand-up.

- [ ] (nenhum alerta no momento)

---

## Marcos atingidos

Marque conforme conquistar:

- [ ] **Primeira regra de negócio documentada com `Programa Fonte`** — entrada no Estágio 1 concluída.
- [ ] **Primeira especificação EARS escrita** com campo `source_legacy:` preenchido.
- [ ] **Primeira decisão de escopo registrada** e vinculada ao plano.
- [ ] **CI verde no primeiro Pull Request** — pipeline de integração aprovado.
- [ ] **Primeiro endpoint REST funcionando** e visível via Swagger.
- [ ] **Cobertura de testes backend igual ou superior a 70%**.
- [ ] **Primeiro Pull Request do Agent mode revisado e mergeado**.
- [ ] **Terraform plan executado sem erros**.
- [ ] **Demonstração final do SIFAP 2.0 executada com sucesso**.

---

## Registro dos stand-ups (uma frase por par a cada transição)

### H1 — fim do Estágio 1

| Par | Persona | Registro |
|---|---|---|
| Par 1 | Visão (PO + RE) | ___ |
| Par 2 | Arquitetura (EA + SA) | ___ |
| Par 3 | Implementação (TL + Dev) | ___ |
| Par 4 | Qualidade (DBA + QA) | ___ |
| Par 5 | Operações (DevOps + TW) | ___ |

### H2 — fim do Estágio 2

| Par | Registro |
|---|---|
| Par 1 | ___ |
| Par 2 | ___ |
| Par 3 | ___ |
| Par 4 | ___ |
| Par 5 | ___ |

### H3 — fim do Estágio 3

| Par | Registro |
|---|---|
| Par 1 | ___ |
| Par 2 | ___ |
| Par 3 | ___ |
| Par 4 | ___ |
| Par 5 | ___ |

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Script da Demo](demo-script.md)<br/><sub>Roteiro dos 3 minutos finais de demonstração.</sub> | [Checklist do Líder](CHECKLIST-LIDER.md)<br/><sub>Roteiro hora a hora para o Technical Lead.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
