<!-- markdownlint-disable MD013 MD033 MD041 -->

# QA Engineer — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **QA Engineer**

**Kit de referência para a persona QA Engineer no workshop de modernização do SIFAP.**

![Persona](https://img.shields.io/badge/Persona-QA%20Engineer-171717?style=flat-square) ![Par 4](https://img.shields.io/badge/Par-4%20%C2%B7%20Qualidade-404040?style=flat-square) ![Estágios 3 e 4](https://img.shields.io/badge/Est%C3%A1gios-3%20e%204-737373?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que ocupa a persona QA Engineer no workshop |
| **Foco** | Geração de testes a partir de specs EARS, cobertura de comportamentos críticos e manutenção do pipeline verde |
| **Fase do SDLC** | Estágio 3 — Implementação; Estágio 4 — Evolução |
| **Resultado esperado** | Suíte de testes passando, pipeline de CI verde e rastreabilidade spec → teste garantida |

Leia primeiro: [PERSONA.md](PERSONA.md).

---

## Conceito

O QA Engineer (Quality Assurance Engineer) transforma requisitos EARS em testes executáveis. Na modernização do SIFAP, essa persona valida a equivalência funcional entre o comportamento do legado Natural e o código Java 21 moderno, garantindo que cada REQ-ID tenha ao menos um teste verificável e que o pipeline de CI (GitHub Actions) permaneça verde.

Por que importa: testes ausentes ou frágeis deixam o time cego para regressões. Em uma modernização de legado, a equivalência funcional entre o comportamento antigo e o novo só pode ser provada por testes rastreáveis a requisitos.

## Kit da persona

Todos os artefatos ativos vivem na `.github/` da raiz do repositório. Esta pasta é referência; edite os arquivos em `.github/` quando precisar de manutenção.

| Arquivo | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, estágios, prompts e rubricas do QA Engineer |
| `.github/agents/qa-engineer.agent.md` | Agente | Geração de testes, análise de cobertura e gates de qualidade |
| `.github/prompts/persona-qa-engineer-create-tests.prompt.md` | Prompt | `/create-tests` |
| `.github/prompts/persona-qa-engineer-coverage-gaps.prompt.md` | Prompt | `/coverage-gaps` |
| `.github/prompts/persona-qa-engineer-test-strategy.prompt.md` | Prompt | `/test-strategy` |
| `.github/instructions/tests.instructions.md` | Instructions | Convenções de teste |

> [!TIP]
> Se o facilitador pedir MCP local e este kit tiver `mcp.json`, copie apenas esse arquivo para `.vscode/mcp.json`.

## Onde os artefatos ativos vivem

- Agentes: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Boas práticas

- [ ] **Seguir a pirâmide de testes.** Priorizar testes unitários em maior volume, testes de integração em proporção média e testes end-to-end em menor quantidade.
- [ ] **Tratar teste instável como bug.** Isolar, corrigir ou remover; nunca ignorar.
- [ ] **Garantir que toda asserção prove comportamento.** Cobertura de linha sem asserção significativa não valida o domínio.
- [ ] **Rastrear teste ao requisito.** Todo teste deve apontar para um REQ-ID por comentário inline.

## Exemplo aplicado ao SIFAP

No Estágio 2, o QA Engineer valida que cada EARS do `spec.md` tem critério de aceitação testável. No Estágio 3, escreve testes JUnit 5 com Testcontainers para o endpoint `POST /api/v1/beneficios`, verificando os cenários identificados no programa Natural `SIFAP-BEN.NSN`: inclusão válida, duplicata e campos obrigatórios ausentes. Adiciona comentário `// REQ-012` em cada método de teste.

## Referências

- [Google Testing Blog](https://testing.googleblog.com/)
- [xUnit Test Patterns — Gerard Meszaros](http://xunitpatterns.com/)
- [Software Testing ISTQB](https://www.istqb.org/)
- [Property-Based Testing — jqwik/fast-check](https://jqwik.net/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Visão geral das personas](../OVERVIEW.md)<br/><sub>Tabela das 10 personas e seus pares.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha completa da persona QA Engineer.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
