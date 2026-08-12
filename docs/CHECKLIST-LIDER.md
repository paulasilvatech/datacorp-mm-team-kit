<!-- markdownlint-disable MD013 MD033 MD041 -->

# Checklist do Líder do Time

![Checklist](https://img.shields.io/badge/Tipo-Checklist-171717?style=flat-square)
![Persona Technical Lead](https://img.shields.io/badge/Persona-Technical%20Lead-737373?style=flat-square)
![Duração O dia inteiro](https://img.shields.io/badge/Dura%C3%A7%C3%A3o-O%20dia%20inteiro-A3A3A3?style=flat-square)

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **Checklist do Líder**

**Lista cronológica de verificações para o Technical Lead** — do período anterior ao workshop até a demonstração final.

| Campo | Valor |
|---|---|
| **Público-alvo** | Pessoa com a persona Technical Lead (Par 3) |
| **Pré-requisitos** | Ter lido [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) |
| **Resultado esperado** | Time em ritmo, passagens no horário, demo executada |

---

## Antes do workshop começar (D-1, noite anterior)

- [ ] **Verificar laptops** — 5 laptops com VS Code Insiders instalado.
- [ ] **Verificar contas GitHub** — 5 contas com Copilot ativo (verificar em <https://github.com/settings/copilot>).
- [ ] **Verificar repositório** — `workshop-team-XX` criado e clonado por todos.
- [ ] **Validar ferramentas locais** — Git, Java 21, Node, Docker e Spec-Kit funcionando em pelo menos 1 laptop.
- [ ] **Proteger branch** — branch `develop` criada e protegida.
- [ ] **Confirmar presença** — todos os 5 membros confirmados (par + 2 personas cada).

---

## Hora a hora — pontos de verificação

### 10:00–11:00 · Setup e personas

- [ ] **10:15** — Todos os laptops abriram o repositório no VS Code.
- [ ] **10:30** — Git, Java/Node, Docker e Spec-Kit validados em todos os laptops.
- [ ] **10:45** — Cada pessoa leu seus 2 `PERSONA.md` e confirmou que `.github/` está consolidada.
- [ ] **10:55** — Cada pessoa testou um slash command da sua persona.

### 11:00–12:00 · Estágio 1 — Arqueologia (parte 1)

- [ ] **11:00** — Time inteiro selecionou `@archaeologist` no Chat.
- [ ] **11:10** — Cada par sabe quais 3 programas Natural vai ler.
- [ ] **11:30** — Stand-up de 2 minutos: cada par diz 1 frase do que descobriu.
- [ ] **11:45** — Cada par registrou evidências e dúvidas dos programas atribuídos.

### 13:30–14:00 · Estágio 1 — Síntese e Passagem H1

- [ ] **13:35** — Catálogo contém fontes das regras candidatas ao recorte.
- [ ] **13:45** — Product Owner escolheu uma feature fina e registrou adiamentos.
- [ ] **13:50** — Facilitador validou `LEGACY-EXPLORATION-CHECKLIST.md`.
- [ ] **14:00** — **Passagem H1**: Par 1 entrega `discovery-report.md` ao Par 2.

> [!WARNING]
> Se às 13:50 falta `Programa Fonte` em qualquer regra, pause tudo e foque em preencher. O CI rejeita pull requests sem esse campo.

### 14:00–15:00 · Estágio 2 — Spec Moderna

- [ ] **14:05** — Time selecionou `@architect`.
- [ ] **14:30** — Product Owner aprovou uma feature fina.
- [ ] **14:45** — `spec.md`, `plan.md` e `tasks.md` estão na pasta da feature.
- [ ] **15:00** — **Passagem H2**: artefatos formais entregues aos Pares 3 e 4.

> [!WARNING]
> Qualquer REQ-ID sem `source_legacy:` bloqueia o pull request. Verifique cada um antes da passagem.

### 15:00–16:10 · Estágio 3 — Implementação

- [ ] **15:05** — Time selecionou `@builder`.
- [ ] **15:30** — Migration Flyway V2 criada e executando localmente.
- [ ] **15:50** — 1 ou mais endpoints REST funcionando via Swagger.
- [ ] **16:00** — Pelo menos 1 teste passando.
- [ ] **16:10** — **Passagem H3**: código mergeado em `develop`, CI verde.

> [!WARNING]
> CI com falha ou cobertura abaixo de 70%: priorize a correção antes de adicionar novas funcionalidades.

### 16:10–16:50 · Estágio 4 — Evolução com Agent

- [ ] **16:15** — Time selecionou `@evolution`.
- [ ] **16:20** — Pelo menos 1 Issue bem escrita para o Copilot Agent.
- [ ] **16:35** — Pull request disponível revisado; se não houver PR, próximo passo registrado.
- [ ] **16:45** — Situação de CI/IaC registrada, sem criar infraestrutura por meta.
- [ ] **16:50** — `agent-experience-report.md` preenchido.

### 16:50–17:00 · Preparação da demo

- [ ] **Combinar falas** — cada par tem 30 segundos definidos.
- [ ] **Testar execução** — demo testada uma vez com o modo criado pelo time.
- [ ] **Preparar navegador** — Swagger, frontend e PR mergeado abertos e prontos.

### 17:00–17:30 · Demonstrações

- [ ] Product Owner conduz e controla o tempo.
- [ ] Time inteiro visível na câmera.
- [ ] SIFAP 2.0 em execução demonstrado ao vivo.

---

## As 3 perguntas que o Technical Lead faz a cada 30 minutos

```
1. Alguém está bloqueado há mais de 20 minutos?
2. O CI está verde?
3. A próxima passagem (H1/H2/H3) está no horário?
```

Qualquer resposta negativa exige intervenção imediata.

---

## Respostas de emergência

| Situação | Ação do Technical Lead |
|---|---|
| Par sem direção há 15 minutos | Sentar com eles e perguntar: "qual é o objetivo agora?" |
| CI com falha há 30 minutos | Parar outras frentes e concentrar o time na correção |
| Product Owner mudou escopo após o H2 | Negar a mudança. O escopo trava no H2. |
| Dev quer refatorar sem teste existente | Negar. Abortar refatoração sem cobertura. |
| Agent gerou pull request de baixa qualidade | Não fazer merge. Solicitar ajustes ou implementar manualmente. |
| Falta meia hora e a demo não funciona | Reduzir o escopo da demo, não tentar corrigir o problema. |
| Copilot indisponível | Plano B em [troubleshooting.md](troubleshooting.md#plano-b--copilot-fora-do-ar). |

---

## Objetivo do Technical Lead

> O papel do Technical Lead não é fazer o trabalho de todos — é garantir que ninguém esteja parado.

Você contribui com código na mesma proporção que os outros. Sua responsabilidade diferenciada é manter o **ritmo** e o **escopo**.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [TEAM-FLOW](../00-TEAM-FLOW.md)<br/><sub>Cronograma completo do dia.</sub> | [Lições aprendidas](lessons-learned.md)<br/><sub>Erros comuns dos times.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
