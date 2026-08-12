<!-- markdownlint-disable MD013 MD033 MD041 -->

# Guia de Setup — Do Zero ao Código

> **Trilha:** [Kit do Time](README.md) › **Setup**

**Leva você de "ainda não temos nada" até "repositório criado, Copilot funcionando, todas as personas prontas" em 45 minutos.**

![Setup](https://img.shields.io/badge/Setup-00-171717?style=flat-square) ![Duração 45 min](https://img.shields.io/badge/Dura%C3%A7%C3%A3o-45%20min-737373?style=flat-square) ![Quando Antes do Dia 2](https://img.shields.io/badge/QUANDO-Antes%20do%20Dia%202-A3A3A3?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Líder do time + cada membro no próprio laptop |
| **Pré-requisitos** | Conta GitHub com Copilot ativo |
| **Tempo estimado** | 45 minutos |
| **Resultado esperado** | Repositório protegido, Copilot ativo, personas validadas, smoke test verde |

> [!WARNING]
> **Usuários de Windows:** os blocos de terminal com heredoc ou `for` assumem **Git Bash** ou **WSL**. Não use PowerShell ou CMD nesses blocos.

**Vocês são 5 pessoas. Cada pessoa usa 2 personas. Vocês têm um dia de trabalho.** Todas as pessoas do time acompanham no próprio laptop. Uma pessoa compartilha a tela com os passos e as outras 4 repetem. Ao final, cada laptop estará totalmente configurado.

## Sumário

- [Antes de Começar — Modelo Mental](#antes-de-começar--modelo-mental)
- [Passo 1 — Verifique os pré-requisitos do laptop](#passo-1--verifique-os-pré-requisitos-do-laptop)
- [Passo 2 — Crie o repositório do time pelo template (somente líder)](#passo-2--crie-o-repositório-do-time-pelo-template-somente-líder)
- [Passo 3 — Clone o repositório e crie `develop` (somente líder)](#passo-3--clone-o-repositório-e-crie-develop-somente-líder)
- [Passo 4 — Proteja a branch `main` (somente líder)](#passo-4--proteja-a-branch-main-somente-líder)
- [Passo 5 — Adicione os outros 4 membros (somente líder)](#passo-5--adicione-os-outros-4-membros-somente-líder)
- [Passo 6 — Cada membro clona o repositório](#passo-6--cada-membro-clona-o-repositório)
- [Passo 7 — Ative o GitHub Copilot no VS Code (todos)](#passo-7--ative-o-github-copilot-no-vs-code-todos)
- [Passo 8 — Valide os agentes e prompts das suas personas (todos)](#passo-8--valide-os-agentes-e-prompts-das-suas-personas-todos)
- [Passo 9 — Instale o Spec-Kit (todos)](#passo-9--instale-o-spec-kit-todos)
- [Passo 10 — Use o fluxo Spec-Kit (todos)](#passo-10--use-o-fluxo-spec-kit-todos)
- [Passo 11 — Entenda a estratégia de branches](#passo-11--entenda-a-estratégia-de-branches)
- [Passo 12 — Fluxo diário por persona](#passo-12--fluxo-diário-por-persona)
- [Passo 13 — Smoke test (time inteiro, às 10:30)](#passo-13--smoke-test-time-inteiro-às-1030)
- [Solução de problemas](#solução-de-problemas)

---

## Antes de Começar — Modelo Mental

Você vai lidar com **2 repositórios GitHub**:

```text
GitHub
├── <TEMPLATE_ORG>/workshop-preto-00/       (repositório principal do workshop, usado como template)
└── <WORKSHOP_ORG>/workshop-team-XX/        (repositório de trabalho do SEU time — onde você commita)
```

No seu laptop, você clona somente o repositório do seu time:

```bash
~/Code/workshop-team-XX/
```

| Repositório | O que você faz com ele | Onde ele fica |
|---|---|---|
| `workshop-preto-00` | Você usa como template uma vez no início | `github.com/<TEMPLATE_ORG>/workshop-preto-00` |
| `workshop-team-XX` | Todo o seu trabalho vai aqui | `github.com/<WORKSHOP_ORG>/workshop-team-XX` (privado, você cria) |

> [!NOTE]
> A organização exata será informada pela facilitação no dia do workshop. Ela fará parte do Enterprise [software-gbb-workshops](https://github.com/enterprises/software-gbb-workshops).

> [!IMPORTANT]
> Nunca faça push para o repositório principal do workshop. Os commits do seu time vão somente para `workshop-team-XX`. O legado SIFAP já vem dentro do kit em `01-arqueologia/legado-sifap/` e é material de leitura, não de edição.

---

## Passo 1 — Verifique os pré-requisitos do laptop

**Cada membro do time roda este checklist no próprio laptop.**

- [ ] **Verificar Git.**

| Ferramenta | Versão mínima | Como verificar | Se estiver faltando |
|---|---|---|---|
| **Git** | 2.40+ | `git --version` | <https://git-scm.com/downloads> |
| **Conta GitHub** | — | Acesse github.com e faça login | <https://github.com/signup> |
| **GitHub CLI** | 2.40+ | `gh --version` | <https://cli.github.com> |
| **VS Code** | 1.93+ | Help → About | <https://code.visualstudio.com/download> |
| **Docker Desktop** | 4.30+ | `docker --version` e abra o app | <https://www.docker.com/products/docker-desktop> |
| **Java 21 JDK** | 21 | `java -version` | <https://learn.microsoft.com/java/openjdk/download> |
| **Node.js** | 20 LTS | `node --version` | <https://nodejs.org/en/download> |

> [!CAUTION]
> Faltando a maioria desses itens? Instale as ferramentas antes do workshop começar. Este kit não traz ambiente pré-montado nem bootstrap automático.

### Verificação de licença (uma pessoa verifica pelo time)

- [ ] **Abrir <https://github.com/settings/copilot>** — você deve ver "Active subscription" (Individual) ou "Business plan". Se ver "Get GitHub Copilot", chame a facilitação.

---

## Passo 2 — Crie o repositório do time pelo template (somente líder)

**Escolha uma pessoa para ser líder do time** (normalmente quem cobre a persona Technical Lead no Par 3). Somente a pessoa líder faz os Passos 2 a 5. As outras 4 aguardam e seguem a partir do Passo 6.

### Pelo template no GitHub

- [ ] **Criar o repositório a partir do template.**

1. Abra o repositório principal do workshop no GitHub. A facilitação informará a URL no formato `https://github.com/<TEMPLATE_ORG>/workshop-preto-00`.
2. Clique em **Use this template** → **Create a new repository**.
3. Preencha:
   - **Owner**: a organização do workshop indicada pela facilitação, dentro do Enterprise `software-gbb-workshops`. Não escolha seu usuário pessoal.
   - **Nome do repositório**: `workshop-team-XX` (substitua XX pelo número do seu time, por exemplo `workshop-team-01`)
   - **Descrição**: `Workshop DATACORP 2026 — Team XX`
   - **Visibilidade**: Privado
4. Clique em **Create repository**.

Você deve ver uma cópia completa do kit em `https://github.com/<WORKSHOP_ORG>/workshop-team-XX`, com documentação, legado, templates, workflows e arquivos `.github/` já presentes.

---

## Passo 3 — Clone o repositório e crie `develop` (somente líder)

- [ ] **Clonar e criar a branch `develop`.**

```bash
# 1. Escolha uma pasta para todo o seu código
mkdir -p ~/Code && cd ~/Code

# 2. Clone o repositório do seu time
git clone https://github.com/<WORKSHOP_ORG>/workshop-team-01.git
cd workshop-team-01

# 3. Confira que o template veio completo
ls 01-arqueologia/legado-sifap .github/agents .github/prompts .github/instructions .github/skills

# 4. Crie a branch de integração do time
git checkout -b develop
git push -u origin develop
```

> [!WARNING]
> A partir daqui, nunca faça push diretamente para `main`. O Passo 4 protege essa branch.

`develop` é onde as branches de funcionalidade de todo mundo serão integradas. Promoções para `main` acontecem via PR depois de cada estágio.

---

## Passo 4 — Proteja a branch `main` (somente líder)

Isso impede que qualquer pessoa (exceto o admin do repositório) faça push direto para `main`. Toda mudança deve passar por um Pull Request.

> [!NOTE]
> Como o repositório será criado em uma organização dentro do Enterprise `software-gbb-workshops`, a proteção de branch deve estar disponível. Se a opção não aparecer, chame a facilitação para conferir permissões.

### Usando o site

- [ ] **Criar a regra de proteção.**

1. Vá para **Settings** → **Branches** (barra lateral esquerda).
2. Em **Branch protection rules**, clique em **Add rule**.
3. Padrão de nome da branch: `main`
4. Marque:
   - **Require a pull request before merging**
   - **Require approvals** — defina como `1`
   - **Require conversation resolution before merging**
5. Clique em **Create**.

### Usando a CLI

```bash
gh api -X PUT "repos/<WORKSHOP_ORG>/workshop-team-01/branches/main/protection" \
  --input - <<'JSON'
{
  "required_status_checks": null,
  "enforce_admins": true,
  "required_pull_request_reviews": {
    "required_approving_review_count": 1,
    "dismiss_stale_reviews": false,
    "require_code_owner_reviews": false
  },
  "restrictions": null,
  "required_conversation_resolution": true
}
JSON
```

> **Por que isso importa.** Sem essa regra, alguém do time eventualmente vai enviar um erro para `main` no minuto 90 e a demo vai falhar no minuto 480. Custo: 30 segundos. Economia: horas.

---

## Passo 5 — Adicione os outros 4 membros (somente líder)

### Opção A — usando o site

- [ ] **Convidar os 4 colegas.**

1. Vá para o repositório no GitHub: `https://github.com/<WORKSHOP_ORG>/workshop-team-XX`
2. Clique em **Settings** → **Collaborators and teams** → **Manage access**.
3. Clique em **Add people**.
4. Digite o usuário GitHub e escolha na lista.
5. Escolha o papel **Write** (não Admin, não Read).
6. Clique em **Add ... to this repository**.
7. Repita para as outras 3 pessoas.

> [!TIP]
> Se a facilitação criou um time GitHub para cada equipe, adicione o time inteiro com permissão Write em vez de convidar pessoa por pessoa. Cada pessoa convidada recebe um email — ela precisa clicar em **Accept invitation** antes de conseguir fazer push.

### Opção B — usando a CLI

```bash
for user in alice bob carla dani; do
  gh api -X PUT "repos/<WORKSHOP_ORG>/workshop-team-01/collaborators/${user}" \
    -f permission=write
done
```

---

## Passo 6 — Cada membro clona o repositório

**Agora todo mundo entra.** Os outros 4 membros do time fazem isto.

### 6.1 Aceite o convite

- [ ] **Aceitar o convite recebido por email ou notificação no GitHub.**

### 6.2 Clone e mude para `develop`

- [ ] **Clonar e confirmar acesso.**

```bash
mkdir -p ~/Code && cd ~/Code

# Substitua 01 pelo número real do seu time e <WORKSHOP_ORG> pela organização informada no dia
git clone https://github.com/<WORKSHOP_ORG>/workshop-team-01.git
cd workshop-team-01

# Mude para a branch develop (onde o trabalho diário acontece)
git checkout develop
```

### 6.3 Abra no VS Code

```bash
code .
```

### 6.4 Confirme as ferramentas locais

Este kit não inclui ambiente pré-montado, protótipo pré-pronto nem containerização herdada. Cada pessoa valida as ferramentas no próprio laptop; o protótipo será criado do zero no Estágio 3.

```bash
git --version
java -version
node --version
docker --version
specify version
```

### 6.5 Confirme que o template veio completo

```bash
ls 01-arqueologia/legado-sifap .github/agents .github/prompts .github/instructions .github/skills
```

---

## Passo 7 — Ative o GitHub Copilot no VS Code (todos)

### 7.1 Faça login

- [ ] **Autenticar no Copilot.**

1. No VS Code, clique no ícone do Copilot na barra de status inferior.
2. Escolha **Sign in with GitHub**.
3. Uma janela do navegador abre. Clique em **Authorize Visual Studio Code**.
4. Volte para o VS Code. Aguarde "Copilot ready" perto do canto inferior direito.

### 7.2 Abra o painel do Copilot Chat

| SO | Atalho |
|---|---|
| Mac | Cmd+Ctrl+I |
| Windows / Linux | Ctrl+Alt+I |

### 7.3 Verifique se os 3 modos estão disponíveis

| Modo | Quando usar |
|---|---|
| **Ask** | Fazer perguntas, explorar código, discutir opções |
| **Plan** | Planejar mudanças multi-arquivo antes da execução |
| **Agent** | Delegar uma funcionalidade inteira via Issue e depois revisar o PR |

- [ ] **Confirmar que Ask, Plan e Agent aparecem no dropdown.**

Se **Plan** ou **Agent** não aparecerem, atualize o VS Code para uma versão recente ou use VS Code Insiders.

### 7.4 Teste de fumaça do Copilot

- [ ] **Enviar pergunta de teste.**

No painel de Chat, digite:

```text
Qual stack estamos usando neste projeto?
```

Ele deve responder com **Java 21 + Spring Boot 3.3 + Next.js 15 + PostgreSQL 16**. Se não responder, o arquivo `.github/copilot-instructions.md` do projeto não está sendo carregado — veja [Solução de problemas](#solução-de-problemas).

---

## Passo 8 — Valide os agentes e prompts das suas personas (todos)

### 8.1 Encontre seu papel

- [ ] **Ler o `PERSONA.md` das duas personas.**

Abra `05-personas/` no VS Code. Dentro da pasta do seu papel, leia `PERSONA.md` de ponta a ponta (~10 minutos). Ele diz:

- O que você faz nos 4 estágios
- Qual modo do Copilot usar
- Prompts específicos que você pode copiar/colar
- De quem você depende e quem depende de você

### 8.2 Valide seu kit

```bash
# Deve listar agents, prompts, instructions e skills consolidados
ls .github/agents .github/prompts .github/instructions .github/skills
```

Não copie `.github/*` manualmente: isso já foi feito no kit consolidado do repositório.

### 8.3 Mapeamento persona-para-kit

| Persona | Kit consolidado |
|---|---|
| Product Owner | `05-personas/01-product-owner/PERSONA.md` |
| Requirements Engineer | `05-personas/02-requirements-engineer/PERSONA.md` |
| Enterprise Architect | `05-personas/03-enterprise-architect/PERSONA.md` |
| Software Architect | `05-personas/04-software-architect/PERSONA.md` |
| Technical Lead | `05-personas/05-technical-lead/PERSONA.md` |
| Developer | `05-personas/06-developer/PERSONA.md` |
| DBA | `05-personas/07-dba/PERSONA.md` |
| QA Engineer | `05-personas/08-qa-engineer/PERSONA.md` |
| DevOps Engineer | `05-personas/09-devops-engineer/PERSONA.md` |
| Tech Writer | `05-personas/10-tech-writer/PERSONA.md` |

### 8.4 Atualize o `copilot-instructions.md` do time

- [ ] **Líder atualiza `.github/copilot-instructions.md` com os nomes do time.**

Encontre a seção:

```markdown
## Active Personas on This Team

- [ ] 01 — Product Owner
- [ ] 02 — Requirements Engineer
      ...
```

Marque as caixas e escreva o nome ao lado de cada papel:

```markdown
- [x] 01 — Product Owner — Maria Santos
- [x] 02 — Requirements Engineer — João Silva
- [x] 03 — Enterprise Architect — Ana Costa
      ...
```

Faça commit e push para `develop`. Agora as sugestões do Copilot sabem quem está no seu time.

---

## Passo 9 — Instale o Spec-Kit (todos)

[**Spec-Kit**](https://github.com/github/spec-kit) é o toolkit oficial do GitHub para desenvolvimento orientado por especificação. Use para **rascunhos rápidos de funcionalidades** no Estágio 2.

### 9.1 Instale o Specify CLI no seu laptop

- [ ] **Instalar o Specify CLI.**

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@vX.Y.Z
specify version
```

Substitua `vX.Y.Z` pela versão mais recente em <https://github.com/github/spec-kit/releases>.

### 9.2 Inicialize no repositório do time

- [ ] **Inicializar na raiz do repositório.**

```bash
specify init . --integration copilot
```

Isso cria a configuração `.specify/`, scripts de automação e os slash commands `/speckit.*` para o GitHub Copilot.

### 9.3 Verifique os comandos no Copilot

| Comando | Quando usar |
|---|---|
| `/speckit.constitution` | Define princípios, padrões e gates do projeto |
| `/speckit.specify` | Cria a spec da funcionalidade |
| `/speckit.clarify` | Resolve ambiguidades antes do plano |
| `/speckit.plan` | Cria o plano técnico |
| `/speckit.tasks` | Gera tasks implementáveis |
| `/speckit.analyze` | Checa consistência e cobertura |
| `/speckit.implement` | Implementa a funcionalidade guiada pela spec |

### 9.4 Escreva uma funcionalidade

No Copilot Chat:

```text
/speckit.specify <descreva a funcionalidade identificada pelo time no legado>. Preserve a rastreabilidade legada com source_legacy em cada requisito.
```

O Spec-Kit cria uma branch numerada e a estrutura:

```text
specs/<NNN>-<feature>/
└── spec.md
```

Em seguida, rode:

```text
/speckit.clarify
/speckit.plan Use Java 21, Spring Boot 3.3, PostgreSQL 16, Next.js 15 e a arquitetura de monólito modular do workshop.
/speckit.tasks
```

### 9.5 Regra do workshop

Todo requisito que vier do legado continua precisando de `source_legacy:` apontando para `.NSN` ou `.ddm`. Requisitos sem paralelo no legado usam `[GREENFIELD]` com justificativa.

---

## Passo 10 — Use o fluxo Spec-Kit (todos)

| Fase | Comando | Saída principal | Persona dona |
|---|---|---|---|
| Constituição | `/speckit.constitution` | `.specify/memory/constitution.md` | Technical Lead + Architect |
| Spec | `/speckit.specify` | `specs/<NNN>-<feature>/spec.md` | Requirements Engineer |
| Clarificação | `/speckit.clarify` | Perguntas resolvidas na spec | Requirements Engineer + Product Owner |
| Plano | `/speckit.plan` | `specs/<NNN>-<feature>/plan.md` | Software Architect |
| Tasks | `/speckit.tasks` | `specs/<NNN>-<feature>/tasks.md` | Technical Lead |
| Análise | `/speckit.analyze` | Lacunas e inconsistências | QA Engineer + Architect |
| Implementação | `/speckit.implement` | Código + testes guiados pela spec | Developer + QA Engineer |

> [!IMPORTANT]
> O time revisa explicitamente `spec.md`, `plan.md` e `tasks.md` antes de implementar (gates LGTM).

---

## Passo 11 — Entenda a estratégia de branches

```text
main                    <- pronto para release, protegido, exige 1 revisão
develop                 <- integração de todas as funcionalidades
spec/NNN-feature        <- trabalho de especificação (Estágio 2)
impl/NNN-feature        <- trabalho de implementação (Estágio 3)
infra/NNN-azure         <- trabalho de infraestrutura (Estágio 4)
```

### Convenção de nomes

| Tipo | Padrão | Exemplo |
|---|---|---|
| Spec | `spec/<NNN>-<feature>` | `spec/001-calculo-beneficio` |
| Implementação | `impl/<NNN>-<feature>` | `impl/001-calculo-beneficio` |
| Infraestrutura | `infra/<componente>` | `infra/azure-postgres` |

`NNN` é o número da funcionalidade (corresponde à pasta em `specs/<NNN>-<feature>/`).

### Criando uma branch de funcionalidade

- [ ] **Criar branch a partir de `develop`.**

```bash
git checkout develop
git pull

git checkout -b spec/<NNN>-<feature>

git add -A
git commit -m "feat: draft EARS requirements"
git push -u origin spec/<NNN>-<feature>
```

### Abrindo um Pull Request

- [ ] **Abrir PR e preencher o template.**

1. Após o push, o GitHub imprime uma URL para criar o PR. Clique nela.
2. Título: use Conventional Commits — `feat: add feature spec`
3. Preencha o template (`.github/PULL_REQUEST_TEMPLATE.md`): o que mudou, REQ-IDs, como testar, issues vinculadas.
4. Adicione pelo menos uma pessoa revisora de outra persona.
5. Clique em **Create pull request**.
6. Aguarde CI verde.
7. Após aprovação, clique em **Rebase and merge** (não Merge commit, não Squash).
8. Delete a branch de funcionalidade quando solicitado.

---

## Passo 12 — Fluxo diário por persona

### Product Owner / Requirements Engineer

```text
1. Leia os achados do Estágio 1 (glossário, catálogo de regras de negócio)
2. Rode /speckit.specify "feature-name" com orientação de source_legacy
3. Rode /speckit.clarify e valide com personas stakeholder (PO + EA)
4. Rode /speckit.plan com a stack do workshop e as escolhas arquiteturais
5. Rode /speckit.tasks depois que o plano for aprovado
6. Abra um PR na branch spec/<NNN>-<feature>
7. Faça passagem para Software Architect (gate LGTM)
```

### Enterprise Architect / Software Architect

```text
1. Faça pull do develop mais recente
2. git checkout spec/NNN-feature (leia a spec EARS)
3. Rode /speckit.plan → produz plan.md, research.md e contracts
4. Adicione ADRs em docs/adr/ para decisões não triviais
5. Abra um PR — revise a seção de design do PR da spec
6. Faça passagem para Tech Lead (gate LGTM)
```

### Technical Lead

```text
1. Leia o plan.md aprovado e os ADRs
2. Rode /speckit.tasks → produz tasks.md com IDs de tarefa (T001, T002, ...)
3. Abra uma GitHub Issue por tarefa usando .github/ISSUE_TEMPLATE/task.yml
4. Atribua cada issue a Developer / DBA / QA
5. Acompanhe CI verde/vermelho e desbloqueie pessoas
```

### Developer

```text
1. Escolha uma issue de tarefa (T-NNN) no board do time
2. git checkout -b impl/NNN-feature (a partir de develop)
3. No Copilot, rode /implement (prompt ativo: .github/prompts/persona-developer-implement.prompt.md)
4. Testes primeiro (vermelho), código (verde), refatoração
5. Rode o gate local definido pelo protótipo (./mvnw verify, npm test, npm run lint ou equivalente)
6. git commit, git push, abra PR
7. Marque a issue com "Closes #NN" no corpo do PR
```

### DBA

```text
1. Escolha uma tarefa de schema/migração
2. git checkout -b impl/NNN-feature
3. Adicione a migração Flyway em backend/src/main/resources/db/migration/
4. Rode o prompt /migration (prompt ativo: .github/prompts/persona-dba-migration.prompt.md)
5. Teste localmente contra o Postgres definido pelo time ou via Testcontainers
6. Abra PR e peça revisão de Developer
```

### QA Engineer

```text
1. Acompanhe todo PR de implementação
2. Rode o prompt /coverage-gaps para encontrar REQ-IDs sem cobertura
3. Adicione testes na branch de implementação (em par com Developer)
4. O prompt /test-strategy produz um plano de testes para novas funcionalidades
5. Bloqueie o merge se a cobertura cair abaixo de 70%
```

### DevOps Engineer

```text
1. Escolha uma tarefa de infraestrutura (configuração Azure, CI/CD, deployment)
2. git checkout -b infra/NNN-azure-foo
3. Edite módulos Terraform em infra/
4. Rode terraform fmt + terraform validate localmente
5. Rode o prompt /iac-module (prompt ativo: .github/prompts/persona-devops-engineer-iac-module.prompt.md)
6. Abra PR; workflows/ci.yml executa validação Terraform
```

### Tech Writer

```text
1. Depois de cada merge em develop, procure drift em ADR/glossário
2. Rode o prompt /doc-drift (prompt ativo: .github/prompts/persona-tech-writer-doc-drift.prompt.md)
3. Atualize 01-arqueologia/glossary.md, docs/adr/ e os READMEs
4. Abra um PR pequeno por atualização de documentação
```

---

## Passo 13 — Smoke test (time inteiro, às 10:30)

A pessoa líder lê cada item em voz alta. Cada pessoa confirma no próprio laptop.

- [ ] Cada membro clonou `workshop-team-XX`
- [ ] Cada membro consegue rodar `git checkout develop && git pull origin develop` (acesso de escrita confirmado)
- [ ] CI rodou no commit inicial criado pelo template — check verde na aba **Actions**
- [ ] Time confirmou que não há protótipo pré-pronto: `backend/`, `frontend/` e arquivos Docker/infra serão criados no Estágio 3 quando necessário
- [ ] Cada Copilot Chat responde "Qual stack estamos usando neste projeto?" com a resposta certa
- [ ] Cada membro instalou o Spec-Kit oficial: `specify version` imprime uma versão
- [ ] Os comandos `/speckit.*` aparecem no Copilot depois de `specify init . --integration copilot`
- [ ] Abrir **New issue** no GitHub mostra 3 templates (spec, adr, task)
- [ ] Todos os 5 membros do time aparecem em repo Settings → Collaborators
- [ ] Cada persona leu sua carta em `05-personas/XX-role/PERSONA.md`
- [ ] A pessoa líder do time atualizou `.github/copilot-instructions.md` com os nomes de todo mundo
- [ ] `.github/agents`, `.github/prompts`, `.github/instructions` e `.github/skills` estão presentes e consolidados
- [ ] [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) foi lido em voz alta uma vez (a linha do tempo do dia)

Quando os 13 itens estiverem verdes, seu time está pronto para o **Estágio 1: Arqueologia**.

---

## Solução de problemas

<details>
<summary><strong>Erros comuns e como resolver</strong> — clique para expandir</summary>

### Copilot não lê `copilot-instructions.md`

- O VS Code precisa estar aberto **na raiz do repositório**, não dentro de uma subpasta.
- Reinicie o VS Code depois de editar o arquivo.
- Em Settings, verifique se `github.copilot.chat.useProjectInstructions` está como `true` (padrão na 1.93+).

### O botão **Use this template** não aparece

- Confirme que você abriu o repositório principal do workshop, não o repositório de outro time.
- Se ainda não aparecer, peça à facilitação para confirmar se a opção **Template repository** está habilitada em Settings → General.
- Não use **Import repository**. O caminho oficial do workshop é **Use this template**.

### O nome `workshop-team-XX` já está em uso

- Confirme se você está usando o número correto do seu time.
- Se a facilitação autorizar, adicione um sufixo curto, por exemplo `workshop-team-01b`.

### `specify init` falha ou os comandos `/speckit.*` não aparecem

- Confirme que `uv`, Python 3.11+ e Git estão instalados.
- Rode `specify version` para garantir que você instalou o CLI oficial.
- Reexecute `specify init . --integration copilot` na raiz do repositório.
- Recarregue o VS Code: Command Palette → **Developer: Reload Window**.

### CI falha no primeiro push com "no tests found"

- Esperado. O fluxo de trabalho `ci.yml` só roda jobs cujos caminhos mudaram. Quando código backend/frontend entrar, os jobs relevantes vão rodar.

### Docker não está disponível quando o time precisar dele

- As portas 5432, 8080 ou 3000 podem estar em uso. Rode:

  ```bash
  lsof -i :5432 -i :8080 -i :3000
  ```

  Mate o processo que está ocupando a porta (`kill -9 <PID>`) antes de subir o ambiente criado pelo time.

- Garanta que o Docker Desktop está **rodando** (o ícone na barra de menu deve estar estável, não animado).

### Copilot Agent mode não aparece no dropdown

- Atualize o VS Code para **1.93 ou posterior** (ou instale **VS Code Insiders**).
- Recarregue a janela: Command Palette → **Developer: Reload Window**.

### "Permission denied" ao fazer push para `main`

- A proteção de branch (Passo 4) está fazendo seu trabalho. Abra um Pull Request a partir da sua branch de funcionalidade.

### Fiz pull do `develop` mais recente, mas minha IDE ainda mostra código antigo

- Recarregue a janela do VS Code: Command Palette → **Developer: Reload Window**.
- Se o VS Code ainda mostrar estado antigo, feche e reabra a pasta do repositório.

### A pasta `.github/` parece quebrada

- Não copie persona-kits manualmente por cima da `.github/` consolidada.
- Se algo parecer quebrado: restaure com `git checkout develop -- .github/` ou peça ajuda ao facilitador antes de tentar sobrescrever arquivos.

</details>

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [TEAM-FLOW](00-TEAM-FLOW.md)<br/><sub>Cronograma de 8h, passagens entre pares, regra dos 20 min, DoD.</sub> | [OVERVIEW das 10 personas](05-personas/OVERVIEW.md)<br/><sub>Tabela comparativa: par, líder de estágio, defaults de emergência.</sub> |

<sub>[Voltar ao índice do kit](README.md)</sub>
