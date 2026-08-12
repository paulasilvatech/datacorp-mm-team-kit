<!-- markdownlint-disable MD013 MD033 MD041 -->

# 07 — Conceitos Fundamentais do Workshop

> **Trilha:** [Kit do Time](../README.md) › **Conceitos Fundamentais**

**Este índice apresenta os conceitos essenciais do workshop de modernização do SIFAP — o que você vai aprender, em que ordem, quanto tempo leva e como cada conceito se conecta aos quatro estágios de trabalho.**

![Secao Conceitos](https://img.shields.io/badge/Se%C3%A7%C3%A3o-07%20Conceitos-171717?style=flat-square) ![Audiencia Todos](https://img.shields.io/badge/Audi%C3%AAncia-Todos-737373?style=flat-square) ![Leia Antes do Estagio 1](https://img.shields.io/badge/Leia-Antes%20do%20Est%C3%A1gio%201-A3A3A3?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Qualquer pessoa do time, incluindo quem não programa |
| **Pré-requisitos** | Nenhum — este é o ponto de partida |
| **Tempo estimado** | 60 a 90 min para ler todos os documentos |
| **Resultado esperado** | Vocabulário compartilhado antes do Estágio 1 |

---

## O que você vai aprender

Cada arquivo desta pasta explica um conceito técnico de forma direta, com exemplos reais do domínio SIFAP (pagamentos, benefícios, fiscalização). Ao concluir a leitura, você consegue:

- Explicar o ciclo do Spec-Kit sem consultar nada
- Distinguir persona-kit de agente de estágio e saber como combiná-los no Copilot Chat
- Escolher o modo correto do Copilot (Ask, Plan ou Agent) para cada situação
- Escrever ou revisar um requisito no formato EARS com `source_legacy:`
- Escrever ou avaliar uma Architecture Decision Record (ADR)

---

## Trilha de aprendizado

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart TD
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef tool fill:#FFFFFF,stroke:#525252,color:#171717
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px

    A["01 — Spec-Driven Development<br/><sub>O que é o Spec-Kit e por que especificar antes de codar</sub>"]:::step
    B["02 — Agentes e Personas<br/><sub>Duas camadas de contexto no Copilot Chat</sub>"]:::step
    C["04 — 3 modos do Copilot<br/><sub>Ask · Plan · Agent e critérios de escolha</sub>"]:::step
    D["03 — Glossário Visual<br/><sub>Referência de 30+ termos — consulte quando precisar</sub>"]:::tool
    E["05 — Notação EARS<br/><sub>Como escrever requisitos sem ambiguidade</sub>"]:::step
    F["06 — Architecture Decision Records<br/><sub>Como registrar decisões para o time futuro</sub>"]:::step
    G["Estágio 1 — Arqueologia"]:::result

    A --> B --> C --> E --> F --> G
    D -. "consulta a qualquer momento" .-> G
```

---

## Documentos desta pasta

| # | Documento | Conceito central | Estágio principal |
|---|---|---|---|
| 01 | [Spec-Driven Development](01-spec-driven-development.md) | Ciclo Spec-Kit: specify → plan → tasks → implement | Estágio 2 |
| 02 | [Agentes e Personas](02-agentes-e-personas.md) | Persona-kit individual × agente de estágio compartilhado | Todos |
| 03 | [Glossário Visual](03-glossario-visual.md) | 30+ termos com definição, exemplo SIFAP e referência | Todos |
| 04 | [3 modos do Copilot](04-3-modos-do-copilot.md) | Ask · Plan · Agent — critérios e antipadrões | Todos |
| 05 | [Notação EARS](05-notacao-ears.md) | 5 padrões EARS, REQ-ID e `source_legacy:` | Estágio 2 |
| 06 | [Architecture Decision Records](06-architecture-decision-records.md) | Anatomia, quando escrever e ciclo de vida de ADRs | Estágio 2 |

---

## Conexão com os quatro estágios

| Estágio | Documentos de referência desta pasta |
|---|---|
| Estágio 1 — Arqueologia | Glossário (termos legado: Natural, DDM, MU, PE, BR-NNN) |
| Estágio 2 — Especificação | Spec-Kit, Agentes, EARS, ADR, Glossário (EARS, REQ-ID, source_legacy) |
| Estágio 3 — Implementação | 3 modos do Copilot, Glossário (JPA, Flyway, Testcontainers, Controller) |
| Estágio 4 — Evolução | 3 modos do Copilot (modo Agent), Glossário (IaC, Terraform, CI/CD) |

---

## Verificacao antes de continuar

Antes de iniciar o Estágio 1, confirme que você consegue responder estas perguntas sem consultar nada:

- [ ] O que é o Spec-Kit e para que serve o comando `/speckit.specify`?
- [ ] Qual a diferença entre persona-kit (em `05-personas/`) e agente de estágio (em `06-agentes-de-estagio/`)?
- [ ] Quando usar Ask em vez de Agent no Copilot?
- [ ] O que é uma EARS e por que o campo `source_legacy:` é obrigatório?
- [ ] O que é um ADR e em qual situação você escreveria um?

Se respondeu quatro das cinco: avance para [`../05-personas/`](../05-personas/) e leia os seus dois `PERSONA.md`.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Kit do Time](../README.md)<br/><sub>Hub principal do workshop.</sub> | [Spec-Driven Development](01-spec-driven-development.md)<br/><sub>Por que especificar antes de codar e como o Spec-Kit estrutura esse processo.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
