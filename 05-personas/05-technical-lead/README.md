<!-- markdownlint-disable MD013 MD033 MD041 -->

# Technical Lead — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Technical Lead**

**Inventário do kit Copilot para a persona Technical Lead.** Liste os artefatos ativos, onde vivem na `.github/` e as boas práticas específicas deste papel.

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que vai atuar como Technical Lead no workshop |
| **Par** | 3 · Implementação (junto com Developer) |
| **Fase do SDLC** | Todas as fases (coordenação técnica) |
| **Pré-requisitos** | [PERSONA.md](PERSONA.md) lido |
| **Resultado esperado** | Kit validado, prompts acessíveis no Copilot Chat |

> [!IMPORTANT]
> Leia [PERSONA.md](PERSONA.md) antes de continuar. A ficha explica missão, passagem de bastão e rubricas de avaliação.

---

## Conceito

O Technical Lead é o elo entre arquitetura e código do dia a dia. Define padrões de implementação, desbloqueia o time quando alguém trava num detalhe técnico e garante que ao final do Estágio 3 a aplicação criada pelo time realmente roda de ponta a ponta. No SIFAP, o TL é responsável por manter a velocidade de execução sem comprometer a qualidade — escolhendo quais batalhas técnicas valem a pena travar.

---

## Kit da persona

| **Artefato** | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, passagem de bastão, prompts e rubrica |
| `.github/agents/tech-lead.agent.md` | Agent | Governança técnica |
| `.github/prompts/persona-technical-lead-setup-project.prompt.md` | Prompt | `/setup-project` |
| `.github/prompts/persona-technical-lead-routing-table.prompt.md` | Prompt | `/routing-table` |
| `.github/prompts/persona-technical-lead-audit-context.prompt.md` | Prompt | `/audit-context` |
| `hooks.json` | Hooks | Escopo, lint e testes |

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

- Bloqueie mudanças ruins, não pessoas; revise o PR e proteja o tempo de quem revisa.
- `CODEMAP.md` é memória de trabalho do time; se está desatualizado, o time trabalha sem visibilidade.
- Roteamento de modelo importa: Opus para descoberta, Sonnet para implementação, Haiku para transformações mecânicas.
- Custo por feature é métrica de engenharia; acompanhe junto com cobertura.

---

## Referências

- [Staff Engineer — Will Larson](https://staffeng.com/)
- [The Manager's Path — Camille Fournier](https://www.oreilly.com/library/view/the-managers-path/9781491973882/)
- [Accelerate — Forsgren, Humble, Kim](https://itrevolution.com/product/accelerate/)
- [GitHub Copilot Best Practices](https://docs.github.com/en/copilot)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Tabela das 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha desta persona.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
