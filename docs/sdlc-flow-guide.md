<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Fluxo SDLC e Passagens do Workshop

O cronograma oficial está em [`../00-TEAM-FLOW.md`](../00-TEAM-FLOW.md). Este
guia resume os contratos entre pares; não altera horários ou amplia entregáveis.

## Agenda oficial

| Horário | Estágio | Agente | Resultado |
| --- | --- | --- | --- |
| 11:00–12:00 + 13:30–14:00 | Arqueologia | `@archaeologist` | Evidência legada e uma feature fina. |
| 14:00–15:00 | Spec Moderna | `@architect` | `spec.md`, `plan.md` e `tasks.md`. |
| 15:00–16:10 | Implementação | `@builder` | Primeiro incremento e testes da feature. |
| 16:10–16:50 | Evolução | `@evolution` | Uma delegação pequena ou backlog revisável. |

## Fonte de verdade dos artefatos

Os artefatos formais Spec-Kit de uma feature vivem em:

```text
specs/<NNN>-<feature>/
├── spec.md
├── plan.md
└── tasks.md
```

`02-spec-moderna/` guarda somente apoio e decisões de escopo. Não crie arquivos
formais paralelos fora da pasta da feature.

## Checklist de passagem

| Passagem | Quando | De → Para | Entrega mínima | Confirmação |
| --- | --- | --- | --- | --- |
| H1 | 14:00 | Par 1 → Par 2 | Recorte, evidências `.NSN`/`.ddm` e dúvidas abertas. | “Lemos as fontes necessárias para a feature?” |
| H2 | 15:00 | Par 2 → Pares 3 e 4 | Caminho da feature, `spec.md`, `plan.md`, `tasks.md` e primeira tarefa. | “A primeira tarefa e seus testes estão claros?” |
| H3 | 16:10 | Pares 3 e 4 → Par 5 | Estado do incremento, testes executados e pendências. | “O que pode ser delegado sem mudar o escopo?” |

Cada passagem é uma conversa síncrona de cinco minutos. Uma lacuna não autoriza
inventar requisitos, fontes legadas ou arquitetura: reduza o recorte ou registre
a pendência.

## Rastreabilidade

Antes de escrever EARS, o responsável lê a fonte legada atribuída. Toda REQ-ID
em `spec.md` contém `source_legacy:` apontando para `.NSN` ou `.ddm`, ou
`[GREENFIELD]` com justificativa. O CI bloqueia PR para `develop` quando esse
contrato falha.

## Branches

Crie `spec/<NNN>-<feature>` a partir de `develop` e integre em `develop`.
Depois, crie `impl/<NNN>-<feature>` também a partir de `develop`. O fluxo é
`spec/<NNN>-<feature>` → `develop` → `main`; não existe branch `stage`.
