<!-- markdownlint-disable MD013 MD033 MD041 -->

# Primeiros 15 Minutos — Comece Aqui

> **Trilha:** [Kit do Time](README.md) › **Comece Aqui**

**Para você que acabou de chegar e quer saber: "o que eu faço agora?"** Não importa se você é Product Owner, Tech Writer, Desenvolvedor(a), analista de negócio ou DBA — os 15 minutos abaixo servem para todo mundo.

![Início](https://img.shields.io/badge/In%C3%ADcio-00-171717?style=flat-square) ![Duração 15 min](https://img.shields.io/badge/Dura%C3%A7%C3%A3o-15%20min-737373?style=flat-square) ![Público Todo o time](https://img.shields.io/badge/P%C3%BAblico-Todo%20o%20time-A3A3A3?style=flat-square)

| Campo | Valor |
|---|---|
| **Público-alvo** | Qualquer participante, independentemente de perfil técnico |
| **Pré-requisitos** | Nenhum — é apenas leitura |
| **Tempo estimado** | 15 minutos |
| **Estágio** | Pré-aquecimento (antes do Estágio 1) |
| **Resultado esperado** | Você sabe em que par está, o que faz no dia e o que acontece no Estágio 1 |

---

## Cronograma dos 15 minutos

| Minuto | O que fazer | Tempo |
|---|---|---|
| 0–2 | Passo 1 — Confirme em que par você está | 2 min |
| 2–4 | Passo 2 — Abra o cronograma do dia | 2 min |
| 4–6 | Passo 3 — Abra o Glossário Visual | 2 min |
| 6–11 | Passo 4 — Leia o `PERSONA.md` do seu papel | 5 min |
| 11–15 | Passo 5 — Abra o Estágio 1 e a cheat-sheet do Copilot | 4 min |

> [!NOTE]
> Ainda sem setup técnico completo? Tudo bem. Esses 15 minutos são só leitura. O setup técnico é feito depois, guiado pelo `00-SETUP.md`.

---

## Passo 1 — Confirme em que par você está (2 min)

O time tem **5 pessoas e 10 personas** (cada pessoa cobre 2 personas, em um "par").

| Par | Personas | O que vocês fazem |
|---|---|---|
| **1 — Visão** | Product Owner + Requirements Engineer | Decidem **o que** vai ser modernizado |
| **2 — Arquitetura** | Enterprise Architect + Software Architect | Decidem **como** o sistema é organizado |
| **3 — Implementação** | Technical Lead + Developer | Escrevem o **código** |
| **4 — Qualidade** | DBA + QA Engineer | Cuidam dos **dados** e dos **testes** |
| **5 — Operações** | DevOps Engineer + Tech Writer | Cuidam do **deploy** e da **documentação** |

- [ ] **Confirmar o par.** Pergunte ao facilitador em qual par você está. Anote: Meu par: _______ — Minhas personas: _______ + _______

> [!TIP]
> Não é programadora(o)? Tudo bem. PO, RE, Tech Writer e parte do QA não precisam codar. Cada persona tem missão clara — você não vai ficar observando ninguém compilar Java em silêncio.

---

## Passo 2 — Abra o cronograma do dia (2 min)

- [ ] **Abrir `00-TEAM-FLOW.md` em uma aba.** Olhe apenas o cronograma. O dia tem 4 estágios.

![Linha do tempo do dia: pré-evento, 4 estágios e demo, com as três passagens H1, H2, H3](assets/timeline-stages.svg)

**O que prestar atenção:**

- Não dá para pular estágios. O Estágio 2 depende do que sai do Estágio 1.
- **Entre os estágios há uma passagem** — momento em que o par de um estágio entrega ao par do próximo (5 minutos de conversa síncrona). Isso é o que mantém o fluxo do dia.
- Se você travar por mais de **20 minutos**, levante a mão. É regra de todos os times.

---

## Passo 3 — Abra o Glossário Visual (2 min)

Você vai encontrar siglas e termos técnicos hoje (EARS, ADR, REQ-ID, DDM, Flyway, JPA…). Não precisa decorar nenhum. Abra esta página em uma aba e volte quando precisar:

[`07-conceitos/03-glossario-visual.md`](07-conceitos/03-glossario-visual.md)

Cada termo tem 3 linhas: **o que é**, uma **analogia do dia a dia** e **onde aparece**. Use sem culpa.

- [ ] **Abrir o glossário em uma aba do navegador ou VS Code.**

> **Exemplo:** o termo "EARS" pode assustar. O glossário traduz: "forma padrão de escrever requisitos sem ambiguidade — cada requisito segue um gabarito com condição, sujeito, ação e resultado esperado."

---

## Passo 4 — Leia o `PERSONA.md` do seu papel (5 min)

Você tem **duas personas**. Leia o `PERSONA.md` de cada uma:

```text
05-personas/01-product-owner/PERSONA.md
05-personas/02-requirements-engineer/PERSONA.md
05-personas/03-enterprise-architect/PERSONA.md
05-personas/04-software-architect/PERSONA.md
05-personas/05-technical-lead/PERSONA.md
05-personas/06-developer/PERSONA.md
05-personas/07-dba/PERSONA.md
05-personas/08-qa-engineer/PERSONA.md
05-personas/09-devops-engineer/PERSONA.md
05-personas/10-tech-writer/PERSONA.md
```

- [ ] **Ler o `PERSONA.md` da persona A.**
- [ ] **Ler o `PERSONA.md` da persona B.**

**Foque em 3 seções de cada `PERSONA.md`:**

1. **"Onde você aparece em cada estágio"** — tabela de 4 linhas. Vai te dizer se você lidera, apoia ou observa em cada estágio.
2. **"Se travar (defaults de emergência)"** — o que fazer quando estiver perdido(a).
3. **"3 prompts de exemplo"** — copia-e-cola pronto para usar no Copilot.

> [!TIP]
> Se sentir que sua persona "é igual" à outra: olhe **quando** cada uma lidera. Quase nunca lideram juntas; é por isso que duas personas no mesmo par cobrem o dia inteiro sem ficar ociosas.

---

## Passo 5 — Abra o Estágio 1 e a cheat-sheet do Copilot (4 min)

### 5a. Abra o guia do Estágio 1

[`01-arqueologia/GUIDE.md`](01-arqueologia/GUIDE.md)

Leia apenas:

- A seção **"Roteiro cronometrado"** (entregas do Estágio 1)
- A tabela **"Quem lê o quê"** (quais 3 programas Natural seu par lê)
- O roteiro de **11:00–12:00 + 13:30–14:00** (o que seu par faz no Estágio 1)

- [ ] **Ler a seção "Roteiro cronometrado" do GUIDE.md do Estágio 1.**

### 5b. Abra a cheat-sheet dos 3 modos do Copilot

[`09-cheat-sheets/copilot-3-modes.md`](09-cheat-sheets/copilot-3-modes.md)

Isso vai poupar 30 minutos de confusão. Os 3 modos do Copilot:

| Modo | Quando usar | Exemplo de uso no SIFAP |
|---|---|---|
| **Ask** | Quero entender algo | *"Explique este trecho do programa Natural SIFAP0001.NSN"* |
| **Plan** | Quero alterar código com calma | *"Planeje a validação de CPF — me mostre antes de fazer"* |
| **Agent** | Quero delegar uma feature inteira | Issue do Estágio 4 para o Copilot Agent |

- [ ] **Abrir a cheat-sheet em uma aba.**

### 5c. Se você nunca abriu o Copilot Chat

- VS Code → ícone do Copilot na barra lateral → abra o chat
- Não vê o ícone? Pergunte ao facilitador. A extensão pode não estar ativada.

---

## Checklist dos primeiros 15 minutos

Antes de avançar, verifique:

- [ ] Sei em qual par estou e quais são minhas 2 personas
- [ ] Tenho o `00-TEAM-FLOW.md` aberto em uma aba (cronograma do dia)
- [ ] Tenho o `glossario-visual.md` aberto em outra aba (para consultar jargão)
- [ ] Li o `PERSONA.md` das minhas 2 personas (foquei nas 3 seções recomendadas)
- [ ] Sei o que vai acontecer no Estágio 1
- [ ] Sei o que são os 3 modos do Copilot (Ask, Plan, Agent)

Se tudo está marcado, **você está pronto(a)**. Vá para o setup técnico (`00-SETUP.md`) ou direto para o Estágio 1, conforme o cronograma do dia.

---

## Primeira hora — roteiro minuto a minuto (para quem nunca usou VS Code ou Copilot)

Se você nunca abriu VS Code, Docker ou Copilot, este roteiro literal coloca você pronto(a) em 60 minutos. Faça **em ordem**, sem pular.

> [!TIP]
> Faça com alguém do seu par ao lado. Duas pessoas passam por problemas de setup em metade do tempo.

| Minuto | Ação | Como saber que funcionou |
|---:|---|---|
| **00** | Abrir o terminal e rodar `cd ~/Code/workshop-team-XX` | Aparece o nome do repositório no prompt |
| **02** | `code .` para abrir o VS Code | VS Code abriu mostrando a lista de pastas (`00-…`, `01-…`) |
| **04** | Abrir terminal integrado (`Ctrl+\``) e rodar `git status` | Branch e estado do repositório aparecem sem erro |
| **08** | Validar ferramentas: `java -version`, `node --version`, `git --version` | Cada comando imprime uma versão |
| **13** | Validar Docker (sem subir nada ainda): `docker --version` | O comando imprime uma versão do Docker |
| **18** | Validar Spec-Kit: `specify version` | O comando imprime uma versão do Specify CLI |
| **20** | Voltar ao VS Code → ícone do Copilot na barra lateral | Painel do Copilot Chat abre à direita |
| **22** | No chat, digitar: *"Olá! O que você é capaz de fazer?"* | Copilot responde em PT-BR sobre os 3 modos |
| **25** | Selecionar o agente do dia no dropdown do chat | Você vê `@archaeologist`, `@architect`, `@builder`, `@evolution` na lista |
| **28** | Abrir 2 abas no navegador: [`00-TEAM-FLOW.md`](00-TEAM-FLOW.md) e [`07-conceitos/03-glossario-visual.md`](07-conceitos/03-glossario-visual.md) | Duas abas fixas para referência |
| **32** | Abrir suas 2 pastas de persona em `05-personas/0X-…/` e ler `PERSONA.md` de cada | Você sabe quais são suas 2 missões do dia |
| **42** | Validar a `.github/` consolidada: `ls .github/agents .github/prompts .github/skills` | Pastas existem e já têm agents, prompts e skills |
| **45** | Recarregar VS Code: `Cmd+Shift+P` → *Reload Window* | Slash commands como `/ears-convert` aparecem ao digitar `/` no Chat |
| **50** | Abrir [`01-arqueologia/GUIDE.md`](01-arqueologia/GUIDE.md) e ler seção "Quem lê o quê" | Você sabe quais 3 programas `.NSN` seu par vai ler |
| **55** | Combinar com seu par quem cobre qual persona | Vocês dois sabem quem faz o quê |
| **60** | Você está pronto(a) para começar o Estágio 1 | — |

### Se algo travar nesse roteiro

| Travou em… | Vá para |
|---|---|
| Minuto 04 (terminal/Git) | [`docs/troubleshooting.md`](docs/troubleshooting.md) — seção *Setup* |
| Minuto 13 (Docker) | [`docs/troubleshooting.md`](docs/troubleshooting.md) — seção *Docker* |
| Minuto 20 (Copilot não abre) | [`docs/troubleshooting.md`](docs/troubleshooting.md) — seção *Copilot* |
| Minuto 45 (slash command não funciona) | [`docs/troubleshooting.md`](docs/troubleshooting.md) — seção *"Slash command não aparece"* |

> [!WARNING]
> Travou há mais de 20 minutos? Pare e peça ajuda. Regra definida em `00-TEAM-FLOW.md` §6.

---

## Situações comuns nos primeiros 15 minutos

<details>
<summary><strong>FAQ — clique para expandir</strong></summary>

| Situação | O que fazer |
|---|---|
| Não sei em que par estou | Pergunte ao facilitador da sala |
| Não acho meu `PERSONA.md` | A pasta é `05-personas/0X-nome/PERSONA.md` — confira o número no Passo 1 |
| Termo do glossário não está claro | Abra `07-conceitos/03-glossario-visual.md` e use Ctrl+F |
| VS Code ou Copilot não abre | Vá para `00-SETUP.md` § "Passo 1 — Pré-requisitos" |
| O cronograma parece muito apertado | É apertado mesmo. Confie na divisão por par — você não vai fazer tudo sozinho(a) |
| Não programo. Vou ficar perdido(a)? | Não. Veja `01-arqueologia/legado-sifap/COMO-LER-NATURAL.md` (para o Estágio 1) e os defaults da sua `PERSONA.md` |

</details>

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Kit do Time](README.md)<br/><sub>Hub deste repositório: comece aqui se nunca abriu o kit.</sub> | [TEAM-FLOW](00-TEAM-FLOW.md)<br/><sub>Cronograma de 8h, passagens entre pares, regra dos 20 min, DoD.</sub> |

<sub>[Voltar ao índice do kit](README.md)</sub>
