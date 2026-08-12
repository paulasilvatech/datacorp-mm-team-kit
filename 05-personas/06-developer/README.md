<!-- markdownlint-disable MD013 MD033 MD041 -->

# Developer — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Developer**

**Kit de referência para a persona Developer no workshop de modernização do SIFAP.**

![Persona](https://img.shields.io/badge/Persona-Developer-171717?style=flat-square) ![Par 3](https://img.shields.io/badge/Par-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-404040?style=flat-square) ![Estágio 3](https://img.shields.io/badge/Est%C3%A1gio-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-737373?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que ocupa a persona Developer no workshop |
| **Foco** | Implementação Java 21 + Next.js 15, TDD, correção de bugs |
| **Fase do SDLC** | Estágio 3 — Implementação; Estágio 4 — Evolução |
| **Resultado esperado** | Backend + frontend da fatia priorizada com testes passando |

Leia primeiro: [PERSONA.md](PERSONA.md).

---

## Conceito

O Developer é quem transforma especificações EARS em código executável. Na modernização do SIFAP, essa persona traduz programas Natural e modelos DDM/Adabas para Java 21 com Spring Boot 3.3, JPA/Hibernate e PostgreSQL 16, além de implementar o frontend em Next.js 15 com TypeScript.

Por que importa: sem o Developer, os requisitos ficam em texto. É essa persona que faz a prova de conceito virar software testado e mergeável.

## Kit da persona

Todos os artefatos ativos vivem na `.github/` da raiz do repositório. Esta pasta é referência; edite os arquivos em `.github/` quando precisar de manutenção.

| Arquivo | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, estágios, prompts e rubricas do Developer |
| `.github/agents/implementer.agent.md` | Agente | Implementação, TDD e correção de bugs |
| `.github/prompts/persona-developer-implement.prompt.md` | Prompt | `/implement` |
| `.github/prompts/persona-developer-fix-bug.prompt.md` | Prompt | `/fix-bug` |
| `.github/prompts/persona-developer-tdd.prompt.md` | Prompt | `/tdd` |
| `.github/prompts/persona-developer-refactor.prompt.md` | Prompt | `/refactor` |

> [!TIP]
> Se o facilitador pedir MCP local e este kit tiver `mcp.json`, copie apenas esse arquivo para `.vscode/mcp.json`.

## Onde os artefatos ativos vivem

- Agentes: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Boas práticas

- [ ] **Escrever testes antes ou junto com o código.** Quando o design estiver claro, escreva o teste primeiro. Todo commit inclui testes.
- [ ] **Manter PRs pequenos.** Um PR por assunto, revisável em cerca de 20 minutos.
- [ ] **Separar refatoração de mudança de comportamento.** Commits distintos para cada intenção.
- [ ] **Comentar o porquê, não o quê.** O código descreve o que faz; o comentário explica a razão.

## Exemplo aplicado ao SIFAP

No Estágio 3, o Developer recebe os REQ-IDs do Requirements Engineer e a estrutura de pacotes do Software Architect. A tarefa concreta é implementar, por exemplo, o endpoint `POST /api/v1/beneficios` respeitando as regras extraídas do programa Natural `SIFAP-BEN.NSN` e escrevendo testes de integração com Testcontainers apontando para o schema gerado pelas migrações Flyway do DBA.

## Referências

- [Clean Code — Robert C. Martin](https://www.oreilly.com/library/view/clean-code-a/9780136083238/)
- [Refactoring — Martin Fowler](https://refactoring.com/)
- [Test-Driven Development — Kent Beck](https://www.oreilly.com/library/view/test-driven-development/0321146530/)
- [GitHub Copilot Best Practices](https://docs.github.com/en/copilot)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Visão geral das personas](../OVERVIEW.md)<br/><sub>Tabela das 10 personas e seus pares.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha completa da persona Developer.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>

