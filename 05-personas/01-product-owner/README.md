<!-- markdownlint-disable MD013 MD033 MD041 -->

# Product Owner — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Product Owner**

**Inventário do kit Copilot para a persona Product Owner.** Liste os artefatos ativos, onde vivem na `.github/` e as boas práticas específicas deste papel.

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que vai atuar como Product Owner no workshop |
| **Par** | 1 · Visão (junto com Requirements Engineer) |
| **Fase do SDLC** | Descoberta → Especificação → Aceite |
| **Pré-requisitos** | [PERSONA.md](PERSONA.md) lido |
| **Resultado esperado** | Kit validado, prompts acessíveis no Copilot Chat |

> [!IMPORTANT]
> Leia [PERSONA.md](PERSONA.md) antes de continuar. A ficha explica missão, passagem de bastão e rubricas de avaliação.

---

## Conceito

O Product Owner é o papel responsável por traduzir necessidades de negócio em escopo executável. Num processo de modernização de legado como o SIFAP, essa função é crítica: sistemas legados acumulam regras implícitas que só fazem sentido quando alguém sabe "por que" elas existem. O PO conecta cada decisão técnica à evidência de negócio.

---

## Kit da persona

| **Artefato** | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, passagem de bastão, prompts e rubrica |
| `.github/agents/product-owner.agent.md` | Agent | Assistente de Product Owner para spec, backlog e aceite |
| `.github/prompts/persona-product-owner-spec.prompt.md` | Prompt | `/spec` — escreve seção de `specs/<NNN>-<feature>/spec.md` a partir de user stories em EARS |
| `.github/prompts/persona-product-owner-update-spec.prompt.md` | Prompt | `/update-spec` — atualiza a spec quando uma feature muda |
| `.github/prompts/persona-product-owner-acceptance-check.prompt.md` | Prompt | `/acceptance-check` — verifica se o código atende aos critérios de aceite |
| `mcp.json` | MCP | Manifesto de servidores GitHub + Azure DevOps work items |

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

- Escreva requisitos em EARS para que cada frase seja testável.
- Mantenha cada user story ligada a um resultado mensurável.
- Marque suposições explicitamente — suposição escondida vira bug de produção.
- Trate `.specify/memory/constitution.md` como fonte de verdade para itens inegociáveis.

---

## Referências

- [EARS Notation — Alistair Mavin](https://alistairmavin.com/ears/)
- [Spec-Driven Development (Spec-Kit)](https://github.com/github/spec-kit)
- [User Story Mapping — Jeff Patton](https://www.jpattonassociates.com/user-story-mapping/)
- [GitHub Copilot for PMs](https://docs.github.com/en/copilot)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [OVERVIEW](../OVERVIEW.md)<br/><sub>Tabela das 10 personas.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha desta persona.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
