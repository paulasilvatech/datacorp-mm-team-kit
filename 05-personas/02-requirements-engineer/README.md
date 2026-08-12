<!-- markdownlint-disable MD013 MD033 MD041 -->

# Requirements Engineer — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Requirements Engineer**

**Inventário do kit Copilot para a persona Requirements Engineer.** Liste os artefatos ativos, onde vivem na `.github/` e as boas práticas específicas deste papel.

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que vai atuar como Requirements Engineer no workshop |
| **Par** | 1 · Visão (junto com Product Owner) |
| **Fase do SDLC** | Requisitos → Especificação |
| **Pré-requisitos** | [PERSONA.md](PERSONA.md) lido |
| **Resultado esperado** | Kit validado, prompts acessíveis no Copilot Chat |

> [!IMPORTANT]
> Leia [PERSONA.md](PERSONA.md) antes de continuar. A ficha explica missão, passagem de bastão e rubricas de avaliação.

---

## Conceito

O Requirements Engineer é o papel responsável por transformar conversas e descobertas em requisitos formais e testáveis. No SIFAP, as regras de negócio estão tacitamente codificadas em Natural — sem documentação atualizada. O RE extrai essas regras, estrutura-as em notação EARS (Easy Approach to Requirements Syntax) e garante rastreabilidade do legado ao requisito moderno.

---

## Kit da persona

| **Artefato** | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, passagem de bastão, prompts e rubrica |
| `.github/agents/requirements-engineer.agent.md` | Agent | Análise de requisitos |
| `.github/prompts/persona-requirements-engineer-spec-sync.prompt.md` | Prompt | `/spec-sync` |
| `.github/prompts/persona-requirements-engineer-contradiction-check.prompt.md` | Prompt | `/contradiction-check` |
| `.github/prompts/persona-requirements-engineer-ears-convert.prompt.md` | Prompt | `/ears-convert` |
| `.github/instructions/requirements.instructions.md` | Instructions | Convenções de documentação de requisitos |

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

- Use padrões EARS exclusivamente; requisitos vagos precisam ser quantificados.
- Todo `REQ-ID` deve ser único, imutável e rastreável a pelo menos um teste e uma task.
- Faça uma passada de contradição antes de aceitar novas specs.
- Remova ou quantifique termos ambíguos como "adequado", "razoável" e "amigável".

---

## Referências

- [EARS Notation — Alistair Mavin](https://alistairmavin.com/ears/)
- [IEEE 29148 — Requirements Engineering](https://www.iso.org/standard/72089.html)
- [ISO/IEC 25010 — Quality Model](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010)
- [Writing Good Requirements — INCOSE](https://www.incose.org/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Tabela das 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha desta persona.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>

