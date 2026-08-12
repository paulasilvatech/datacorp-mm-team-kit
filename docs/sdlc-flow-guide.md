<!-- markdownlint-disable MD013 MD033 MD041 -->

# Fluxo SDLC e Passagens do Workshop

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **Fluxo SDLC**

**Guia dos contratos entre pares** — resume as passagens de artefatos sem alterar horários ou ampliar entregáveis.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time |
| **Pré-requisitos** | Ter lido [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) |
| **Resultado esperado** | Entender o que cada par entrega e o que o par seguinte recebe |

---

## Visão geral do fluxo

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart LR
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef hand fill:#FFFFFF,stroke:#525252,color:#171717
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px

    E1["Estágio 1<br/>Arqueologia<br/>11:00–14:00"]:::step
    H1["Passagem H1<br/>14:00"]:::hand
    E2["Estágio 2<br/>Spec Moderna<br/>14:00–15:00"]:::step
    H2["Passagem H2<br/>15:00"]:::hand
    E3["Estágio 3<br/>Implementação<br/>15:00–16:10"]:::step
    H3["Passagem H3<br/>16:10"]:::hand
    E4["Estágio 4<br/>Evolução<br/>16:10–16:50"]:::step
    DEMO["Demo<br/>17:00–17:30"]:::result

    E1 --> H1 --> E2 --> H2 --> E3 --> H3 --> E4 --> DEMO
```

---

## Agenda oficial

| Horário | Estágio | Agente | Resultado esperado |
|---|---|---|---|
| 11:00–12:00 e 13:30–14:00 | 1 — Arqueologia | `@archaeologist` | Evidência legada e uma feature fina definida |
| 14:00–15:00 | 2 — Spec Moderna | `@architect` | `spec.md`, `plan.md` e `tasks.md` |
| 15:00–16:10 | 3 — Implementação | `@builder` | Primeiro incremento com testes da feature |
| 16:10–16:50 | 4 — Evolução | `@evolution` | Uma delegação ao Agent ou backlog revisável |

---

## Estrutura dos artefatos formais

Os artefatos formais Spec-Kit de uma feature ficam em:

```text
specs/<NNN>-<feature>/
├── spec.md
├── plan.md
└── tasks.md
```

`02-spec-moderna/` guarda somente apoio e decisões de escopo. Não crie arquivos formais paralelos fora da pasta da feature.

---

## Checklist de passagem

| Passagem | Quando | De → Para | Entrega mínima | Pergunta de confirmação |
|---|---|---|---|---|
| **H1** | 14:00 | Par 1 → Par 2 | Recorte, evidências `.NSN`/`.ddm` e dúvidas em aberto | "Lemos as fontes necessárias para a feature?" |
| **H2** | 15:00 | Par 2 → Pares 3 e 4 | Caminho da feature, `spec.md`, `plan.md`, `tasks.md` e primeira tarefa | "A primeira tarefa e seus testes estão claros?" |
| **H3** | 16:10 | Pares 3 e 4 → Par 5 | Estado do incremento, testes executados e pendências | "O que pode ser delegado sem mudar o escopo?" |

Cada passagem é uma conversa síncrona de 5 minutos. Uma lacuna não autoriza inventar requisitos, fontes legadas ou arquitetura — reduza o recorte ou registre a pendência.

---

## Rastreabilidade

Antes de escrever EARS, o responsável lê a fonte legada atribuída. Toda REQ-ID em `spec.md` contém `source_legacy:` apontando para o arquivo `.NSN` ou `.ddm` correspondente, ou `[GREENFIELD]` com justificativa. O CI bloqueia pull requests para `develop` quando esse contrato é violado.

---

## Branches

Crie `spec/<NNN>-<feature>` a partir de `develop` e integre em `develop`. Depois, crie `impl/<NNN>-<feature>` também a partir de `develop`. O fluxo é `spec/<NNN>-<feature>` → `develop` → `main`. Não existe branch `stage`.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Persona-Agent Matrix](persona-agent-matrix.md)<br/><sub>Quem protagoniza em cada etapa.</sub> | [4 Agentes Explicados](4-agents-explained.md)<br/><sub>Por que são 4 agentes.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
