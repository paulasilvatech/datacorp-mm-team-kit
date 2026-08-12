<!-- markdownlint-disable MD013 MD033 MD041 -->

# Tech Writer — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **Tech Writer**

**Kit de referência para a persona Tech Writer no workshop de modernização do SIFAP.**

![Persona](https://img.shields.io/badge/Persona-Tech%20Writer-171717?style=flat-square) ![Par 5](https://img.shields.io/badge/Par-5%20%C2%B7%20Opera%C3%A7%C3%B5es-404040?style=flat-square) ![Transversal](https://img.shields.io/badge/Atua%C3%A7%C3%A3o-Transversal-737373?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que ocupa a persona Tech Writer no workshop |
| **Foco** | Documentação de API, README evolutivo, `CODEMAP.md`, ADRs, changelog e detecção de drift |
| **Fase do SDLC** | Transversal (todos os estágios); lidera Estágio 4 — Evolução (relatório do Agent) |
| **Resultado esperado** | README populado, ADRs formalizados, glossário consistente e relatório honesto do Estágio 4 |

Leia primeiro: [PERSONA.md](PERSONA.md).

---

## Conceito

O Tech Writer (Technical Writer) transforma decisões e código em memória durável para o projeto. Na modernização do SIFAP, essa persona mantém o glossário de termos do legado Natural/Adabas, formaliza as decisões arquiteturais em ADRs (Architecture Decision Records — registros formais de decisão) e garante que o README reflita o estado real da aplicação a cada hora do workshop, não apenas no final.

Por que importa: sem documentação deliberada, ADRs ficam vazios, o README permanece em "TODO: add instructions" e o conhecimento descoberto no dia desaparece após o workshop. O Tech Writer é a persona que torna o aprendizado do time rastreável.

## Kit da persona

Todos os artefatos ativos vivem na `.github/` da raiz do repositório. Esta pasta é referência; edite os arquivos em `.github/` quando precisar de manutenção.

| Arquivo | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, estágios, prompts e rubricas do Tech Writer |
| `.github/agents/tech-writer.agent.md` | Agente | Documentação de API, README, `CODEMAP.md`, changelog e detecção de drift |
| `.github/prompts/persona-tech-writer-generate-docs.prompt.md` | Prompt | `/generate-docs` |
| `.github/prompts/persona-tech-writer-update-codemap.prompt.md` | Prompt | `/update-codemap` |
| `.github/prompts/persona-tech-writer-doc-drift.prompt.md` | Prompt | `/doc-drift` |

> [!TIP]
> Se o facilitador pedir MCP local e este kit tiver `mcp.json`, copie apenas esse arquivo para `.vscode/mcp.json`.

## Onde os artefatos ativos vivem

- Agentes: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Boas práticas

- [ ] **Tratar documentação como funcionalidade.** Entregar, versionar e revisar junto com o código — não após.
- [ ] **Começar pela resposta, depois dar contexto.** Escreva para quem tem 30 segundos.
- [ ] **Usar Mermaid para diagramas.** Diagramas como código ficam atualizados junto com o sistema.
- [ ] **Incluir verificação de drift no CI.** Documentação obsoleta é pior que ausência.

## Exemplo aplicado ao SIFAP

No Estágio 1, o Tech Writer documenta os termos `MU` (campo de múltiplo valor), `PE` (campo periódico) e `FDT` (File Definition Table) no glossário, para que todo o time use a mesma terminologia. No Estágio 3, atualiza o `README.md` com os endpoints reais criados pelo Developer (`POST /api/v1/beneficios`, `GET /api/v1/fiscalizacoes/{id}`) e os comandos para subir o ambiente local. No Estágio 4, acompanha o Agent e escreve o `agent-experience-report.md` em tempo real.

## Referências

- [Diátaxis Framework](https://diataxis.fr/)
- [Google Developer Documentation Style Guide](https://developers.google.com/style)
- [Write the Docs](https://www.writethedocs.org/)
- [Mermaid — Diagramming as Code](https://mermaid.js.org/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Visão geral das personas](../OVERVIEW.md)<br/><sub>Tabela das 10 personas e seus pares.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha completa da persona Tech Writer.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>

