<!-- markdownlint-disable MD013 MD033 MD041 -->

# Estágio 3 — Implementação (70 min)

> **Trilha:** [Kit do Time](../README.md) › [Estágio 3](README.md) › **GUIDE**

**Este guia conduz os Pares 3 e 4 na construção do protótipo funcional do SIFAP 2.0: do esqueleto inicial até features implementadas com testes, migrações e rastreabilidade a REQ-IDs.**

![Estágio 3](https://img.shields.io/badge/Est%C3%A1gio-3%20%C2%B7%20Implementa%C3%A7%C3%A3o-171717?style=flat-square) ![Duração 70 min](https://img.shields.io/badge/Dura%C3%A7%C3%A3o-70%20min-737373?style=flat-square) ![Horário 15h00–16h10](https://img.shields.io/badge/Hor%C3%A1rio-15h00--16h10-A3A3A3?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Par 3 (TL + Developer) e Par 4 (DBA + QA) lideram; Par 5 esqueleta o CI |
| **Pré-requisitos** | Passagem de bastão H2 aceita; `spec.md`, `plan.md` e `tasks.md` prontos com REQ-IDs e `source_legacy:` |
| **Tempo estimado** | 70 min |
| **Estágio** | Estágio 3 — Implementação |
| **Resultado esperado** | Backend e frontend funcionais; testes passando; commits com `Implements REQ-XXX` |

> [!IMPORTANT]
> Cronograma exato em [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md). Os badges mostram apenas a duração do estágio.

---

## Conceito: Modular Monolith

Modular Monolith é uma arquitetura onde bounded contexts são módulos Java independentes dentro de uma única JVM, com fronteiras explícitas entre eles. É o ponto de partida recomendado para a modernização do SIFAP antes de uma eventual extração de microsserviços.

**Por que importa:** o SIFAP legado tem acoplamento implícito entre módulos através de memória compartilhada (Natural/Adabas). O Modular Monolith torna esse acoplamento explícito e controlado — cada módulo expõe apenas a interface que os outros precisam conhecer.

**Strangler Fig:** padrão de migração que envolve o legado gradualmente. O protótipo do Estágio 3 não precisa substituir o SIFAP inteiro: modernize um bounded context por vez, mantendo o legado ativo para as partes ainda não migradas.

---

## Conceito: Testcontainers

Testcontainers é uma biblioteca Java que sobe containers Docker reais durante os testes. Em vez de simular o PostgreSQL com um banco em memória (H2), o teste usa o banco de produção real.

**Por que importa:** testes contra H2 passam mas falham em PostgreSQL por diferenças de SQL, tipos e comportamento de transação. Testcontainers elimina essa divergência.

**Erro comum:** esquecer de iniciar o Docker Desktop antes de rodar `./mvnw test`. O erro será `Could not find a valid Docker environment`.

---

## Conceito: TDD (Test-Driven Development)

TDD é a prática de escrever o teste antes da implementação. O ciclo é: escrever um teste que falha (vermelho), implementar o código mínimo para passar (verde), melhorar o código sem quebrar o teste (refatorar).

**No SIFAP:** antes de implementar o cálculo de reajuste de benefício (REQ-042), escreva um teste que valide os critérios de aceite definidos no `spec.md`. O teste falhará até que a lógica seja implementada.

---

## Definition of Ready — antes de começar

> [!IMPORTANT]
> Confirme todos os itens antes de abrir este estágio:

- [ ] Passagem de bastão H2 aceita pelo PO.
- [ ] Persona `@builder` selecionada no Copilot Chat.
- [ ] `specs/<NNN>-<feature>/spec.md` tem REQ-IDs com `source_legacy:` válido.
- [ ] `specs/<NNN>-<feature>/plan.md` contém as decisões necessárias para a primeira tarefa.
- [ ] O time definiu os paths iniciais do protótipo (`backend/`, `frontend/` e, se necessário, `infra/`).
- [ ] Branch `impl/<NNN>-<feature>` criada a partir de `develop` atualizada.

---

## Objetivo

Criar do zero o primeiro protótipo funcional do SIFAP 2.0 e implementar as features priorizadas no Estágio 2. O kit não traz código-base, containerização pronta ou symlink de protótipo: o time cria a estrutura, implementa features e escreve testes. Cada feature precisa rastrear até uma REQ-ID.

O Estágio 3 é onde a spec encontra a realidade. Uma EARS bem escrita no Estágio 2 se torna um teste que passa ou não passa. Cada commit traz uma referência `Implements REQ-XXX:` no message. Sem isso, a rastreabilidade morre.

---

## Primeiros 15 minutos: criando o esqueleto

### Passo 1 — Criar as pastas do protótipo

```bash
mkdir -p backend frontend
```

### Passo 2 — Criar a estrutura mínima

- **Backend:** Spring Boot 3.3, Java 21, Maven Wrapper e pacote base `br.gov.sifap`.
- **Frontend:** Next.js 15 App Router, TypeScript strict e Tailwind CSS.
- **Banco:** migrações Flyway em `backend/src/main/resources/db/migration/`.

> [!CAUTION]
> Não use código ou containerização de protótipos externos. O objetivo do workshop é que o time construa o protótipo moderno a partir da leitura do legado.

### Passo 3 — Verificar que o mínimo roda

- Backend: `cd backend && ./mvnw test` deve passar assim que o esqueleto existir.
- Frontend: `cd frontend && npm test` (ou o comando definido pelo time) deve passar.
- Crie `infra/` apenas quando o time começar a descrever IaC ou composição local.

---

## Estrutura do backend

```text
src/main/java/br/gov/client/sifap/
└── <feature>/
    ├── domain/
    ├── application/
    └── infrastructure/
```

### Camadas (de dentro para fora)

| Camada | Responsabilidade | Exemplos |
|---|---|---|
| **domain** | Regras de negócio puras, sem dependência de framework | Enums de status, interfaces de repositório, value objects |
| **application** | Casos de uso, orquestração | Services, DTOs de Request/Response |
| **infrastructure** | Detalhes técnicos, I/O | Controllers REST, JPA Entities, Spring Data Repositories |

> [!IMPORTANT]
> A camada `domain` nunca importa classes de `infrastructure`. O fluxo é sempre: Controller → Service → Repository (interface em domain, implementação em infrastructure).

---

## Passo a passo: adicionar uma feature

- [ ] **Reler a EARS.** Abra o `spec.md` e releia a REQ-ID que será implementada.
- [ ] **Verificar a evidência legada.** Confirme o `source_legacy:` e releia o programa `.NSN` correspondente.
- [ ] **Modelar o comportamento.** Defina a entidade, os casos de uso e os contratos REST no contexto certo.
- [ ] **Criar a migração Flyway.** Adicione o arquivo `V<N>__descricao.sql` em `db/migration/`.
- [ ] **Escrever o teste primeiro.** Crie o teste de integração antes de implementar (TDD).
- [ ] **Implementar o código.** Controller → Service → Repository, seguindo as camadas.
- [ ] **Executar os testes.** `./mvnw test` deve passar com Docker rodando.
- [ ] **Fazer o commit.** Inclua `Implements REQ-XXX` no message.

> [!CAUTION]
> Use Flyway. Nunca modifique migrações existentes. Sempre crie novas (`V2__`, `V3__`, etc.). Editar uma migração antiga corrompe o histórico de schema e quebra deploys.

---

## Fluxo com Copilot Plan

Para implementar features com rastreabilidade:

1. Selecione os arquivos relevantes no VS Code (Ctrl+click).
2. Abra o Copilot em modo Plan.
3. Descreva a mudança em linguagem natural e peça um plano antes da execução:
   > "Planeje a implementação da EARS `REQ-XXX`. Liste os arquivos envolvidos, os riscos e os testes necessários. Não implemente ainda."
4. Revise o plano e o diff antes de aceitar — verifique que segue a arquitetura.
5. Execute os testes para confirmar.

> [!TIP]
> Para features pequenas, prefira o modo Plan. O modo Agent do Copilot é mais adequado para o Estágio 4, onde há maior autonomia de escopo.

---

## Testes

### Executar todos os testes

```bash
cd backend
./mvnw test
```

**Pré-requisito:** Docker precisa estar rodando — os testes usam Testcontainers para subir um PostgreSQL real.

### Tipos de teste esperados

| Tipo | Classe | O que testa |
|---|---|---|
| Unit | `*ServiceTest.java` | Lógica de negócio isolada |
| Integration | `*ControllerTest.java` | Endpoint completo (HTTP → DB) |
| Repository | `*RepositoryTest.java` | Queries customizadas |

---

## Frontend

### Executar o frontend localmente

```bash
cd frontend
npm install
npm run dev
```

Acesse `http://localhost:3000`.

### Arquitetura do frontend

O frontend usa Next.js 15 com App Router e Server Components:

```text
src/app/
├── layout.tsx
├── page.tsx
└── <feature>/
    └── page.tsx
```

| Tipo de componente | Quando usar |
|---|---|
| **Server Component** (padrão) | Busca de dados no servidor; sem JavaScript no cliente |
| **Client Component** (`"use client"`) | Interatividade: formulários, modais, estado local |

---

## Rastreabilidade: requisito → código → teste

Para cada feature implementada, documente a rastreabilidade:

| Requisito EARS | Arquivo de implementação | Arquivo de teste |
|---|---|---|
| `REQ-XXX` | `<!-- preencher -->` | `<!-- preencher -->` |

Cada commit que implementa um comportamento da spec deve ter `Implements REQ-XXX` no message. Isso fecha o ciclo spec → código → teste e permite que `/speckit.analyze` detecte drift.

---

<details>
<summary><strong>Armadilhas comuns — clique para expandir</strong></summary>

| Se você está fazendo isso | Faça assim |
|---|---|
| Branch única gigante de 8 horas | Commits pequenos, PRs pequenos. 1 feature = 1 PR |
| Implementar sem teste, "depois eu faço" | Escreva o teste junto com o código |
| Editar uma migração Flyway antiga | Nunca. Sempre crie nova migração (`V5__`, `V6__`...) |
| Criar endpoint sem `@Valid` no DTO | Bean Validation no controller, sempre |
| Misturar lógica de domínio no controller | Controller chama service. Lógica fica em service ou domain |
| Importar classes de infraestrutura entre contextos | Preserve as fronteiras definidas pelo time |
| Commit sem `Implements REQ-XXX` | Rastreabilidade é o que valida o trabalho do estágio anterior |

</details>

---

<details>
<summary><strong>Troubleshooting — clique para expandir</strong></summary>

| Problema | Solução |
|---|---|
| Ambiente local não sobe | Verifique Java 21, Node, variáveis de ambiente e portas 5432/8080/3000 livres |
| Backend não conecta no PostgreSQL | Verifique a URL configurada e se o Postgres escolhido pelo time está em execução |
| Frontend mostra "Failed to load" | O backend está rodando? Teste: `curl http://localhost:8080/actuator/health` |
| Teste falha com Testcontainers | Docker Desktop precisa estar rodando. Alternativa: unit test com Mockito |
| Migração falha no startup | Nunca edite uma migração existente. Crie uma nova (`V5__`, `V6__`...) |
| `mvn test-compile` erro de import | Verifique que o pacote segue: `domain/` → `application/` → `infrastructure/` |
| Swagger UI não aparece | Tente: `http://localhost:8080/swagger-ui/index.html` |

</details>

---

## Critérios de conclusão

- [ ] Fluxo priorizado pelo time está implementado e documentado.
- [ ] Interface necessária para esse fluxo está disponível.
- [ ] Testes definidos pelo time passam com `./mvnw test`.
- [ ] Modo de execução local documentado no próprio protótipo.
- [ ] Contratos expostos estão documentados (Swagger/OpenAPI).
- [ ] Regra priorizada do Estágio 1 está implementada e testada.
- [ ] Todos os commits têm `Implements REQ-XXX` no message.

---

## Próximo passo

Na passagem de bastão H3 (~17:00), o Par 3 entrega o código funcionando para o Par 5 (Operações), que cuida de Terraform e CI/CD no Estágio 4. O Par 4 continua os testes finais.

Consulte [`../04-evolucao/GUIDE.md`](../04-evolucao/GUIDE.md) para o próximo estágio.

---

<details>
<summary><strong>Prompts úteis para Copilot Chat — clique para expandir</strong></summary>

1. "Crie um endpoint REST para [funcionalidade] seguindo a arquitetura existente."
2. "Escreva um teste de integração para o endpoint [endpoint]."
3. "Adicione Bean Validation ao DTO [classe]."
4. "Crie uma migração Flyway para adicionar [tabela/coluna]."
5. "Implemente a regra de negócio BR-XXX: [descrição da regra]."
6. "Crie um React Server Component para listar [entidade]."
7. "Adicione tratamento de erro para o caso de [cenário]."
8. "Refatore este service para separar a lógica de [responsabilidade]."

</details>

> [!TIP]
> Não tente implementar tudo. Foque em qualidade sobre quantidade. Um endpoint bem feito — com testes, validação e documentação — vale mais que cinco endpoints quebrados.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Estágio 2 — Especificação](../02-spec-moderna/GUIDE.md)<br/><sub>14:00–15:00 · Escrever EARS, ADRs e diagramas C4.</sub> | [Estágio 4 — Evolução](../04-evolucao/GUIDE.md)<br/><sub>16:10–16:50 · Copilot Agent + Terraform + CI/CD.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
