<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Guia de Setup — Do Zero ao Código

![SETUP 00](https://img.shields.io/badge/SETUP-00-00A4EF?style=for-the-badge) ![DURAÇÃO 45 min](https://img.shields.io/badge/DURAÇÃO-45%20min-1A1A1A?style=for-the-badge) ![QUANDO Antes do dia 2](https://img.shields.io/badge/QUANDO-Antes%20do%20dia%202-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](README.md) → **Setup**


> **Para quem é isto?** Para a pessoa que vai preparar o ambiente do time antes do dia 2 — líder do time ou cada membro no próprio laptop.
>
> **O que você terá ao final desta leitura:**
>
> 1. Repositório GitHub do time criado com proteção de branch
> 2. Spec-Kit oficial + GitHub Copilot funcionando no VS Code
> 3. Cada pessoa com suas 2 personas lidas e Ask/Plan/Agent validados
> 4. Estratégia de branches definida (`spec/*`, `impl/*`)
> 5. Smoke test passando antes das 10:00 do dia 2

> **Vocês são 5 pessoas. Cada pessoa usa 2 personas. Vocês têm um dia de trabalho.** Este guia leva vocês de "ainda não temos nada" até "repositório criado pelo template, Copilot funcionando, todas as personas prontas" em **45 minutos**.
>
> **Todas as pessoas do time devem acompanhar no próprio laptop.** Uma pessoa compartilha a tela com os passos, e as outras 4 repetem. Ao final, cada laptop estará totalmente configurado.
>
> [!WARNING]
> **Usuários de Windows:** os blocos de terminal com heredoc ou `for` assumem **Git Bash** ou **WSL**. **Não** use PowerShell ou CMD nesses blocos.

## Sumário

- [📋 Antes de Começar — Modelo Mental](#-antes-de-começar--modelo-mental)
- [✅ Passo 1 — Verifique se seu laptop tem os pré-requisitos](#-passo-1--verifique-se-seu-laptop-tem-os-pré-requisitos)
- [👥 Passo 2 — Crie o repositório do time pelo template (somente líder)](#-passo-2--crie-o-repositório-do-time-pelo-template-somente-líder)
- [📥 Passo 3 — Clone o repositório do time e crie `develop` (somente líder)](#-passo-3--clone-o-repositório-do-time-e-crie-develop-somente-líder)
- [🛡️ Passo 4 — Proteja a branch `main` (somente líder)](#%EF%B8%8F-passo-4--proteja-a-branch-main-somente-líder)
- [🎟️ Passo 5 — Adicione os outros 4 membros do time (somente líder)](#%EF%B8%8F-passo-5--adicione-os-outros-4-membros-do-time-somente-líder)
- [💻 Passo 6 — Cada membro clona o repositório do time](#-passo-6--cada-membro-clona-o-repositório-do-time)
- [🤖 Passo 7 — Ative o GitHub Copilot no VS Code (todos)](#-passo-7--ative-o-github-copilot-no-vs-code-todos)
- [🎭 Passo 8 — Valide os agentes e prompts das suas personas (todos)](#-passo-8--valide-os-agentes-e-prompts-das-suas-personas-todos)
- [📐 Passo 9 — Instale o Spec-Kit (todos)](#-passo-9--instale-o-spec-kit-todos)
- [🎯 Passo 10 — Use o fluxo Spec-Kit (todos)](#-passo-10--use-o-fluxo-spec-kit-todos)
- [🌿 Passo 11 — Entenda a estratégia de branches](#-passo-11--entenda-a-estratégia-de-branches)
- [🔄 Passo 12 — Fluxo diário por persona](#-passo-12--fluxo-diário-por-persona)
- [🚦 Passo 13 — Rode o teste de fumaça (time inteiro, às 10:30)](#-passo-13--rode-o-teste-de-fumaça-time-inteiro-às-0930)
- [🆘 Solução de problemas](#-solução-de-problemas)

---

## 📋 Antes de Começar — Modelo Mental

Você vai lidar com **2 repositórios GitHub**:

```
GitHub
├── <TEMPLATE_ORG>/workshop-preto-00/       (repositório principal do workshop, usado como template)
└── <WORKSHOP_ORG>/hackathon-team-XX/       (repositório de trabalho do SEU time — onde você commita)
```

No seu laptop, você clona somente o repositório do seu time:

```bash
~/Code/hackathon-team-XX/
```

| Repositório         | O que você faz com ele                                       | Onde ele fica                                                        |
| ------------------- | ------------------------------------------------------------ | -------------------------------------------------------------------- |
| `workshop-preto-00` | Você usa como template uma vez no início                     | github.com/<TEMPLATE_ORG>/workshop-preto-00                          |
| `hackathon-team-XX` | **Todo o seu trabalho vai aqui**                             | github.com/<WORKSHOP_ORG>/hackathon-team-XX (privado, você cria)     |

> [!NOTE]
> A organização exata será informada pela facilitação no dia do workshop. Ela fará parte do Enterprise [software-gbb-workshops](https://github.com/enterprises/software-gbb-workshops).

> [!IMPORTANT]
> **Regra-chave:** nunca faça push para o repositório principal do workshop. Os commits do seu time vão somente para `hackathon-team-XX`. O legado SIFAP já vem dentro do kit em `01-arqueologia/legado-sifap/` e é material de leitura, não de edição.

---

## ✅ Passo 1 — Verifique se seu laptop tem os pré-requisitos

**Cada membro do time roda este checklist no próprio laptop.**

| Ferramenta         | Versão mínima | Como verificar                           | Se estiver faltando                                 |
| ------------------ | ------------- | ---------------------------------------- | --------------------------------------------------- |
| **Git**            | 2.40+         | Abra um terminal, digite `git --version` | <https://git-scm.com/downloads>                     |
| **Conta GitHub**   | —             | Acesse github.com e faça login           | <https://github.com/signup>                         |
| **GitHub CLI**     | 2.40+         | `gh --version`                           | <https://cli.github.com>                            |
| **VS Code**        | 1.93+         | Abra o VS Code, **Help → About**         | <https://code.visualstudio.com/download>            |
| **Docker Desktop** | 4.30+         | `docker --version` E abra o app Docker   | <https://www.docker.com/products/docker-desktop>    |
| **Java 21 JDK**    | 21            | `java -version`                          | <https://learn.microsoft.com/java/openjdk/download> |
| **Node.js**        | 20 LTS        | `node --version`                         | <https://nodejs.org/en/download>                    |

> **Faltando a maioria desses itens?** Instale as ferramentas antes do workshop começar. Este kit não traz ambiente pré-montado nem bootstrap automático.

### Verificação de licença (uma pessoa verifica pelo time)

1. Abra <https://github.com/settings/copilot> no navegador.
2. Você deve ver **"Active subscription"** (Individual) ou **"Business plan"** no topo.
3. Se você vir "Get GitHub Copilot", levante a mão para o time de facilitadores do cordão azul.

---

## 👥 Passo 2 — Crie o repositório do time pelo template (somente líder)

**Escolham uma pessoa para ser líder do time** (normalmente quem cobre a persona Technical Lead no Par 3). Somente a pessoa líder faz os Passos 2 a 5. As outras 4 pessoas aguardam e seguem a partir do Passo 6.

O repositório principal do workshop já está com **Use this template** habilitado. Então a pessoa líder não cria um repositório vazio: ela clica no template e cria uma cópia do kit diretamente na organização do workshop. A facilitação informará no dia qual organização usar; ela estará dentro do Enterprise [software-gbb-workshops](https://github.com/enterprises/software-gbb-workshops).

### Pelo template no GitHub

1. Abra o repositório principal do workshop no GitHub. A facilitação informará a URL no formato `https://github.com/<TEMPLATE_ORG>/workshop-preto-00`.
2. Clique em **Use this template** → **Create a new repository**.
3. Preencha:

- **Owner**: a **organização do workshop** indicada pela facilitação no dia, dentro do Enterprise `software-gbb-workshops`. Não escolha seu usuário pessoal.
- **Nome do repositório**: `hackathon-team-XX` (substitua XX pelo número do seu time, por exemplo, `hackathon-team-01`)
- **Descrição**: `Hackathon DATACORP 2026 — Team XX`
- **Visibilidade**: **Privado** ✅

4. Clique em **Create repository**.

Você agora deve ver uma cópia completa do kit em `https://github.com/<WORKSHOP_ORG>/hackathon-team-XX`, com documentação, legado, templates, workflows e arquivos `.github/` já presentes.

---

## 📥 Passo 3 — Clone o repositório do time e crie `develop` (somente líder)

Agora a pessoa líder clona o repositório que acabou de nascer a partir do template e cria a branch de integração do time.

```bash
# 1. Escolha uma pasta para todo o seu código
mkdir -p ~/Code && cd ~/Code

# 2. Clone o repositório do seu time criado pelo template
git clone https://github.com/<WORKSHOP_ORG>/hackathon-team-01.git
cd hackathon-team-01

# 3. Confira que o template veio completo
ls 01-arqueologia/legado-sifap .github/agents .github/prompts .github/instructions .github/skills

# 4. Crie a branch de integração do time
git checkout -b develop
git push -u origin develop
```

> ⚠️ **Importante.** De agora em diante, você nunca deve fazer push diretamente para `main`. O Passo 4 protege essa branch.

`develop` é onde as branches de funcionalidade de todo mundo serão integradas. Promoções para `main` acontecem via PR depois de cada estágio.

---

## 🛡️ Passo 4 — Proteja a branch `main` (somente líder)

Isso impede que qualquer pessoa (exceto o admin do repositório) faça push direto para `main`. Toda mudança deve passar por um Pull Request.

> ⚠️ **Organização do workshop**: como o repositório será criado em uma organização dentro do Enterprise `software-gbb-workshops`, a proteção de branch deve estar disponível. Se a opção não aparecer, chame a facilitação para conferir permissões na organização.

### Usando o site

1. Vá para **Settings** → **Branches** (barra lateral esquerda).
2. Em **Branch protection rules**, clique em **Add rule**.
3. Padrão de nome da branch: `main`
4. Marque:
   - **Require a pull request before merging** ✅
   - **Require approvals** — defina como `1`
   - **Require conversation resolution before merging** ✅
5. Clique em **Create**.

### Usando a CLI

```bash
gh api -X PUT "repos/<WORKSHOP_ORG>/hackathon-team-01/branches/main/protection" \
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

> **Por que isso importa.** Sem essa regra, alguém do time eventualmente vai enviar um typo para `main` no minuto 90 e o demo vai falhar no minuto 480. Custo: 30 segundos. Economia: horas.

---

## 🎟️ Passo 5 — Adicione os outros 4 membros do time (somente líder)

A pessoa líder convida o restante do time para que todo mundo possa fazer push e pull.

### Opção A — usando o site

1. Vá para o repositório no GitHub: `https://github.com/<WORKSHOP_ORG>/hackathon-team-XX`
2. Clique em **Settings** (aba superior — exige permissão de admin, que a pessoa líder tem).
3. Na barra lateral esquerda, clique em **Collaborators and teams** ou **Manage access**.
4. Clique em **Add people** ou **Add teams**.
5. Digite o usuário GitHub (por exemplo, `alice-builder`) e escolha na lista.
6. **Escolha o papel**: escolha **Write** (não Admin, não Read).
7. Clique em **Adicionar ... a este repositório**.
8. Repita para as outras 3 pessoas.

> **Dica para organização.** Se a facilitação criou um time GitHub para cada equipe, adicione o time inteiro com permissão **Write** em vez de convidar pessoa por pessoa.

> **Dica.** Cada pessoa convidada recebe um email e uma notificação dentro do GitHub. Ela precisa clicar em **Accept invitation** antes de conseguir fazer push.

### Opção B — usando a CLI

Uma vez por colega:

```bash
# Substitua alice pelo usuário GitHub real
gh api -X PUT "repos/<WORKSHOP_ORG>/hackathon-team-01/collaborators/alice" \
  -f permission=write
```

Ou em loop:

```bash
for user in alice bob carla dani; do
  gh api -X PUT "repos/<WORKSHOP_ORG>/hackathon-team-01/collaborators/${user}" \
    -f permission=write
done
```

---

## 💻 Passo 6 — Cada membro clona o repositório do time

**Agora todo mundo entra.** Os outros 4 membros do time fazem isto.

### 6.1 Aceite o convite

1. Abra o email do GitHub com o título **"[username] invited you to ..."** (ou confira o ícone de sino 🔔 em github.com).
2. Clique em **View invitation** → **Accept invitation**.

### 6.2 Clone e mude para `develop`

```bash
mkdir -p ~/Code && cd ~/Code

# Substitua 01 pelo número real do seu time e <WORKSHOP_ORG> pela organização informada no dia
git clone https://github.com/<WORKSHOP_ORG>/hackathon-team-01.git
cd hackathon-team-01

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

Cada membro deve confirmar que recebeu a cópia completa do kit, incluindo o legado já embutido:

```bash
ls 01-arqueologia/legado-sifap .github/agents .github/prompts .github/instructions .github/skills
```

---

## 🤖 Passo 7 — Ative o GitHub Copilot no VS Code (todos)

Cada pessoa faz isto no próprio laptop.

### 7.1 Faça login

1. No VS Code, olhe para a barra de status inferior. Clique no ícone do **Copilot** (🤖).
2. Escolha **Sign in with GitHub**.
3. Uma janela do navegador abre. Clique em **Authorize Visual Studio Code**.
4. Volte para o VS Code. Aguarde "Copilot ready" perto do canto inferior direito.

### 7.2 Abra o painel do Copilot Chat

| SO              | Atalho       |
| --------------- | ------------ |
| Mac             | <kbd>Cmd</kbd>+<kbd>Ctrl</kbd>+<kbd>I</kbd> |
| Windows / Linux | <kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>I</kbd> |

Um painel abre à direita.

### 7.3 Verifique se os 3 modos estão disponíveis

No topo do painel de chat há um dropdown:

| Modo      | Quando usar                                                      |
| --------- | ---------------------------------------------------------------- |
| **Ask**   | Fazer perguntas, explorar código, discutir opções                |
| **Plan**  | Planejar mudanças multi-arquivo antes da execução                |
| **Agent** | Delegar uma funcionalidade inteira via Issue e depois revisar o PR |

Clique no dropdown para confirmar que os três aparecem. Se **Plan** ou **Agent** não aparecerem, atualize o VS Code para uma versão recente ou use VS Code Insiders, que sempre tem o mais novo primeiro.

### 7.4 Teste de fumaça do Copilot

No painel de Chat, digite:

```
Qual stack estamos usando neste projeto?
```

Ele deve responder com **Java 21 + Spring Boot 3.3 + Next.js 15 + PostgreSQL 16**. Se não responder, o arquivo `.github/copilot-instructions.md` do projeto não está sendo carregado — veja [Solução de problemas](#-solução-de-problemas).

---

## 🎭 Passo 8 — Valide os agentes e prompts das suas personas (todos)

Cada uma das 10 personas do workshop tem um **kit Copilot correspondente**. A `.github/` do repositório já vem consolidada com agents, prompts, instructions e skills de todas as personas e dos 4 estágios. Como o time tem 5 pessoas e cada pessoa usa duas personas, você lê as duas cartas e valida que os artefatos já aparecem no Copilot.

### 8.1 Encontre seu papel

Abra `05-personas/` no VS Code. Você verá 10 pastas, numeradas de 01 a 10. Dentro da pasta do seu papel, leia `PERSONA.md` de ponta a ponta (~10 minutos). Ele diz:

- O que você faz nos 4 estágios
- Qual modo do Copilot usar
- Prompts específicos que você pode copiar/colar
- De quem você depende e quem depende de você

### 8.2 Valide seu kit

Cada persona fica documentada em `05-personas/<role>/`. A mesma pasta continua sendo a fonte de referência da persona:

- `PERSONA.md` — responsabilidades, passagens, prompts de exemplo e rubrica do papel
- `.github/agents/<role>.agent.md` — agente Copilot pré-configurado (ativo também em `.github/agents/`)
- `.github/prompts/<command>.prompt.md` — prompts da persona (ativos em `.github/prompts/persona-<role>-*.prompt.md`)
- `.github/skills/<skill>/SKILL.md` — modelos mentais reutilizáveis (ativos também em `.github/skills/`)
- `mcp.json` — configuração de servidor MCP (se houver)

Não copie `.github/*` manualmente: isso já foi feito no kit consolidado do repositório. Valide assim:

```bash
# Deve listar agents, prompts, instructions e skills consolidados
ls .github/agents .github/prompts .github/instructions .github/skills

# Se sua persona tiver mcp.json e o facilitador pedir MCP local, copie apenas esse arquivo
# para .vscode/. Caso contrario, pule.
```

### 8.3 Mapeamento persona-para-kit

As 10 personas cobertas pelas 5 pessoas do time estão nestes 10 kits:

| Persona | Kit consolidado |
| --- | --- |
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

Depois que cada persona instalar seu kit, a **pessoa líder do time** atualiza o arquivo `.github/copilot-instructions.md` com os nomes de todo mundo. Encontre esta seção:

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

## 📐 Passo 9 — Instale o Spec-Kit (todos)

[**Spec-Kit**](https://github.com/github/spec-kit) é o toolkit oficial do GitHub para desenvolvimento orientado por especificação. Use para **rascunhos rápidos de funcionalidades** no Estágio 2.

### 9.1 Instale o Specify CLI no seu laptop

O comando oficial usa `uv` e instala diretamente do repositório `github/spec-kit`. Substitua `vX.Y.Z` pela versão mais recente em <https://github.com/github/spec-kit/releases>.

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git@vX.Y.Z
specify version
```

### 9.2 Inicialize no repositório do time

Rode isto uma vez, na raiz do repositório do time:

```bash
specify init . --integration copilot
```

Isso cria a configuração `.specify/`, scripts de automação e os slash commands `/speckit.*` para o GitHub Copilot.

### 9.3 Verifique os comandos no Copilot

Depois de recarregar o VS Code, os comandos principais devem aparecer no painel do Copilot:

| Comando | Quando usar |
| --- | --- |
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
/speckit.specify Permitir que operadores gerem um ciclo mensal de pagamento para beneficiários ativos. Preserve a rastreabilidade legada com source_legacy em cada requisito.
```

O Spec-Kit cria uma branch numerada e a estrutura:

```text
specs/001-payment-cycle-generation/
├── spec.md
└── (outros artefatos criados nos próximos comandos)
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

## 🎯 Passo 10 — Use o fluxo Spec-Kit (todos)

Para o workshop, use esta sequência única do Spec-Kit:

| Fase | Comando | Saída principal | Persona dona |
| --- | --- | --- | --- |
| Constituição | `/speckit.constitution` | `.specify/memory/constitution.md` | Technical Lead + Architect |
| Spec | `/speckit.specify` | `specs/<feature>/spec.md` | Requirements Engineer |
| Clarificação | `/speckit.clarify` | Perguntas resolvidas na spec | Requirements Engineer + Product Owner |
| Plano | `/speckit.plan` | `specs/<feature>/plan.md` | Software Architect |
| Tasks | `/speckit.tasks` | `specs/<feature>/tasks.md` | Technical Lead |
| Análise | `/speckit.analyze` | Lacunas e inconsistências | QA Engineer + Architect |
| Implementação | `/speckit.implement` | Código + testes guiados pela spec | Developer + QA Engineer |

> **Gates LGTM.** O time revisa explicitamente `spec.md`, `plan.md` e `tasks.md` antes de implementar.

---

## 🌿 Passo 11 — Entenda a estratégia de branches

Seu time tem **5 categorias de branches**. Use o tipo certo para o trabalho certo.

```
main                    ← pronto para release, protegido, exige 1 revisão
develop                 ← integração de todas as funcionalidades
spec/NNN-feature        ← trabalho de especificação (Estágio 2)
impl/NNN-feature        ← trabalho de implementação (Estágio 3)
infra/NNN-azure         ← trabalho de infraestrutura (Estágio 4)
```

### Convenção de nomes

| Tipo           | Padrão                 | Exemplo                             |
| -------------- | ---------------------- | ----------------------------------- |
| Spec           | `spec/NNN-kebab-name`  | `spec/001-payment-cycle-generation` |
| Implementação  | `impl/NNN-kebab-name`  | `impl/001-payment-cycle-generation` |
| Infrastructure | `infra/NNN-kebab-name` | `infra/001-azure-deployment`        |

`NNN` é o número da funcionalidade (corresponde à pasta em `specs/NNN-...`).

### Criando uma branch de funcionalidade

```bash
# Garanta que você está em develop com as mudanças mais recentes
git checkout develop
git pull

# Crie sua branch de funcionalidade
git checkout -b spec/001-feature-name

# Trabalhe e faça commit
git add -A
git commit -m "feat: draft EARS requirements"

# Envie para origin
git push -u origin spec/001-payment-cycle-generation
```

### Abrindo um Pull Request

1. Depois do push, o GitHub imprime uma URL como `https://github.com/.../pull/new/spec/001-...`. Clique nela (ou cole no navegador).
2. Título: use Conventional Commits — `feat: add feature spec`
3. Descrição: o GitHub carrega automaticamente o template (`.github/PULL_REQUEST_TEMPLATE.md`). Preencha:

- **O que mudou** (um parágrafo)
- **REQ-IDs implementados** (por exemplo, `REQ-XXX, REQ-YYY`)
- **Como testar** (a pessoa revisora faz pull e roda isto)
- **Issues vinculadas** (por exemplo, `Closes #12`)

4. **Pessoas revisoras**: adicione pelo menos uma pessoa de outra persona.
5. Clique em **Create pull request**.
6. O CI roda (workflow `.github/workflows/ci.yml`). Aguarde a verificação verde.
7. Depois da aprovação, clique em **Rebase and merge** (não Merge commit, não Squash).
8. Delete a branch de funcionalidade quando solicitado.

---

## 🔄 Passo 12 — Fluxo diário por persona

Cada persona tem um **ciclo diário padrão**. Rode-o quantas vezes forem necessárias durante o dia.

### 🧠 Product Owner / Requirements Engineer

```
1. Leia os achados do Estágio 1 (glossário, catálogo de regras de negócio)
2. Rode /speckit.specify "feature-name" com orientação de source_legacy
3. Rode /speckit.clarify e valide com personas stakeholder (PO + EA)
4. Rode /speckit.plan com a stack do workshop e as escolhas arquiteturais
5. Rode /speckit.tasks depois que o plano for aprovado
6. Abra um PR na branch spec/NNN-feature-name
7. Faça passagem para Software Architect (gate LGTM)
```

### 🏗️ Enterprise Architect / Software Architect

```
1. Faça pull do develop mais recente
2. git checkout spec/NNN-feature-name (leia a spec EARS)
3. Rode /speckit.plan → produz plan.md, research.md e contracts
4. Adicione ADRs em docs/adr/ para decisões não triviais
5. Abra um PR — revise a seção de design do PR da spec
6. Faça passagem para Tech Lead (gate LGTM)
```

### 🧠 Technical Lead

```
1. Leia o `plan.md` aprovado e os ADRs
2. Rode /speckit.tasks → produz tasks.md com IDs de tarefa (T001, T002, ...)
3. Abra uma GitHub Issue por tarefa usando .github/ISSUE_TEMPLATE/task.yml
4. Atribua cada issue a Developer / DBA / QA
5. Acompanhe CI verde/vermelho e desbloqueie pessoas
```

### 💻 Developer

```
1. Escolha uma issue de tarefa (T-NNN) no board do time
2. git checkout -b impl/NNN-task-name (a partir de develop)
3. No Copilot, rode `/implement` (prompt ativo: `.github/prompts/persona-developer-implement.prompt.md`)
4. Testes primeiro (vermelho), código (verde), refatoração
5. Rode o gate local definido pelo protótipo (`./mvnw verify`, `npm test`, `npm run lint` ou equivalente)
6. git commit, git push, abra PR
7. Marque a issue com "Closes #NN" no corpo do PR
```

### 🗃️ DBA

```
1. Escolha uma tarefa de schema/migração
2. git checkout -b impl/NNN-migration-name
3. Adicione a migração Flyway em backend/src/main/resources/db/migration/
4. Rode o prompt `/migration` (prompt ativo: `.github/prompts/persona-dba-migration.prompt.md`)
5. Teste localmente contra o Postgres definido pelo time ou via Testcontainers
6. Abra PR e peça revisão de Developer
```

### 🧪 QA Engineer

```
1. Acompanhe todo PR de implementação
2. Rode o prompt /coverage-gaps para encontrar REQ-IDs sem cobertura
3. Adicione testes na branch de implementação (em par com Developer)
4. O prompt /test-strategy produz um plano de testes para novas funcionalidades
5. Bloqueie o merge se a cobertura cair abaixo de 70%
```

### ⚙️ DevOps Engineer

```
1. Escolha uma tarefa de infraestrutura (configuração Azure, CI/CD, deployment)
2. git checkout -b infra/NNN-azure-foo
3. Edite módulos Terraform em infra/
4. Rode `terraform fmt` + `terraform validate` localmente
5. Rode o prompt `/iac-module` (prompt ativo: `.github/prompts/persona-devops-engineer-iac-module.prompt.md`)
6. Abra PR; workflows/ci.yml executa validação Terraform
```

### 📝 Tech Writer

```
1. Depois de cada merge em develop, procure drift em ADR/glossário
2. Rode o prompt `/doc-drift` (prompt ativo: `.github/prompts/persona-tech-writer-doc-drift.prompt.md`)
3. Atualize 01-arqueologia/glossary.md, docs/adr/ e os READMEs
4. Abra um PR pequeno por atualização de documentação
```

---

## 🚦 Passo 13 — Rode o teste de fumaça (time inteiro, às 10:30)

A pessoa líder do time lê cada item em voz alta. Cada pessoa confirma no próprio laptop.

- [ ] Cada membro clonou `hackathon-team-XX`
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

### O nome `hackathon-team-XX` já está em uso

- Confirme se você está usando o número correto do seu time.
- Se a facilitação autorizar, adicione um sufixo curto, por exemplo `hackathon-team-01b`.

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

- Atualize o VS Code para **1.93 ou posterior** (ou instale **VS Code Insiders**, que sempre tem esse recurso).
- Recarregue a janela: Command Palette → **Developer: Reload Window**.

### "Permission denied" ao fazer push para `main`

- A proteção de branch (Passo 4) está fazendo seu trabalho. Abra um Pull Request a partir da sua branch de funcionalidade.

### Fiz pull do `develop` mais recente, mas minha IDE ainda mostra código antigo

- Recarregue a janela do VS Code: Command Palette → **Developer: Reload Window**.
- Se o VS Code ainda mostrar estado antigo, feche e reabra a pasta do repositório.

### A pasta `.github/` parece quebrada

- Não copie persona-kits manualmente por cima da `.github/` consolidada.
- Se algo parecer quebrado: restaure a pasta com `git checkout develop -- .github/` ou peça ajuda ao facilitador antes de tentar sobrescrever arquivos.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="00-TEAM-FLOW.md"><strong>TEAM-FLOW</strong></a><br/>
<sub>Cronograma de 8h, passagens entre pares, regra dos 20 min, DoD.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="05-personas/OVERVIEW.md"><strong>OVERVIEW das 10 personas</strong></a><br/>
<sub>Tabela comparativa: par, líder de estágio, defaults de emergência.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="README.md">Voltar ao Kit PT-BR</a></sub>

— Paula

</details>
