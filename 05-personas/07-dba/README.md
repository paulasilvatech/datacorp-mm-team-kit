<!-- markdownlint-disable MD013 MD033 MD041 -->

# DBA — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **DBA**

**Kit de referência para a persona DBA no workshop de modernização do SIFAP.**

![Persona](https://img.shields.io/badge/Persona-DBA-171717?style=flat-square) ![Par 4](https://img.shields.io/badge/Par-4%20%C2%B7%20Qualidade-404040?style=flat-square) ![Estágio 3](https://img.shields.io/badge/Est%C3%A1gio-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-737373?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que ocupa a persona DBA no workshop |
| **Foco** | Modelagem de dados, migrações Flyway, otimização de consultas, auditoria contra SQL injection |
| **Fase do SDLC** | Estágio 3 — Implementação (schema + migrações) |
| **Resultado esperado** | Schema PostgreSQL 16 consistente com entidades JPA e dados de teste (seed) |

Leia primeiro: [PERSONA.md](PERSONA.md).

---

## Conceito

O DBA (Database Administrator) é responsável pela camada de dados do SIFAP 2.0. Na modernização do legado, isso significa traduzir os 4 DDMs Adabas (com seus campos MU — múltiplo valor — e PE — periódico) para um schema relacional normalizado no PostgreSQL 16, escrever migrações Flyway idempotentes e proteger a integridade dos dados ao longo de todo o projeto.

Por que importa: o modelo de dados é a fundação sobre a qual o Developer escreve as entidades JPA e o DevOps provisiona a infraestrutura. Um schema frágil ou migrações não-reversíveis comprometem todo o Estágio 3.

## Kit da persona

Todos os artefatos ativos vivem na `.github/` da raiz do repositório. Esta pasta é referência; edite os arquivos em `.github/` quando precisar de manutenção.

| Arquivo | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, estágios, prompts e rubricas do DBA |
| `.github/agents/dba.agent.md` | Agente | Modelagem de dados, migrações e auditoria SQL |
| `.github/prompts/persona-dba-migration.prompt.md` | Prompt | `/migration` |
| `.github/prompts/persona-dba-query-audit.prompt.md` | Prompt | `/query-audit` |
| `.github/instructions/database.instructions.md` | Instructions | Convenções de banco de dados |

> [!TIP]
> Se o facilitador pedir MCP local e este kit tiver `mcp.json`, copie apenas esse arquivo para `.vscode/mcp.json`.

## Onde os artefatos ativos vivem

- Agentes: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Boas práticas

- [ ] **Medir impacto de índices nos dois sentidos.** Índices aceleram leituras e desaceleram escritas; meça os dois lados antes de criar.
- [ ] **Usar estratégia expand-contract em migrações.** As mudanças de schema devem ser compatíveis por pelo menos dois deploys consecutivos.
- [ ] **Detectar consultas N+1 antes de staging.** São bugs de performance, não melhorias opcionais.
- [ ] **Validar backups com restore.** Backup que nunca foi restaurado não é backup confiável.

## Exemplo aplicado ao SIFAP

No Estágio 1, o DBA lê o DDM `SIFAP-BEN.ddm` e mapeia os campos MU de beneficiários para tabelas relacionadas candidatas. No Estágio 3, escreve `V2__create_beneficiarios.sql` com Flyway, define índices nos campos que aparecem em `WHERE` das queries críticas do ciclo mensal e popula `src/test/resources/seed.sql` para os testes de integração do QA Engineer.

## Referências

- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Use the Index, Luke — Markus Winand](https://use-the-index-luke.com/)
- [High Performance MySQL / PostgreSQL — Schwartz et al.](https://www.oreilly.com/)
- [Azure Database for PostgreSQL Best Practices](https://learn.microsoft.com/azure/postgresql/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Visão geral das personas](../OVERVIEW.md)<br/><sub>Tabela das 10 personas e seus pares.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha completa da persona DBA.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>

