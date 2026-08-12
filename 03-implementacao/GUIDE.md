<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Estágio 3 — Implementação (70 min)



> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 3](README.md) → **GUIDE**

> **Para quem é isto?** Para os pares 3 (TL+Dev) e 4 (DBA+QA) que lideram + par 5 que esqueleta o CI.
>
> **O que você terá ao final desta leitura:**
>
> 1. Backend Java + Spring Boot rodando com Testcontainers
> 2. Frontend Next.js usável com Server Components
> 3. Migração Flyway aplicada
> 4. Cobertura de testes ≥70%
> 5. Cada commit cita `Implements REQ-XXX`

![ESTÁGIO 03 de 04](https://img.shields.io/badge/EST%C3%81GIO-03%20de%2004-7FBA00?style=for-the-badge) ![Duração 70 min](https://img.shields.io/badge/DURA%C3%87%C3%83O-70%20min-737373?style=for-the-badge) ![Líderes Pares 3 e 4](https://img.shields.io/badge/L%C3%8DDERES-Pares%203%20e%204-1A1A1A?style=for-the-badge)

> ⏰ **Cronograma exato** vive em [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §2. Os badges aqui mostram apenas a **duração** do estágio.

> **Categoria:** Implementação · **Quem trabalha agora:** Pares 3 + 4 lideram

> 🧭 **Antes de entrar neste estágio** (1 minuto de leitura):
>
> - **JPA, Flyway, Testcontainers, Server Component, Bean Validation, Swagger** — siglas novas? [`../07-conceitos/03-glossario-visual.md`](../07-conceitos/03-glossario-visual.md).
> - **Antes de implementar:** releia a EARS e as decisões que o seu time produziu no Estágio 2.
> - **Antes de modelar dados:** verifique os DDMs e a rastreabilidade levantada pelo seu time no Estágio 1.
> - **Quando usar Plan vs Agent?** [`../09-cheat-sheets/copilot-3-modes.md`](../09-cheat-sheets/copilot-3-modes.md). Para features pequenas, Plan; Agent fica para o Estágio 4.
> - **Travou no setup?** Vá direto à seção `Troubleshooting` mais abaixo.

## ⛳ Definition of Ready — antes de começar

> [!IMPORTANT]
> Não abra este estágio sem antes confirmar:
>
> - [ ] Estágio 2 terminou (Passagem H2 aceita pelo PO)
> - [ ] Você selecionou **`@builder`** no Copilot Chat
> - [ ] `specs/<NNN>-<feature>/spec.md` tem REQ-IDs com `source_legacy:` válido
> - [ ] `specs/<NNN>-<feature>/plan.md` contém as decisões necessárias para a primeira tarefa
> - [ ] O time definiu os paths iniciais do protótipo (`backend/`, `frontend/` e, se necessário, `infra/`)
> - [ ] Branch `impl/<NNN>-<feature>` criada a partir de `develop` atualizada

## Quem trabalha aqui

![Linha do tempo do dia: pré-evento, 4 estágios e demo, com as três passagens H1, H2, H3](../assets/timeline-stages.svg)

## Objetivo

Criar do zero o primeiro protótipo funcional do SIFAP 2.0 e implementar as features priorizadas no Estágio 2. O kit não traz código-base, containerização pronta ou symlink de protótipo: seu time vai **criar a estrutura, implementar features e escrever testes**. Cada feature precisa rastrear até uma REQ-ID.

## Por que isso importa

O Estágio 3 é onde a spec encontra a realidade. EARS escrita bonita no Estágio 2 fica preto-no-branco aqui: ou o teste passa, ou não passa. **Cada commit traz uma referência `Implements REQ-XXX:` no message.** Sem isso, a rastreabilidade morre e `/speckit.analyze` ajuda a encontrar drift entre spec, tasks e código antes do passagem.

## Como pensar nisso

Pense no protótipo como uma **obra começando pelo alicerce**: a spec e os ADRs dizem o que precisa existir, mas o código nasce agora no repositório do time.

- Crie `backend/` para a aplicação Spring Boot.
- Crie `frontend/` para a aplicação Next.js.
- Crie `infra/` apenas quando o time começar a descrever IaC ou composição local.
- Arquivos de containerização, se necessários, devem ser criados pelo time neste repositório e revisados como código novo.

Sua tarefa: pegar as REQ-IDs do Estágio 2 e transformar cada uma em **endpoint + service + repository + migração + teste**. Não copie um protótipo externo nem ajuste caminhos de um repositório antigo.

---

## Primeiros 15 minutos: criando o esqueleto

### 1. Defina os paths do protótipo

```bash
mkdir -p backend frontend
```

### 2. Crie a estrutura mínima

- Backend: Spring Boot 3.3, Java 21, Maven Wrapper e pacote base `br.gov.sifap`.
- Frontend: Next.js 15 App Router, TypeScript strict e Tailwind CSS.
- Banco: migrações Flyway em `backend/src/main/resources/db/migration/`.

> [!WARNING]
> Não use código ou containerização de protótipos externos. O objetivo do workshop é que o time construa o protótipo moderno a partir da leitura do legado.

### 3. Verifique que o mínimo roda

- Backend: `cd backend && ./mvnw test` deve passar assim que o esqueleto existir.
- Frontend: `cd frontend && npm test` ou o comando equivalente definido pelo time deve passar assim que o esqueleto existir.
- Swagger e frontend local entram no runbook depois que o time criar esses pontos de execução.

### 3. Teste a API no Swagger

Use a autenticação e os contratos configurados pelo próprio time. Exercite apenas
os fluxos que foram implementados e documente a evidência da validação.

---

## Estrutura do Backend

O backend segue a arquitetura que o time documentou, com módulos por funcionalidade
e três camadas cada:

```
src/main/java/br/gov/client/sifap/
│
└── <feature>/
    ├── domain/
    ├── application/
    └── infrastructure/
```

### Camadas (de dentro para fora)

| Camada             | Responsabilidade                                      | Exemplos                                                  |
| ------------------ | ----------------------------------------------------- | --------------------------------------------------------- |
| **domain**         | Regras de negócio puras, sem dependência de framework | Enums de status, interfaces de repositório, value objects |
| **application**    | Casos de uso, orquestração                            | Services, DTOs de Request/Response                        |
| **infrastructure** | Detalhes técnicos, I/O                                | Controllers REST, JPA Entities, Spring Data Repositories  |

### Regra de ouro

A camada `domain` **nunca** importa classes de `infrastructure`. O fluxo é sempre: Controller → Service → Repository (interface em domain, implementação em infrastructure).

---

## Passo a passo: adicionar uma feature

Siga estes passos para cada funcionalidade priorizada:

1. Releia a EARS, a evidência legada e as decisões que o time registrou.
2. Modele o comportamento no contexto e nas camadas que o time definiu.
3. Crie as mudanças de dados necessárias em uma nova migração.
4. Exponha somente os contratos que a EARS exige.
5. Escreva e execute testes para os critérios de aceite definidos pelo time.

> [!CAUTION]
> **Use Flyway. Nunca modifique migrações existentes.** Sempre crie novas (`V2__`, `V3__`, etc.). Editar uma migração antiga corrompe o histórico de schema e quebra deploys.

## Fluxo com Copilot Plan

Para implementar features rapidamente:

1. **Selecione os arquivos relevantes** no VS Code (Ctrl+click)
2. **Abra o Copilot em modo Plan**
3. **Descreva a mudança** em linguagem natural e peça um plano antes da execução:
   > "Planeje a implementação da EARS `REQ-XXX`. Liste os arquivos envolvidos,
   > os riscos e os testes necessários. Não implemente ainda."
4. **Revise o plano e o diff** antes de aceitar — verifique que segue a arquitetura
5. **Rode os testes** para confirmar

---

## Testes

### Rodar todos os testes

```bash
cd backend
./mvnw test
```

### Requisitos

- **Docker precisa estar rodando** — os testes usam Testcontainers para subir um PostgreSQL real
- Java 21 instalado

### Tipos de teste esperados

| Tipo        | Onde                   | O que testa                   |
| ----------- | ---------------------- | ----------------------------- |
| Unit        | `*ServiceTest.java`    | Lógica de negócio isolada     |
| Integration | `*ControllerTest.java` | Endpoint completo (HTTP → DB) |
| Repository  | `*RepositoryTest.java` | Queries customizadas          |

---

## Frontend

### Rodar o frontend localmente

```bash
cd frontend
npm install
npm run dev
```

Abra http://localhost:3000

### Arquitetura do Frontend

O frontend usa **Next.js 15 com App Router** e **Server Components**:

```
src/app/
├── layout.tsx
├── page.tsx
└── <feature>/
    └── page.tsx
```

### Padrão Server Components

- **Server Components** (padrão): buscam dados no servidor, sem JavaScript no cliente
- **Client Components** (`"use client"`): só quando precisa de interatividade (forms, modais)

---

## Rastreabilidade: Requisito → Código → Teste

Para cada feature que você implementa, mantenha rastreabilidade com a spec:

| Requisito EARS | Código | Teste |
| --- | --- | --- |
| `REQ-XXX` | <!-- preencher --> | <!-- preencher --> |

Quando adicionar uma feature, documente no commit: `Implements REQ-XXX`. Isso fecha o ciclo spec → código → teste.

---

## Como manter rastreabilidade

Associe cada mudança à EARS que a motivou, registre os testes que a verificam e
inclua o REQ-ID no commit e no PR. A implementação e os cenários devem vir da
evidência do próprio time.

---

<details>
<summary><strong>Armadilhas comuns</strong> — clique para expandir</summary>

| ❌ Se você está fazendo isso                                         | ✅ Faça assim                                                 |
| -------------------------------------------------------------------- | ------------------------------------------------------------- |
| Branch única gigante de 8 horas                                      | Commits pequenos, PRs pequenos. 1 feature = 1 PR              |
| Implementar sem teste, "depois eu faço"                              | Escreva o teste junto com o código. "Depois" não existe       |
| Editar uma migração Flyway antiga                                    | NUNCA. Sempre nova migração (V5**, V6**...)                   |
| Criar endpoint sem `@Valid` no DTO                                   | Bean Validation no controller. Sempre                         |
| Misturar lógica de domínio no controller                             | Controller chama service. Lógica fica em service ou domain    |
| Importar classes de infraestrutura entre contextos                  | Preserve as fronteiras que o time definiu                      |
| Commit sem `Implements REQ-XXX`                                      | Rastreabilidade é o que valida o trabalho do estágio anterior |

</details>

---

<details>
<summary><strong>Troubleshooting</strong> — clique para expandir</summary>

| Problema                            | Solução                                                                                                             |
| ----------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| Ambiente local não sobe             | Verifique Java 21, Node, variáveis de ambiente e portas 5432/8080/3000 livres                                      |
| Backend não conecta no PostgreSQL   | Verifique a URL configurada e se o Postgres escolhido pelo time está em execução                                   |
| Frontend mostra "Failed to load"    | O backend está rodando? Teste: `curl http://localhost:8080/actuator/health`                                         |
| Login retorna erro de credencial     | Verifique a configuração local e a migração de autenticação criada pelo time                                        |
| Teste falha com Testcontainers      | Docker Desktop precisa estar rodando. Alternativa: unit test com Mockito                                            |
| Migração falha no startup           | NUNCA edite uma migração existente. Crie uma nova (V5**, V6**...)                                                   |
| `mvn test-compile` erro de import   | Verifique que o pacote segue a estrutura: domain/ → application/ → infrastructure/                                  |
| Swagger UI não aparece              | Tente: http://localhost:8080/swagger-ui/index.html (caminho alternativo)                                            |

</details>

---

## Como saber que terminou (Definição de Pronto)

Ao final do Estágio 3, seu time deve ter:

- [ ] Fluxo priorizado pelo time está implementado e documentado
- [ ] Interface necessária para esse fluxo está disponível
- [ ] Testes definidos pelo time passam
- [ ] Modo de execução local documentado no próprio protótipo — qualquer revisor consegue subir
- [ ] Contratos expostos estão documentados
- [ ] Regra priorizada do Estágio 1 está implementada e testada
- [ ] Todos os commits têm `Implements REQ-XXX` no message

## Próximo passo

No Passagem #3 (~17:00), o **Par 3 (Implementação)** entrega o código rodando para o **Par 5 (Operações)**, que vai cuidar de Terraform e CI/CD no Estágio 4. O Par 4 (Qualidade) continua os testes finais. Veja [`../04-evolucao/GUIDE.md`](../04-evolucao/GUIDE.md).

<details>
<summary><strong>Prompts úteis para Copilot Chat</strong> — clique para expandir</summary>

1. _"Crie um endpoint REST para [funcionalidade] seguindo a arquitetura existente."_
2. _"Escreva um teste de integração para o endpoint [endpoint]."_
3. _"Adicione Bean Validation ao DTO [classe]."_
4. _"Crie uma migração Flyway para adicionar [tabela/coluna]."_
5. _"Implemente a regra de negócio BR-XXX: [descrição da regra]."_
6. _"Crie um React Server Component para listar [entidade]."_
7. _"Adicione tratamento de erro para o caso de [cenário]."_
8. _"Refatore este service para separar a lógica de [responsabilidade]."_

</details>

## Dica de ouro

> [!TIP]
> Não tente implementar tudo. Foque em **qualidade sobre quantidade**. Um endpoint bem feito — com testes, validação e documentação — vale mais que 5 endpoints quebrados.

---

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="../02-spec-moderna/GUIDE.md"><strong>Estágio 2 — Spec Moderna</strong></a><br/>
<sub>14:00–15:00 · Escrever EARS, ADRs e diagramas C4.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="../04-evolucao/GUIDE.md"><strong>Estágio 4 — Evolução</strong></a><br/>
<sub>16:10–16:50 · Copilot Agent + Terraform + CI/CD.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>

— Paula
