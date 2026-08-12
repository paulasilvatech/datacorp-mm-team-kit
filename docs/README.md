<!-- markdownlint-disable MD013 MD033 MD041 -->

# Documentação

> **Trilha:** [Kit do Time](../README.md) › **Docs**

**Índice da documentação transversal do workshop** — recursos consultados em qualquer estágio do dia.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time, especialmente Tech Writer e Technical Lead |
| **Pré-requisitos** | Ter lido [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) |
| **Tempo estimado** | 5 min |
| **Resultado esperado** | Saber onde encontrar cada recurso transversal |

---

## Como usar esta pasta

- [ ] **Antes de começar o dia** — leia [sdlc-flow-guide.md](sdlc-flow-guide.md) para entender o mapa completo.
- [ ] **Ao escolher suas personas** — leia [persona-agent-matrix.md](persona-agent-matrix.md) para saber quando você protagoniza, apoia ou observa.
- [ ] **Durante o Estágio 1** — atualize o [glossário do Estágio 1](../01-arqueologia/glossary.md) e registre termos com fonte no legado.
- [ ] **A cada decisão técnica** — crie um ADR em [adr/](adr/).
- [ ] **Ao final do dia** — revise [runbook.md](runbook.md) para que outra pessoa consiga executar e operar o sistema.

## Estrutura

| Caminho | Finalidade |
|---|---|
| [`adr/`](adr/) | Registros de decisão de arquitetura (um arquivo por decisão) |
| [`../01-arqueologia/glossary.md`](../01-arqueologia/glossary.md) | Glossário de domínio — preenchido durante o Estágio 1 |
| [`4-agents-explained.md`](4-agents-explained.md) | Explicação dos 4 agentes de etapa e sua relação com persona-kits |
| [`persona-agent-matrix.md`](persona-agent-matrix.md) | Matriz de quem protagoniza, apoia ou observa em cada etapa |
| [`sdlc-flow-guide.md`](sdlc-flow-guide.md) | Fluxo completo do dia, passagens e entregáveis |
| `api.md` _(criado pelo time)_ | Visão geral da OpenAPI e resumo dos endpoints |
| [`runbook.md`](runbook.md) | Como executar o sistema localmente, em CI e no Azure |

## Convenções

- Um ADR por decisão. Numere-os em sequência: `0001-title.md`, `0002-title.md`.
- Termos do glossário em ordem alfabética, com citações para o programa legado onde o termo se originou.
- Todo README em subpastas segue [`.github/copilot-instructions.md`](../.github/copilot-instructions.md).
- Toda decisão importante vira ADR. Conversa em chat não é registro suficiente.
- Todo termo do glossário que nasceu do legado precisa de fonte (`.NSN`, `.ddm` ou documento histórico).

## Definição de pronto da documentação

- [ ] Glossário com fontes do legado.
- [ ] ADRs com contexto, opções, decisão e consequências.
- [ ] Runbook com comandos de execução, validação e troubleshooting.
- [ ] Links internos apontam para arquivos corretos.
- [ ] Documentos explicam o motivo antes do passo a passo.

## Links rápidos

- [Fluxo da equipe](../00-TEAM-FLOW.md)
- [Persona kits consolidados](../05-personas/) — leia `PERSONA.md` dentro do kit do seu papel
- [Guias de estágio](../01-arqueologia/GUIDE.md)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Cartões de Referência](../09-cheat-sheets/README.md)<br/><sub>3 cartões de 1 página: Copilot, Spec-Kit, modelos.</sub> | [Glossário Visual](../07-conceitos/03-glossario-visual.md)<br/><sub>30+ termos técnicos do domínio SIFAP.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
