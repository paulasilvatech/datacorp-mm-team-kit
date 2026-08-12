<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Estágio 2 — Spec Moderna (60 min)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 2](README.md) → **GUIDE**

> ⏰ Horário oficial: **14:00–15:00** em
> [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md). O Par 2 lidera; o Par 1 valida o
> recorte e o Par 5 revisa a clareza.

## Regra de localização dos artefatos

Os entregáveis formais do GitHub Spec-Kit vivem exclusivamente em:

```text
specs/<NNN>-<feature>/
├── spec.md
├── plan.md
└── tasks.md
```

`spec.md` contém os requisitos EARS; `plan.md` registra o plano técnico; e
`tasks.md` ordena o trabalho implementável. Não crie arquivos paralelos com
nomes legados em `02-spec-moderna/`.

`02-spec-moderna/` é apoio ao estágio: seus templates e
[`scope-decisions.md`](scope-decisions.md) registram decisão de escopo,
trade-offs e referências para a conversa. Eles não substituem os três
artefatos formais da feature.

> [!IMPORTANT]
> **HARD GATE de rastreabilidade.** Antes de redigir uma EARS, leia o programa
> ou DDM que a fundamenta. Toda REQ-ID em
> `specs/<NNN>-<feature>/spec.md` precisa de uma linha `source_legacy:` para
> `01-arqueologia/legado-sifap/.../*.NSN` ou `*.ddm`; uma capacidade sem
> paralelo no legado deve usar `[GREENFIELD]` com justificativa. Sem isso, o
> CI rejeita o PR.

## Roteiro cronometrado

| Horário | Atividade | Saída |
| --- | --- | --- |
| 14:00–14:05 | Confirme a evidência da H1 e escolha uma feature fina. | Nome `NNN-<feature>` e recorte aprovado pelo PO. |
| 14:05–14:25 | Execute `/speckit.specify` e `/speckit.clarify`. | `specs/<NNN>-<feature>/spec.md` com requisitos rastreáveis. |
| 14:25–14:40 | Execute `/speckit.plan`. | `plan.md` com decisões e riscos necessários para implementar. |
| 14:40–14:50 | Execute `/speckit.tasks`. | `tasks.md` priorizado, incluindo testes de regra de negócio. |
| 14:50–14:55 | Execute `/speckit.analyze` e corrija lacunas bloqueantes. | Referências e artefatos consistentes. |
| 14:55–15:00 | Faça a Passagem H2. | Escopo, arquivos formais e primeira tarefa para os Pares 3 e 4. |

Se uma etapa consumir o tempo disponível, reduza a feature. Não preencha
requisitos, contratos, arquitetura ou critérios de aceite por suposição.

## Apoio e decisões de escopo

- Registre em [`scope-decisions.md`](scope-decisions.md) o que foi selecionado,
  adiado ou marcado greenfield, ligando a decisão à pasta em `specs/`.
- Use [`ADR-TEMPLATE.md`](ADR-TEMPLATE.md) apenas para uma decisão que bloqueie
  o plano. Não há meta de quantidade de ADRs no estágio.
- Um esboço de contexto ou diagrama pode apoiar a conversa, mas C4 L1/L2/L3 e
  uma arquitetura completa não são pré-requisitos da H2. O racional técnico
  necessário fica no `plan.md`.

## Passagem H2

O Par 2 mostra aos Pares 3 e 4, ao vivo:

1. o caminho da pasta `specs/<NNN>-<feature>/`;
2. a feature escolhida, os requisitos e seus `source_legacy:`;
3. a primeira tarefa que pode ser implementada e os testes esperados;
4. riscos, decisões de escopo e dúvidas que ainda precisam de resposta.

## Definição de Pronto

- [ ] Uma feature pequena tem `spec.md`, `plan.md` e `tasks.md` em
      `specs/<NNN>-<feature>/`.
- [ ] Cada requisito tem `source_legacy:` válido ou `[GREENFIELD]` justificado.
- [ ] `tasks.md` inclui testes junto da implementação de regras de negócio.
- [ ] As decisões de escopo estão registradas em `02-spec-moderna/`.
- [ ] O PO confirmou o recorte e a H2 ocorreu até 15:00.

Consulte [`../09-cheat-sheets/spec-kit-workflow.md`](../09-cheat-sheets/spec-kit-workflow.md)
para os comandos e [`../specs/README.md`](../specs/README.md) para a convenção de
pastas.
