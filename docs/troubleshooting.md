<!-- markdownlint-disable MD013 MD033 MD041 -->

# Troubleshooting Consolidado

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **Troubleshooting**

**Guia de diagnóstico e resolução para os erros mais comuns do workshop** — pesquise com `Ctrl+F` pelo sintoma.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time |
| **Como usar** | `Ctrl+F` no sintoma. Se não encontrar, consulte [FAQ.md](FAQ.md) |
| **Resultado esperado** | Problema resolvido com os passos descritos |

---

## Índice

- [Setup e ambiente](#setup-e-ambiente)
- [Copilot, agente e persona](#copilot-agente-e-persona)
- [Spec-Kit e EARS](#spec-kit-e-ears)
- [Backend — Java e Spring Boot](#backend--java-e-spring-boot)
- [Frontend — Next.js e Node](#frontend--nextjs-e-node)
- [Docker](#docker)
- [Git e GitHub](#git-e-github)
- [Terraform e Azure](#terraform-e-azure)
- [Plano B — Copilot fora do ar](#plano-b--copilot-fora-do-ar)

---

## Setup e ambiente

### Ferramentas locais ausentes (Java, Node, Maven)

| Campo | Detalhe |
|---|---|
| **Sintoma** | Mensagem de erro "command not found" para `java`, `node` ou `mvn` |
| **Causa provável** | Ferramentas locais ainda não instaladas |
| **Correção** | Instale as versões especificadas em [`00-SETUP.md`](../00-SETUP.md) e valide com `java -version`, `node --version` e `git --version` |
| **Como confirmar** | Cada um dos três comandos retorna a versão esperada sem erro |

### "git: command not found" no terminal do VS Code (Mac)

| Campo | Detalhe |
|---|---|
| **Sintoma** | Erro ao tentar executar qualquer comando `git` |
| **Causa provável** | Xcode CLI tools não instaladas |
| **Correção** | Execute `xcode-select --install` e siga o assistente |
| **Como confirmar** | `git --version` retorna versão sem erro |

---

## Copilot, agente e persona

### Slash command não aparece no Chat

| Campo | Detalhe |
|---|---|
| **Sintoma** | `/ears-convert`, `/tdd` ou outros comandos não aparecem nas sugestões |
| **Causa provável** | VS Code ainda não recarregou a `.github/` consolidada, ou a janela foi aberta fora da raiz do repositório |
| **Correção** | Confirme que existem arquivos em `.github/prompts/` e recarregue a janela: `Cmd+Shift+P` → _Developer: Reload Window_ |
| **Como confirmar** | Comandos aparecem ao digitar `/` no Chat |

> [!CAUTION]
> Nunca crie cópias paralelas de agents, prompts ou skills fora de `.github/`. Ela é a única fonte ativa e não deve ser editada.

### "Não consigo selecionar `@archaeologist` no Chat"

| Campo | Detalhe |
|---|---|
| **Sintoma** | O agente `@archaeologist` não aparece no seletor do Chat |
| **Causa 1** | A pasta `06-agentes-de-estagio/` não está no workspace |
| **Causa 2** | Extensão GitHub Copilot Chat desatualizada |
| **Correção** | Execute `ls 06-agentes-de-estagio/` para confirmar a presença da pasta. Atualize a extensão na aba de extensões do VS Code |
| **Como confirmar** | O agente aparece no dropdown do Chat |

### Copilot respondendo fora de contexto

| Campo | Detalhe |
|---|---|
| **Sintoma** | Respostas genéricas, sem relação com o SIFAP ou o estágio atual |
| **Causa provável** | Nenhum agente de estágio selecionado, ou agente errado selecionado |
| **Correção** | Confirme com o time o estágio atual e selecione o agente correspondente no dropdown do Chat |
| **Como confirmar** | As respostas passam a referenciar o contexto do estágio e do legado |

### "Quero usar Plan mode mas só aparece Ask"

| Campo | Detalhe |
|---|---|
| **Sintoma** | Modo Plan não está disponível |
| **Causa provável** | Versão antiga da extensão Copilot |
| **Correção** | Atualize a extensão GitHub Copilot Chat no VS Code |
| **Como confirmar** | O modo Plan aparece no seletor de modos |

---

## Spec-Kit e EARS

### "`specify version` retorna comando não encontrado"

| Campo | Detalhe |
|---|---|
| **Sintoma** | Erro ao executar qualquer comando `specify` |
| **Causa provável** | Spec-Kit não instalado |
| **Correção** | Execute os comandos abaixo |
| **Como confirmar** | `specify version` retorna um número de versão |

```bash
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git
specify version
```

### CI rejeitou o PR: `missing source_legacy`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Pull request bloqueado pelo CI com erro de rastreabilidade |
| **Causa provável** | Uma ou mais EARS não têm a linha `source_legacy:` |
| **Correção** | Abra `specs/<NNN>-<feature>/spec.md`, localize REQ-IDs sem `source_legacy:` e adicione o campo apontando para `01-arqueologia/legado-sifap/...#L<linha>` ou marcando `[GREENFIELD] <motivo>` |
| **Como confirmar** | CI passa na próxima execução |

Veja [`07-conceitos/05-notacao-ears.md`](../07-conceitos/05-notacao-ears.md) para o formato correto.

### `/speckit.clarify` está fazendo muitas perguntas

| Campo | Detalhe |
|---|---|
| **Sintoma** | O comando levanta 10 ou mais perguntas |
| **Causa** | Não é um problema — é o comportamento esperado |
| **Ação** | Responda todas as perguntas. Cada uma evita um bug futuro |

---

## Backend — Java e Spring Boot

### Backend não sobe — erro de conexão com Postgres

| Campo | Detalhe |
|---|---|
| **Sintoma** | Erro `Connection refused` ou similar ao iniciar o backend |
| **Causa provável** | Postgres não está em execução ou a URL em `application.yml` está incorreta |
| **Correção** | Verifique `application.yml` e suba o Postgres pelo método definido pelo time (local, Testcontainers ou Docker Compose) |
| **Como confirmar** | Backend sobe e responde em `/actuator/health` |

### Flyway: `Migration checksum mismatch`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Erro do Flyway ao subir o backend |
| **Causa provável** | Um arquivo de migration existente foi editado após ter sido aplicado |
| **Correção** | Restaure a versão original via `git log` e crie um novo arquivo `V<N+1>__descricao.sql` |
| **Como confirmar** | Backend sobe sem erros do Flyway |

> [!CAUTION]
> Nunca edite arquivos de migration já aplicados (V1, V2, V3...). Sempre crie um arquivo novo com o próximo número de versão.

### Testcontainers: `Could not find a valid Docker environment`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Testes que usam Testcontainers falham com erro de ambiente Docker |
| **Causa provável** | Docker não está em execução ou o socket está em caminho diferente do padrão |
| **Correção (macOS)** | `export DOCKER_HOST=unix:///var/run/docker.sock` ou `export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock` |
| **Como confirmar** | Testes passam na próxima execução |

---

## Frontend — Next.js e Node

### Frontend mostra `ECONNREFUSED localhost:8080`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Página do frontend exibe erro de conexão recusada |
| **Causa provável** | Backend não está em execução ou está em porta diferente |
| **Correção** | Confirme que o backend está rodando e que a URL no frontend aponta para a porta correta |
| **Como confirmar** | Página carrega dados normalmente |

### `Module not found: shadcn/ui`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Erro de módulo não encontrado ao iniciar o frontend |
| **Causa provável** | Dependências não instaladas |
| **Correção** | `cd frontend && npm install` |
| **Como confirmar** | Frontend inicia sem erros de módulo |

---

## Docker

### `Cannot connect to the Docker daemon`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Qualquer comando Docker falha com erro de daemon |
| **Causa provável** | Docker Desktop parado |
| **Correção** | Abra o Docker Desktop e aguarde o serviço inicializar completamente |
| **Como confirmar** | `docker ps` retorna a lista de containers sem erro |

### `port is already allocated`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Container não sobe por conflito de porta |
| **Causa provável** | Porta 5432, 8080 ou 3000 já está em uso por outro processo |
| **Correção** | Execute `lsof -i :8080` para identificar o processo e encerrá-lo, ou ajuste a porta na configuração local |
| **Como confirmar** | Container sobe sem erro de porta |

### `Out of memory` no Docker Desktop

| Campo | Detalhe |
|---|---|
| **Sintoma** | Containers falham ou ficam lentos; aviso de memória |
| **Causa provável** | Limite de RAM alocado ao Docker Desktop muito baixo |
| **Correção** | Docker Desktop → Settings → Resources → Memory → 8 GB ou mais |
| **Como confirmar** | Containers sobem e respondem normalmente |

---

## Git e GitHub

### Push rejeitado: `protected branch`

| Campo | Detalhe |
|---|---|
| **Sintoma** | `git push` rejeitado com mensagem de branch protegida |
| **Causa provável** | Tentativa de push direto em `main` ou `develop` |
| **Correção** | Crie uma branch e abra um pull request. Veja [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md) |
| **Como confirmar** | Pull request criado com sucesso |

### Conflito de merge

| Campo | Detalhe |
|---|---|
| **Sintoma** | Marcadores `<<<<<<<` aparecem nos arquivos ao fazer merge ou rebase |
| **Causa provável** | Alguém alterou o mesmo arquivo em `develop` antes de você |
| **Correção** | Execute o bloco abaixo, resolva os conflitos manualmente e conclua o rebase |
| **Como confirmar** | `git status` não mostra mais arquivos em conflito |

```bash
git fetch origin
git rebase origin/develop
# Resolva os conflitos nos arquivos com marcadores
git add <arquivo>
git rebase --continue
```

### Commit feito diretamente em `develop` por engano

```bash
git reset --soft HEAD~1
git stash
git checkout -b nova-branch
git stash pop
git commit -m "..."
```

### `gh: command not found`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Erro ao usar qualquer comando `gh` |
| **Causa provável** | GitHub CLI não instalado |
| **Correção** | `brew install gh && gh auth login` |
| **Como confirmar** | `gh --version` retorna versão sem erro |

---

## Terraform e Azure

### `Error: building AzureRM Client`

| Campo | Detalhe |
|---|---|
| **Sintoma** | Terraform falha ao inicializar o provider Azure |
| **Causa provável** | Sessão do Azure CLI expirada ou não iniciada |
| **Correção** | Execute `az login` |
| **Como confirmar** | `terraform plan` executa sem erro de autenticação |

### `terraform plan` mostra centenas de recursos novos

| Campo | Detalhe |
|---|---|
| **Sintoma** | Saída do `plan` lista muitos recursos a criar |
| **Causa** | State file vazio — é o comportamento esperado na primeira execução |
| **Ação** | Revise o plano. Não execute `apply`. |

> [!CAUTION]
> O workshop autoriza somente `terraform plan`. Executar `terraform apply` cria recursos reais no Azure e gera custo financeiro imediato.

---

## Plano B — Copilot fora do ar

Se o Copilot Chat parar de responder por mais de 5 minutos:

> [!WARNING]
> Não aguarde passivamente. O workshop tem 8 horas e cada minuto ocioso tem custo alto para o time.

- [ ] **Recarregar** — tente `Cmd+Shift+P` → _Reload Window_. Se o Copilot voltar, continue normalmente.
- [ ] **Trabalho manual** — se continuar offline, retome os templates e os artefatos já produzidos pelo time.
- [ ] **Estruturar o próximo artefato** — use a evidência disponível, sem inventar dados.
- [ ] **Registrar no PR** — escreva: _"Feito manualmente em X min (Copilot offline)"_ — isso auxilia o relatório do Estágio 4.
- [ ] **Alinhar com o par receptor** — combine que o artefato pode ter menor refinamento que o padrão.

O CI continua validando mesmo com o Copilot offline. O trabalho não para.

| Artefato sem Copilot | Próximo passo |
|---|---|
| EARS no Estágio 2 | Use as descobertas rastreáveis e o fluxo do [Spec-Kit](../09-cheat-sheets/spec-kit-workflow.md) |
| ADR no Estágio 2 | Preencha o [template de ADR](adr/0000-template.md) |
| Implementação no Estágio 3 | Releia as EARS priorizadas, os DDMs e as decisões do time |
| Issue para Agent no Estágio 4 | Escreva contexto, critérios de aceite e rastreabilidade da mudança |

---

## Quando nenhuma solução acima funciona

| Tempo bloqueado | Ação |
|---|---|
| 5 min | Releia o erro com calma. Use Copilot Ask: _"O que esse erro significa: `<cole o erro>`"_ |
| 10 min | Pergunte ao seu par |
| 20 min | Levante a mão para o facilitador (regra do TEAM-FLOW §6) |
| 30 min | Pause essa tarefa e trabalhe em outra enquanto alguém ajuda |

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Kit PT-BR](../README.md)<br/><sub>Hub principal.</sub> | [FAQ](FAQ.md)<br/><sub>Perguntas frequentes.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
