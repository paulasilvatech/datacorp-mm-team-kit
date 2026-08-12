# Instruções do GitHub Copilot — Workshop de Modernização de Legado

> Estas instruções dizem ao Copilot o que sua equipe está construindo, qual stack usar,
> quais convenções seguir e o que NÃO fazer. Elas se aplicam a todo o repositório
> da equipe.

## Ferramentas Aprovadas — Somente Estas

Este workshop roda com uma **toolchain fixa**. Usar qualquer outra coisa fragmenta a equipe e quebra as demos.

| Use estas | Por quê |
|-----------|-----|
| **VS Code** (ou VS Code Insiders) | Editor único para toda a equipe. |
| **GitHub Copilot** (modos Ask + Plan + Agent) | Assistente de IA principal. Copilot Workspace também é permitido para delegação Issue → PR. |
| **GitHub Copilot CLI** *(opcional)* | Para tarefas em fluxo de terminal. |
| **GitHub Spec-Kit** (`Specify CLI` + `/speckit.*`) | Toolkit oficial de Spec-Driven Development para especificação, planejamento, tarefas e implementação. |
| **GitHub** (Issues, PRs, Actions, Projects) | Fonte da verdade para trabalho, código e CI. |
| **Docker / Docker Compose** | Paridade do ambiente local quando o time criar containers no próprio protótipo. |
| **Terraform** | IaC (Azure provider). |

**Não use** outros assistentes de IA (Cursor, Windsurf, Codex, Cline, Continue, Aider, Codeium, Tabnine), IDEs alternativos (IntelliJ, Eclipse, Neovim), UIs web de chat para gerar código, nem frameworks SDD alternativos (Kiro etc.). Misturar ferramentas quebra rastreabilidade spec → code → test.

## Contexto do Projeto

Modernização do legado **SIFAP** (Sistema de Fiscalização e Administração de Pagamentos) — Natural/Adabas, 29 anos — para Java 21 + Next.js 15. Código legado em [`01-arqueologia/legado-sifap/`](../01-arqueologia/legado-sifap/) (15 programas `.NSN` + 4 DDMs).

O kit usa **duas camadas de agentes** (persona-kit por pessoa + agente de estágio por equipe). Detalhes em [`06-agentes-de-estagio/README.md`](../06-agentes-de-estagio/README.md).

Use as skills em [`.github/skills/`](skills/) para workflows especializados. O Copilot seleciona a skill pertinente pela descrição; não duplique fluxos especializados nestas instruções globais.

## Stack-Alvo

- **Backend:** Java 21 + Spring Boot 3.3 + JPA/Hibernate + PostgreSQL 16
- **Frontend:** Next.js 15 (App Router) + TypeScript 5 (strict) + Tailwind CSS + shadcn/ui
- **Containers:** Docker + Docker Compose criados pelo time no Estágio 3/4, quando necessário
- **IaC:** Terraform (Azure provider ~> 3.x)
- **CI/CD:** GitHub Actions
- **Testing:** JUnit 5 + Testcontainers (backend); Vitest + Testing Library (frontend)

## Regras de Geração de Código

### Java
- Use recursos do Java 21: records para DTOs, sealed interfaces para uniões discriminadas, pattern matching, virtual threads
- Use `Optional` corretamente — nunca retorne `null` de métodos públicos
- `@Transactional` somente na camada de service, nunca em repositories
- Valide entradas na camada de controller com `@Valid` + Bean Validation
- Nomes de classes em inglês; comentários em inglês
- Testes unitários são obrigatórios para lógica de negócio
- Nunca exponha dados sensíveis (CPF, valores de benefício) em logs — mascare-os

### TypeScript / Next.js
- `strict: true` em `tsconfig.json` — sem exceções
- Use server actions para mutations; nunca exponha secrets em client components
- Prefira `async/await` a cadeias `.then()`
- Somente named exports — sem default exports em arquivos de componentes

### REST APIs
- Convenção de path: `/api/v1/{resource}`
- Use verbos HTTP corretamente (`GET`, `POST`, `PUT`, `PATCH`, `DELETE`)
- Retorne status codes apropriados (`201` para criação, `204` para sem conteúdo, `409` para conflito)
- Todos os endpoints devem ter annotations OpenAPI/Swagger

### Terraform
- Todo recurso deve ter `tags` incluindo `project`, `environment`, `owner`
- Secrets somente via `azurerm_key_vault_secret` — nunca em `locals` ou `variables`
- Um módulo por área de serviço Azure (networking, compute, database, monitoring)
- `terraform fmt` e `terraform validate` devem passar antes do commit

## Regras de Segurança (OWASP Top 10)

- Valide entradas em toda fronteira do sistema
- Nunca faça hardcode de secrets, API keys ou credenciais
- Consultas SQL somente via JPA/JPQL — sem concatenação de strings
- CORS configurado explicitamente — sem wildcard `*` em produção
- Autenticação via OAuth2/JWT (Spring Security no backend)
- Todos os recursos Azure usam Managed Identity para autenticação serviço-a-serviço

## Spec-Driven Development (Spec-Kit)

- Todo requisito usa **notação EARS** (Easy Approach to Requirements Syntax)
- Todo requisito tem um **REQ-ID** único no formato `REQ-NNN`
- **Todo requisito carrega uma linha `source_legacy:`** apontando para `01-arqueologia/legado-sifap/natural-programs/*.NSN`, `01-arqueologia/legado-sifap/adabas-ddms/*.ddm` ou `[GREENFIELD] + justificativa`. O job de CI `legacy-traceability` rejeita PRs que violam isso. Consulte [`01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md`](../01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md).
- Testes rastreiam para REQ-IDs por comentários inline
- Estratégia de branch: `spec/<NNN>-<feature>` → `develop` → `main` (sem `stage`; ver [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md))
- Antes de escrever EARS no Estágio 2, o par DEVE ter lido os programas Natural atribuídos (HARD GATE — ver checklist acima)

## Regras Rígidas — Não Faça Isto

- ❌ Não assuma protótipo pré-existente, symlink de protótipo ou containerização herdada. O time deve criar `backend/`, `frontend/` e, quando necessário, `infra/` do zero a partir da spec.
- ❌ Não escreva um EARS sem `source_legacy:` — o CI rejeitará o PR
- ❌ Não adicione dependências sem justificativa em um ADR
- ❌ Não escreva testes depois do fato — escreva-os enquanto implementa
- ❌ Não exponha secrets em mensagens de commit, logs ou descrições de PR
- ❌ Não faça merge em `main` sem pelo menos uma revisão entre pares
- ❌ Não pule as conversas guiadas de passagem nas transições de estágio (veja [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md))

## Referências

- Cronograma + pares: [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md)
- Git workflow: [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md)
- 3 modos do Copilot (Ask · Plan · Agent): [`09-cheat-sheets/copilot-3-modes.md`](../09-cheat-sheets/copilot-3-modes.md)
- Persona kits (leia 2 por pessoa; artefatos ativos já consolidados em `.github/`): [`05-personas/`](../05-personas/)
- Agentes de estágio: [`06-agentes-de-estagio/`](../06-agentes-de-estagio/)
- Legado SIFAP: [`01-arqueologia/legado-sifap/`](../01-arqueologia/legado-sifap/)
- Protótipo moderno: criado pelo time durante o Estágio 3 em `backend/`, `frontend/` e, se necessário, `infra/`; não há código-base pré-pronto para copiar.
- Spec-Kit SDD: <https://github.com/github/spec-kit>
