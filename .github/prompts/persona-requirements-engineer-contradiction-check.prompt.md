---
name: "contradiction-check"
agent: "requirements-engineer"
description: "Detecte contradições entre requisitos em spec.md — mesma feature, regras diferentes — antes que virem bugs em produção."
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /contradiction-check

## Objetivo

Você é o requirements engineer auditando `spec.md` em busca de **contradições**: pares de requisitos que não podem ser satisfeitos ao mesmo tempo. Contradições descobertas agora são correções de spec; contradições descobertas em produção são incidentes. O entregável é uma lista de candidatos a conflito com evidência, severidade e resolução proposta.

## Entradas

Peça ao usuário o que estiver faltando.

- O arquivo de spec (`specs/<NNN>-<feature>/spec.md`).
- Quaisquer specs pai relacionadas cujos REQ-IDs sejam referenciados por esta.
- A constituição (`.specify/memory/constitution.md`) — contradições também devem ser verificadas contra regras constitucionais.
- Qualquer log de esclarecimento já produzido por `/speckit.clarify`.

## Processo

1. **Indexe todos os requisitos.** Para cada `REQ-ID`, capture: padrão EARS, gatilho (evento/estado/condição), ação, ator, resultado e limites quantitativos.
2. **Faça varredura em pares dentro de cada domínio.** Agrupe REQ-IDs por domínio (`PAY-*`, `BEN-*` etc.). Compare cada par. Pares entre domínios vêm depois.
3. **Procure as quatro contradições clássicas.**
 - **Contradição direta** — REQ-A diz "the system shall X under condition C"; REQ-B diz "the system shall not X under condition C."
 - **Conflito de limite** — REQ-A diz "respond within 200 ms"; REQ-B diz "perform 5 sequential checks each up to 80 ms" — os orçamentos não podem ser cumpridos juntos.
 - **Conflito de estado** — REQ-A permite uma ação enquanto está no estado S1; REQ-B a proíbe durante o estado sobreposto S2 ⊆ S1.
 - **Conflito de ator** — REQ-A concede permissão ao papel R1; REQ-B proíbe a mesma operação ao papel R2 onde R2 ⊇ R1.
4. **Verifique contra a CONSTITUTION.** Qualquer requisito que viole uma regra constitucional é uma contradição com a própria constituição (normalmente regras C de segurança, dados ou compliance).
5. **Verifique contra invariantes do legado.** Se um REQ contradiz comportamento imposto pelo SIFAP legado (documentado em `01-arqueologia/legado-sifap/legacy-docs/REGRAS-NEGOCIO-2012.md`), sinalize como risco de regressão.
6. **Pontue a severidade.**
 - **Critical** — contradição direta, sem implementação possível que satisfaça ambos.
 - **Major** — conflito de limite ou estado resolvível apenas alterando um REQ.
 - **Minor** — divergência terminológica escondendo um acordo real.
7. **Proponha resoluções.** Para cada achado, sugira uma opção: (a) mesclar REQs, (b) dividir REQs por subcondição, (c) restringir o escopo de um REQ, (d) escalar para o product owner.

## Saída

Um relatório Markdown:

```markdown
## Relatório de Contradições — <feature>

### Resumo
- Requisitos analisados: <quantidade>
- Achados: <quantidade por severidade>
- Maior severidade: <REQ-A vs REQ-B, se houver>

### Critical
| # | REQ-A | REQ-B | Tipo | Evidência | Resolução proposta |
|---|-------|-------|------|----------|---------------------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

### Major
| # | REQ-A | REQ-B | Tipo | Evidência | Resolução proposta |
|---|-------|-------|------|----------|---------------------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

### Minor
| # | REQ-A | REQ-B | Tipo | Evidência | Resolução proposta |
|---|-------|-------|------|----------|---------------------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

### Conflitos constitucionais
| # | REQ | Regra | Conflito |
|---|-----|------|---------|
| — | nenhum encontrado | | |

### Riscos de regressão legada
| # | REQ | Invariante legado | Conflito |
|---|-----|------------------|---------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

### Próximo passo recomendado
Resolver achados Critical e Major antes da aprovação da spec.
```

## Antipadrões

- Relatar "the spec is contradictory" sem nomear os pares. Revisores não conseguem agir.
- Verificar apenas dentro de um domínio. Muitas contradições cruzam domínios.
- Ignorar a constituição. Conflitos constitucionais têm severidade maior que conflitos entre REQs pares.
- Confundir ambiguidade com contradição. Ambiguidade é para `/speckit.clarify`; contradição é incompatibilidade.
- Resolver silenciosamente na própria cabeça. Sempre exponha e encaminhe — mesmo quando parecer "obvious".
- Pular verificações de regressão legada. A modernização do SIFAP vive ou morre pela fidelidade ao legado.
- Tratar conflitos de limite como "can fix in design". Se a matemática não fecha, o REQ está errado.

## Critérios de sucesso

- [ ] Todo achado cita dois REQ-IDs (ou um REQ-ID e uma regra constitucional, ou um REQ-ID e um invariante legado).
- [ ] Achados classificados por tipo (Direct / Threshold / State / Actor) e severidade (Critical / Major / Minor).
- [ ] Cada achado tem uma resolução proposta em uma linha.
- [ ] Conflitos constitucionais verificados.
- [ ] Riscos de regressão legada verificados contra `01-arqueologia/legado-sifap/legacy-docs/`.
- [ ] Achados Critical e Major sinalizados para resolução antes do sign-off da fase.
- [ ] Saída pronta para colar no PR da spec ou em um ticket de esclarecimento.
