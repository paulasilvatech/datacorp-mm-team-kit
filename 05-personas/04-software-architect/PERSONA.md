<!-- markdownlint-disable MD013 MD033 MD041 -->

# Persona — Software Architect

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › [Software Architect](README.md) › **PERSONA**

**Ficha completa da persona Software Architect.** Define missão, responsabilidades por estágio, ferramentas, passagem de bastão e rubricas de avaliação.

| Campo | Valor |
|---|---|
| **Papel** | Software Architect |
| **Par** | 2 · Arquitetura (junto com Enterprise Architect) |
| **Estágios de atuação** | Lidera 2 (bounded contexts, módulos) e 3 (revisão estrutural) |
| **Artefatos que produz** | `plan.md`, `CODEMAP.md`, estrutura de pacotes Spring, ADRs de design interno |
| **Artefatos que consome** | Evidências de dependência (EA), REQ-IDs (RE) |
| **Handoff para** | Par 3 (Implementação) no Estágio 2 — `plan.md` e primeira tarefa claros |

![Estágio 2](https://img.shields.io/badge/Est%C3%A1gio-2%20%C2%B7%20Especifica%C3%A7%C3%A3o-171717?style=flat-square) ![Estágio 3](https://img.shields.io/badge/Est%C3%A1gio-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-404040?style=flat-square)

---

## Conceito

O Software Architect define a estrutura interna do sistema: como módulos são organizados, onde começam e terminam os bounded contexts (contextos delimitados — uma técnica do Domain-Driven Design para separar responsabilidades), e quais contratos são expostos entre partes do sistema.

Na indústria, esse papel é responsável por manter o sistema verdadeiramente modular — o que significa que mudanças em um módulo não quebram outros de forma inesperada. Num Modular Monolith (um único processo implantado, mas com código organizado em módulos independentes), o SA garante que a modularidade do código seja mantida mesmo sob pressão de prazo.

No SIFAP, o SA define onde ficam os bounded contexts do sistema moderno (ex.: `pagamento`, `beneficiario`, `fiscalizacao`) e como cada um mapeia para os programas Natural do legado. Essa decisão orienta todo o Estágio 3.

**Exemplo concreto no SIFAP:** os programas `SIFAP001.NSN` a `SIFAP005.NSN` lidam com lógica de pagamento. O SA define que esses programas pertencem ao bounded context `pagamento`, cria a estrutura de pacotes `br.gov.sifap.pagamento.{domain,application,infrastructure}` e documenta a decisão.

---

## Onde você atua no SDLC

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart LR
    classDef active fill:#F5F5F5,stroke:#171717,color:#171717
    classDef support fill:#FAFAFA,stroke:#A3A3A3,color:#404040
    classDef inactive fill:#FFFFFF,stroke:#E5E5E5,color:#A3A3A3

    E1["Estágio 1<br/>Arqueologia"]:::support --> E2["Estágio 2<br/>Especificação"]:::active
    E2 --> E3["Estágio 3<br/>Implementação"]:::active
    E3 --> E4["Estágio 4<br/>Evolução"]:::inactive
```

- **Recebe de:** Enterprise Architect (evidências de dependência) e Requirements Engineer (REQ-IDs)
- **Faz passagem de bastão para:** Par 3 (Implementação) no Estágio 2 — `plan.md` e primeira tarefa claros

---

## Responsabilidades por estágio

| **Estágio** | Você faz isso | Entregável que depende de você |
|---|---|---|
| **1 · Arqueologia** | Identifica conceitos recorrentes e dependências relevantes ao recorte. | Evidências para discutir limites de contexto |
| **2 · Especificação** | Escreve o plano técnico da feature e registra decisão apenas quando bloquear a tarefa. | `plan.md` e ADR de apoio, se necessário |
| **3 · Implementação** | Estabelece a estrutura inicial do projeto Spring (pacotes, camadas). Revisa PRs que cruzam fronteiras de contexto. | `pom.xml` + layout de módulos + revisão de PRs estruturais |
| **4 · Evolução** | Valida que o PR do Agent respeita as fronteiras. Rejeita merges que quebrem modularidade. | Modularidade preservada |

---

## Kit da persona

| **Artefato** | Finalidade |
|---|---|
| `.github/agents/software-architect.agent.md` | Agente Copilot configurado para arquitetura de software |
| `/codemap` — `persona-software-architect-codemap.prompt.md` | Gera ou atualiza o `CODEMAP.md` do projeto |
| `/impl-plan` — `persona-software-architect-impl-plan.prompt.md` | Cria o plano técnico de implementação |
| `/api-validate` — `persona-software-architect-api-validate.prompt.md` | Valida contratos de API contra a spec |
| `.github/instructions/backend.instructions.md` | Convenções de backend Java |
| `.github/instructions/frontend.instructions.md` | Convenções de frontend Next.js |

---

## Ferramentas e primitivas

- **Copilot Plan** para desenhar esqueletos de módulo antes da implementação.
- **GitHub Spec-Kit** — `/speckit.plan` e `/speckit.analyze` para plano, contratos e consistência.
- **Mermaid / C4** para diagramas de contexto e componentes.
- Skills do kit — prompts para decidir entre padrões (hexagonal vs. camadas em pacotes).

**Cheat-sheets relevantes:**

- [`../../09-cheat-sheets/spec-kit-workflow.md`](../../09-cheat-sheets/spec-kit-workflow.md) — `/speckit.plan`, `/speckit.tasks` e `/speckit.analyze`.
- [`../../09-cheat-sheets/model-routing.md`](../../09-cheat-sheets/model-routing.md) — Claude Opus 4.6 para decisões; Sonnet 4.6 para edição em lote.

---

## Checklist de onboarding

- [ ] **Ler esta ficha.** Missão, responsabilidades e passagem de bastão.
- [ ] **Abrir o `README.md` do kit.** Confirmar que agents e prompts aparecem no Copilot Chat.
- [ ] **Identificar seu par.** Consultar [00-TEAM-FLOW.md](../../00-TEAM-FLOW.md).
- [ ] **Alinhar com o EA.** Definir onde o escopo de cada um começa e termina.
- [ ] **Anotar a passagem de bastão.** Saber quem recebe o `plan.md` e o que precisa estar nele.

---

## Como se sair bem neste papel

- O layout de pacotes reflete os bounded contexts, não as camadas técnicas.
- Seus ADRs são curtos, específicos e citam a feature correspondente em `specs/<NNN>-<feature>/` quando relevante.
- O Modular Monolith permanece monolito no deploy, mas modular no código.
- Você redesenha fronteiras quando há evidência, em vez de "pedir perdão depois".

---

## Erros comuns e como evitar

| **Sintoma** | Causa | Correção |
|---|---|---|
| Código organizado por camadas (controller/service/repository) | SA não definiu bounded contexts explicitamente | Crie pacotes por contexto de negócio, não por tipo técnico |
| ADR genérico sem valor | "Vamos usar Spring Boot" não é uma decisão arquitetural | ADR de SA responde "como organizamos X?" ou "qual padrão usamos aqui?" |
| Dois contextos importam classes um do outro | Fronteira de contexto não foi respeitada | Exponha apenas interfaces públicas; nunca imports diretos entre contextos |
| Hexagonal estrito onde não há benefício | Padrão aplicado por costume | Escolha o padrão que melhor serve ao contexto; registre a escolha |

---

## 3 exemplos de prompt

1. **(Chat)** "Com base nestes requisitos EARS, proponha hipóteses de fronteiras de contexto. Para cada hipótese liste evidências, entidades e dependências."
2. **(Plan)** "No projeto Spring Boot, planeje a estrutura de pacotes para um novo bounded context 'notification' seguindo o padrão dos existentes (domain/application/infrastructure)."
3. **(Chat)** "Revise este PR e identifique imports que cruzam fronteiras de bounded context. Para cada violação, sugira como isolar."

---

## Se travar

| **Situação** | O que fazer |
|---|---|
| Bounded contexts confusos | Comece pelas evidências de coesão, acoplamento e frequência de mudança; não presuma fronteiras |
| Fronteira travada | Volte à evidência legada e registre a dúvida; não crie um diagrama como substituto de confirmação |
| Time organizado por camadas em vez de contextos | Não refatore agora — documente no ADR e corrija se sobrar tempo |
| Dúvida se algo é domain ou application | "Se é regra de negócio pura, é domain. Se orquestra, é application." |

---

## Dependências

| **Persona** | Relação | Artefato |
|---|---|---|
| Enterprise Architect | Você depende dele | Evidências de dependência para o plano técnico |
| Developer | Depende de você | Estrutura de pacotes para implementar |
| Technical Lead | Depende de você | Padrões de módulo para enforcement |
| DBA | Depende de você | Fronteiras de contexto para o modelo de dados |

---

## Como você é avaliado

- **Rubrica A2 (Spec):** plano técnico coerente com requisitos e evidências.
- **Rubrica A3 (Integridade Técnica):** bounded contexts respeitados no código.
- Critério: "Nenhum import cruza fronteira de contexto sem justificativa."

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Enterprise Architect](../03-enterprise-architect/PERSONA.md)<br/><sub>Par 2 · Arquitetura · C4 + ADRs estruturais.</sub> | [Technical Lead](../05-technical-lead/PERSONA.md)<br/><sub>Par 3 · Implementação · padrões e revisão.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
