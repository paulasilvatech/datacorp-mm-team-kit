<!-- markdownlint-disable MD013 MD033 MD041 -->

# DevOps Engineer — Kit Copilot

> **Trilha:** [Kit do Time](../../README.md) › [Personas](../OVERVIEW.md) › **DevOps Engineer**

**Kit de referência para a persona DevOps Engineer no workshop de modernização do SIFAP.**

![Persona](https://img.shields.io/badge/Persona-DevOps%20Engineer-171717?style=flat-square) ![Par 5](https://img.shields.io/badge/Par-5%20%C2%B7%20Opera%C3%A7%C3%B5es-404040?style=flat-square) ![Estágio 4](https://img.shields.io/badge/Est%C3%A1gio-4%20%C2%B7%20Evolu%C3%A7%C3%A3o-737373?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa que ocupa a persona DevOps Engineer no workshop |
| **Foco** | Pipelines CI/CD com GitHub Actions, infraestrutura como código com Terraform (Azure), observabilidade e resposta a incidentes |
| **Fase do SDLC** | Transversal — Estágios 1 a 4; lidera Estágio 4 — Evolução |
| **Resultado esperado** | Pipeline verde, build reproduzível, `terraform plan` válido e modo de execução local documentado |

Leia primeiro: [PERSONA.md](PERSONA.md).

---

## Conceito

O DevOps Engineer é responsável pelo caminho do código desde o commit até algo que executa de forma confiável. No workshop de modernização do SIFAP, essa persona garante que qualquer máquina do time consiga subir o ambiente local, que o GitHub Actions valide cada PR e que o Terraform descreva a topologia-alvo no Azure mesmo quando não é aplicado no dia.

Por que importa: sem um pipeline confiável, o Developer não tem feedback rápido, o QA Engineer não tem ambiente estável para testes e a demonstração final arrisca falhar por problema de ambiente, não de código.

## Kit da persona

Todos os artefatos ativos vivem na `.github/` da raiz do repositório. Esta pasta é referência; edite os arquivos em `.github/` quando precisar de manutenção.

| Arquivo | Tipo | Propósito |
|---|---|---|
| `PERSONA.md` | Ficha | Responsabilidades, estágios, prompts e rubricas do DevOps Engineer |
| `.github/agents/devops-engineer.agent.md` | Agente | CI/CD, infraestrutura como código, monitoramento e incidentes |
| `.github/prompts/persona-devops-engineer-pipeline.prompt.md` | Prompt | `/pipeline` |
| `.github/prompts/persona-devops-engineer-iac-module.prompt.md` | Prompt | `/iac-module` |
| `.github/prompts/persona-devops-engineer-incident-rca.prompt.md` | Prompt | `/incident-rca` |
| `.github/instructions/cicd.instructions.md` | Instructions | Convenções de CI/CD |
| `.github/instructions/infrastructure.instructions.md` | Instructions | Convenções de infraestrutura |

> [!TIP]
> Se o facilitador pedir MCP local e este kit tiver `mcp.json`, copie apenas esse arquivo para `.vscode/mcp.json`.

## Onde os artefatos ativos vivem

- Agentes: `.github/agents/`
- Prompts: `.github/prompts/persona-*.prompt.md`
- Skills: `.github/skills/`
- Instructions: `.github/instructions/`

## Boas práticas

- [ ] **Tratar tudo como código.** Infraestrutura, configuração, políticas e runbooks devem estar versionados.
- [ ] **Manter pipelines abaixo de 10 minutos.** Pipelines mais longos se tornam gargalo; paralelizar ou eliminar etapas redundantes.
- [ ] **Armazenar secrets exclusivamente em vault.** Nunca em `.env` versionado, variáveis soltas de CI ou código-fonte.
- [ ] **Escolher estratégia de deploy pelo custo de rollback.** Blue/green e canary resolvem problemas diferentes.

## Exemplo aplicado ao SIFAP

No Estágio 3, o DevOps Engineer cria o workflow `.github/workflows/ci.yml` que executa em cada push: configura Java 21 com cache do Maven, roda `mvn test`, constrói a imagem Docker do backend e publica no registro. Paralelamente, escreve os módulos Terraform `infra/networking/` e `infra/database/` que descrevem o Azure Database for PostgreSQL e a VNet de destino. O `terraform plan` roda sem erro mesmo que o `apply` não aconteça no dia.

## Referências

- [Terraform Best Practices](https://developer.hashicorp.com/terraform/language/style)
- [GitHub Actions Hardening](https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions)
- [Azure Verified Modules](https://azure.github.io/Azure-Verified-Modules/)
- [The DevOps Handbook — Gene Kim et al.](https://itrevolution.com/product/the-devops-handbook-second-edition/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Visão geral das personas](../OVERVIEW.md)<br/><sub>Tabela das 10 personas e seus pares.</sub> | [PERSONA.md](PERSONA.md)<br/><sub>Ficha completa da persona DevOps Engineer.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
