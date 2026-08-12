<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Persona — Software Architect

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Personas](../OVERVIEW.md) → [Software Architect](README.md) → **PERSONA**


> **Para quem é isto?** Para a pessoa que vai vestir a persona **Software Architect** no workshop. Foco: bounded contexts, módulos, contratos.
>
> **O que você terá ao final desta leitura:**
>
> 1. Saberá em qual par está e qual fase do SDLC lidera
> 2. Conhecerá a missão da persona no Dia 2
> 3. Verá em qual estágio você lidera, apoia ou observa
> 4. Terá 3 prompts de Copilot prontos para usar
> 5. Saberá o default se travar ("se não souber o que fazer, faça X")

![Par 2 · Arquitetura](https://img.shields.io/badge/PAR-Par%202%20%E2%80%A2%20Arquitetura-FFB900?style=for-the-badge) ![Lidera estágio 2, 3](https://img.shields.io/badge/LIDERA%20EST%C3%81GIO-2%2C%203-1A1A1A?style=for-the-badge) ![Apoia estágio —](https://img.shields.io/badge/APOIA-—-737373?style=for-the-badge)

## Onde você atua no SDLC

![Linha do tempo do dia mostrando onde esta persona atua](../../assets/timeline-stages.svg)

- **Par**: 2 · Arquitetura (junto com Enterprise Architect)
- **Fases lideradas**: Especificação (S2) — plano técnico do recorte + Implementação (S3) — revisão estrutural
- **Recebe de**: Enterprise Architect (evidências de dependência) e Requirements Engineer (REQ-IDs)
- **Faz passagem para**: Par 3 (Implementação) no H2 — `plan.md` e primeira tarefa claros

## Quem é essa pessoa

Dono da estrutura interna do sistema. Decide como módulos são organizados, onde começam e terminam bounded contexts, quais abstrações são expostas e quais ficam privadas. Quem mantém o Modular Monolith verdadeiramente modular.

## Missão no workshop

Produzir somente o plano técnico necessário à feature escolhida. Definir limites e comunicação quando a evidência os exigir e garantir que o código do Estágio 3 respeite as decisões registradas.

## Seu papel no framework Agentic Legacy Modernization

- **Agentes relevantes**: Analysis Agent (S2), Review Agent (S3)
- **Fase do framework**: Application Carving → Translation
- **Seu papel**: definir bounded contexts e garantir um Modular Monolith coerente

## Onde você aparece em cada estágio

| Estágio                | Você faz isso                                                                                                      | Entregável que depende de você                            |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------ | --------------------------------------------------------- |
| 1. Arqueologia         | Identifica conceitos recorrentes e dependências relevantes ao recorte. | Evidências para discutir limites |
| 2. Spec Moderna        | Escreve o plano técnico da feature e registra decisão apenas quando bloquear a tarefa. | `plan.md` e decisão de apoio, se necessária |
| 3. Implementação       | Estabelece a estrutura inicial do projeto Spring (pacotes, camadas). Revisa PRs que cruzam fronteiras de contexto. | `pom.xml` + layout de módulos + review de PRs estruturais |
| 4. Evolução com Agent  | Valida que o PR do Agent respeita as fronteiras. Rejeita merges que quebrem modularidade.                          | Modularidade preservada                                   |

## Ferramentas e primitivas

- **Copilot Plan** para desenhar esqueletos de módulo antes da implementação.
- **GitHub Spec-Kit** — `/speckit.plan` e `/speckit.analyze` são seu terreno para plano, contratos e consistência.
- **Mermaid / C4** para diagramas.
- Skills específicas de SA no próprio persona-kit — prompts para decidir entre padrões (hexagonal vs. camadas, por exemplo).

## Cheat-sheets que você usa

- [`../09-cheat-sheets/spec-kit-workflow.md`](../../09-cheat-sheets/spec-kit-workflow.md) — `/speckit.plan`, `/speckit.tasks` e `/speckit.analyze`.
- [`../09-cheat-sheets/model-routing.md`](../../09-cheat-sheets/model-routing.md) — Opus 4.6 para decisões; Sonnet 4.6 para edição em lote.

## Como você se sai bem

- O layout de pacotes reflete os bounded contexts, não as camadas técnicas.
- Seus ADRs são curtos, específicos, e citam a feature correspondente em `specs/<NNN>-<feature>/` quando relevante.
- O Modular Monolith permanece monolito no deploy mas modular no código.
- Você redesenha fronteiras quando preciso, em vez de "pedir perdão depois".

## Como você se perde

- Deixa o time organizar por camadas técnicas (controller/service/repository) em vez de contextos.
- Escreve ADR genérico ("vamos usar Spring Boot") que não é decisão real.
- Permite que dois contextos importem classes um do outro diretamente.
- Tenta forçar hexagonal estrito onde não há benefício.

## Se você pegou duas personas

- **SA + Enterprise Architect** se o time for pequeno (você cuida do C4 1 e do 2/3).
- **SA + Technical Lead** é a combinação mais produtiva — você desenha e mete a mão no código.

## 3 exemplos de prompt

1. **(Chat)** _"Com base nestes requisitos EARS, proponha hipóteses de fronteiras de contexto. Para cada hipótese liste evidências, entidades e dependências."_
2. **(Plan)** _"No projeto Spring Boot, planeje a estrutura de pacotes para um novo bounded context 'notification' seguindo o padrão dos existentes (domain/application/infrastructure)."_
3. **(Chat)** _"Revise este PR e identifique imports que cruzam fronteiras de bounded context. Para cada violação, sugira como isolar."_

## Se travar (defaults de emergência)

- **Bounded contexts confusos?** Comece pelas evidências de coesão, acoplamento e frequência de mudança; não presuma fronteiras.
- **Fronteira travada?** Volte à evidência legada e registre a dúvida; não crie um diagrama como substituto de confirmação.
- **Time organizado por camadas em vez de contextos?** Não refatore agora — documente no ADR e corrija se sobrar tempo.
- **Dúvida se algo é domain ou application?** "Se é regra de negócio pura, é domain. Se orquestra, é application."

## Dependências — Quem depende de você

| Persona              | Relação           | Artefato                                      |
| -------------------- | ----------------- | --------------------------------------------- |
| Enterprise Architect | VOCÊ depende dele | Evidências de dependência para o plano técnico |
| Developer            | Depende de VOCÊ   | Estrutura de pacotes para implementar         |
| Technical Lead       | Depende de VOCÊ   | Padrões de módulo para enforcement            |
| DBA                  | Depende de VOCÊ   | Fronteiras de contexto para o modelo de dados |

## Como você é avaliado

- **Rubrica A2 (Spec):** plano técnico coerente com requisitos e evidências.
- **Rubrica A3 (Integridade Técnica):** bounded contexts respeitados no código.
- Critério: "Nenhum import cruza fronteira de contexto sem justificativa."
---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="../03-enterprise-architect/PERSONA.md"><strong>Enterprise Architect</strong></a><br/>
<sub>Par 2 · Arquitetura · C4 + ADRs estruturais.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="../05-technical-lead/PERSONA.md"><strong>Technical Lead</strong></a><br/>
<sub>Par 3 · Implementação · padrões e revisão.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>

— Paula
