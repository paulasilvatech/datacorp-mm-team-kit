<!-- markdownlint-disable MD013 MD033 MD041 -->

# Software Architect — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Software Architect**

**Inventário do kit Copilot para a persona Software Architect.** Liste os artefatos ativos, onde vivem na `.github/` e as boas práticas específicas deste papel.

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que vai atuar como Software Architect no workshop |
| **Par** | 2 · Arquitetura (junto com Enterprise Architect) |
| **Fase do SDLC** | Desenho → Supervisão da Implementação |
| **Pré-requisitos** | [PERSONA.md](PERSONA.md) lido |
| **Resultado esperado** | Kit validado, prompts acessíveis no Copilot Chat |

> [!IMPORTANT]
> Leia [PERSONA.md](PERSONA.md) antes de continuar. A ficha explica missão, passagem de bastão e rubricas de avaliação.

---

## Conceito

O Software Architect é o dono da estrutura interna do sistema. Define como módulos são organizados, onde começam e terminam bounded contexts (contextos delimitados do Domain-Driven Design) e quais abstrações são expostas. No SIFAP, esse papel produz o plano técnico que o time de implementação vai seguir — o `CODEMAP.md`, a estrutura de pacotes e os ADRs de design interno.

---

## Kit da persona

| **Artefato** | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, passagem de bastão, prompts e rubrica |
| `.github/agents/software-architect.agent.md` | Agent | Arquitetura de software |
| `.github/prompts/persona-software-architect-codemap.prompt.md` | Prompt | `/codemap` |
| `.github/prompts/persona-software-architect-impl-plan.prompt.md` | Prompt | `/impl-plan` |
| `.github/prompts/persona-software-architect-api-validate.prompt.md` | Prompt | `/api-validate` |
| `.github/instructions/backend.instructions.md` | Instructions | Convenções backend |
| `.github/instructions/frontend.instructions.md` | Instructions | Convenções frontend |

---

## Onde os artefatos vivem

Os artefatos ativos estão consolidados na `.github/` da raiz:

| **Tipo** | Caminho |
|---|---|
| Agents | `.github/agents/` |
| Prompts | `.github/prompts/persona-*.prompt.md` |
| Skills | `.github/skills/` |
| Instructions | `.github/instructions/` |

Use esta pasta como referência. Os arquivos ativos vivem apenas na `.github/` da raiz — edite lá quando precisar de manutenção.

Se o kit tiver `mcp.json` e o facilitador pedir MCP local, copie apenas esse arquivo para `.vscode/mcp.json`.

---

## Boas práticas

- Prefira composição a herança, fronteiras claras a abstrações genéricas e dados claros a código esperto.
- Contratos de API são compromisso público; quebre apenas com versão e guia de migração.
- Mantenha regra de negócio fora do banco e do framework.
- Pasta `util` crescendo costuma indicar bounded context ausente.

---

## Referências

- [Clean Architecture — Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Domain-Driven Design — Eric Evans](https://www.domainlanguage.com/ddd/)
- [Hexagonal Architecture — Alistair Cockburn](https://alistair.cockburn.us/hexagonal-architecture/)
- [Microsoft .NET Architecture Guides](https://learn.microsoft.com/dotnet/architecture/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Tabela das 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha desta persona.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
