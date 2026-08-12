<!-- markdownlint-disable MD013 MD033 MD041 -->

# Enterprise Architect — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Enterprise Architect**

**Inventário do kit Copilot para a persona Enterprise Architect.** Liste os artefatos ativos, onde vivem na `.github/` e as boas práticas específicas deste papel.

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que vai atuar como Enterprise Architect no workshop |
| **Par** | 2 · Arquitetura (junto com Software Architect) |
| **Fase do SDLC** | Arquitetura → Desenho → Segurança |
| **Pré-requisitos** | [PERSONA.md](PERSONA.md) lido |
| **Resultado esperado** | Kit validado, prompts acessíveis no Copilot Chat |

> [!IMPORTANT]
> Leia [PERSONA.md](PERSONA.md) antes de continuar. A ficha explica missão, passagem de bastão e rubricas de avaliação.

---

## Conceito

O Enterprise Architect enxerga o sistema dentro do seu ecossistema. No SIFAP, isso significa mapear as dependências externas — SIAFI, Banco do Brasil, INCRA, MDA — e garantir que a arquitetura-alvo respeite contratos existentes. O EA sabe onde estão os contratos, quais são frágeis e quais podem ser modificados sem disparar uma cadeia de efeitos imprevistos.

---

## Kit da persona

| **Artefato** | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, passagem de bastão, prompts e rubrica |
| `.github/agents/enterprise-architect.agent.md` | Agent | Arquitetura e segurança |
| `.github/prompts/persona-enterprise-architect-create-constitution.prompt.md` | Prompt | `/create-constitution` |
| `.github/prompts/persona-enterprise-architect-create-adr.prompt.md` | Prompt | `/create-adr` |
| `.github/prompts/persona-enterprise-architect-architecture-review.prompt.md` | Prompt | `/architecture-review` |
| `.github/instructions/security.instructions.md` | Instructions | Convenções de segurança |
| `.github/instructions/infrastructure.instructions.md` | Instructions | Convenções de IaC |
| `hooks.json` | Hooks | Bloqueios de edição para `.specify/memory/constitution.md` |

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

- Use C4 L1/L2 para visão executiva e L3/L4 para implementação.
- Toda decisão arquitetural precisa de ADR com contexto, decisão e consequências.
- Prefira arquitetura previsível e operável em produção.
- Use os pilares do Azure Well-Architected como gates de revisão, não como checklist tardio.

---

## Referências

- [C4 Model — Simon Brown](https://c4model.com/)
- [Microsoft Azure Well-Architected Framework](https://learn.microsoft.com/azure/well-architected/)
- [Architecture Decision Records](https://adr.github.io/)
- [Azure Architecture Center](https://learn.microsoft.com/azure/architecture/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Tabela das 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha desta persona.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
