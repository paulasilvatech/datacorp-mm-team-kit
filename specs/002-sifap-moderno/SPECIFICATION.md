<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# SPECIFICATION — SIFAP 2.0

![ESTÁGIO 02 Spec](https://img.shields.io/badge/ESTÁGIO-02%20Spec-00A4EF?style=for-the-badge) ![NOTAÇÃO EARS](https://img.shields.io/badge/NOTAÇÃO-EARS-1A1A1A?style=for-the-badge) ![RASTREIO source_legacy](https://img.shields.io/badge/RASTREIO-source__legacy-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../../02-spec-moderna/README.md) → **specs/002-sifap-moderno** → **SPECIFICATION**

> **Regra dura:** todo `REQ-NNN` carrega `source_legacy:` apontando para `.NSN`/`.ddm` em [`legado-sifap/`](../../01-arqueologia/legado-sifap/) **ou** `[GREENFIELD]` com justificativa. CI job `legacy-traceability` rejeita PRs que violem.

> Produzido pelo `@architect`. Entrada: [`business-rules-catalog.md`](../../01-arqueologia/business-rules-catalog.md), [`mysteries-found.md`](../../01-arqueologia/mysteries-found.md), [`discovery-report.md`](../../01-arqueologia/discovery-report.md). Marcadores `[NEEDS CLARIFICATION]` resolvem-se via `/speckit.clarify`.

## Convenções

- **REQ-ID:** `REQ-<CTX>-NNN` onde CTX ∈ {CAD, CALC, PGTO, AUD, SEC}.
- **Padrões EARS:** Ubiquitous · Event-driven · State-driven · Optional · Unwanted · Complex.
- **`acceptance:`** sempre testável (entrada → saída esperada).
- **`related_mystery:`** liga o REQ ao mistério do Estágio 1 quando aplicável.

---

## Contexto: Cadastro (REQ-CAD)

### REQ-CAD-001 — Validação de CPF no cadastro

- **Padrão:** Event-driven
- **Requisito:** Quando um beneficiário for cadastrado, o SIFAP deve validar o CPF usando o algoritmo módulo 11 da Receita Federal antes de persistir.
- **source_legacy:** `legado-sifap/natural-programs/VALBENEF.NSN`, `legado-sifap/natural-programs/CADBENEF.NSN`
- **acceptance:** CPF `111.111.111-11` (dígitos repetidos) → erro 400; CPF válido → 201.
- **related_mystery:** dívida técnica §3.3 (CPF reimplementado 4×) → consolidar em um validator.

### REQ-CAD-002 — CPF institucional para dependentes sem documento

- **Padrão:** Optional
- **Requisito:** Onde um dependente não possuir CPF próprio (criança/idoso), o SIFAP deve permitir o CPF institucional `00000000000` **somente** com flag `institucional=true` registrada em auditoria.
- **source_legacy:** `legado-sifap/adabas-ddms/BENEFICIARIO.ddm#L62`
- **acceptance:** CPF `00000000000` sem flag → 400; com flag → 201 + registro de auditoria.
- **related_mystery:** MYS-007 (backdoor institucionalizado — agora rastreável).

### REQ-CAD-003 — Limite de dependentes

- **Padrão:** Unwanted
- **Requisito:** O SIFAP não deve permitir o cadastro de mais de **5** dependentes ativos por beneficiário.
- **source_legacy:** `legado-sifap/natural-programs/CADDEPEND.NSN#L66-L69`
- **acceptance:** 6º dependente ativo → 409 Conflict; 5 dependentes → ok.
- **related_mystery:** MYS-002 / INC-001 (tripla divergência 3/5/10 resolvida pelo PO → 5, ver [ADR-002](../../02-spec-moderna/ADRs/ADR-002-limite-dependentes.md)).

### REQ-CAD-004 — Status "Sênior" para idosos

- **Padrão:** Complex
- **Requisito:** Enquanto um beneficiário estiver ativo, quando sua idade calculada exceder 75 anos, o SIFAP deve atribuir status `SENIOR` **e** emitir notificação ao operador (corrige o comportamento silencioso do legado).
- **source_legacy:** `legado-sifap/natural-programs/CADBENEF.NSN#L167-L169`
- **acceptance:** beneficiário com 76 anos → status `SENIOR` + evento de notificação; 74 anos → `ATIVO`.
- **related_mystery:** MYS-001 (status 'S' silencioso — agora explícito).

### REQ-CAD-005 — Elegibilidade Região 99 auditável

- **Padrão:** Complex
- **Requisito:** Enquanto um beneficiário tiver `codigoRegiao = 99` (internacional/diplomático), quando a elegibilidade for avaliada, o SIFAP deve conceder elegibilidade **e** registrar exceção explícita em auditoria com motivo.
- **source_legacy:** `legado-sifap/natural-programs/VALELEG.NSN#L102-L106`
- **acceptance:** região 99 → elegível + registro `ACAO=EX_REGIAO99` em auditoria; região 01 → fluxo de validação normal.
- **related_mystery:** MYS-008 (backdoor região 99 — agora rastreável).

---

## Contexto: Cálculo (REQ-CALC)

### REQ-CALC-001 — Fórmula de cálculo do benefício base

- **Padrão:** Event-driven
- **Requisito:** Quando um ciclo de pagamento for gerado, o SIFAP deve calcular o valor base como `vlrBase × fatorRegional × fatorIdade × fatorFamilia × fatorRenda × fatorK` (fórmula **multiplicativa**).
- **source_legacy:** `legado-sifap/natural-programs/CALCBENF.NSN#L181-L191`
- **acceptance:** dados de teste do legado → valor idêntico (teste de equivalência, tolerância R$ 0,00).
- **related_mystery:** D-01 (doc diz aditiva, código multiplicativa → código vence) · `[NEEDS CLARIFICATION]` confirmar com SME.

### REQ-CALC-002 — Fator-K parametrizável e auditável

- **Padrão:** Ubiquitous
- **Requisito:** O SIFAP deve obter o Fator-K de uma tabela de configuração versionada por programa social, nunca de constante hardcoded.
- **source_legacy:** `legado-sifap/natural-programs/CADPROG.NSN#L81-L83`
- **acceptance:** alterar Fator-K na config → próximo cálculo usa novo valor; valor default `0.347215` preservado para programas legados.
- **related_mystery:** MYS-003 · `[NEEDS CLARIFICATION]` validar origem legal do `0.347215` com jurídico antes de produção.

### REQ-CALC-003 — Cap de desconto de 30% com exceção judicial

- **Padrão:** Complex
- **Requisito:** Enquanto o total de descontos não-judiciais exceder 30% do valor bruto, quando o cálculo de descontos for executado, o SIFAP deve limitar os descontos não-judiciais a 30% **removendo por ordem de prioridade** (RN-023), sem aplicar cap aos descontos judiciais.
- **source_legacy:** `legado-sifap/natural-programs/CALCDSCT.NSN#L113-L118`
- **acceptance:** descontos não-judiciais = 40% → reduzidos a 30% por prioridade; desconto judicial = 50% → não limitado.
- **related_mystery:** MYS-006 (corrige cap agregado proporcional → remoção por prioridade).

### REQ-CALC-004 — 13º e abono natalino em dezembro

- **Padrão:** Complex
- **Requisito:** Enquanto um beneficiário estiver ativo, quando um ciclo for gerado em dezembro, o SIFAP deve emitir pagamento adicional do 13º **e** adicionar 15% de abono natalino para beneficiários de programas `tipo = 'A'`.
- **source_legacy:** `legado-sifap/natural-programs/BATCHPGT.NSN#L290-L302`, `legado-sifap/natural-programs/CALCBENF.NSN#L243-L260`
- **acceptance:** dezembro + programa tipo A → pagamento 13º com +15%; janeiro → cálculo padrão.
- **related_mystery:** MYS-004 (fórmula sazonal agora documentada).

### REQ-CALC-005 — Correção monetária IPCA versionada

- **Padrão:** State-driven
- **Requisito:** Enquanto um pagamento estiver atrasado mais de 30 dias, o SIFAP deve aplicar correção monetária pela tabela IPCA versionada, e não deve aplicar deflação (fator mínimo = 1,0).
- **source_legacy:** `legado-sifap/natural-programs/CALCCORR.NSN#L43-L82`
- **acceptance:** atraso 60 dias com IPCA positivo → valor corrigido; IPCA negativo → fator 1,0 (sem deflação).
- **related_mystery:** INC-002 / INC-003 (tabela hardcoded 2013 → config versionada).

---

## Contexto: Pagamento (REQ-PGTO)

### REQ-PGTO-001 — Geração de ciclo para beneficiários ativos

- **Padrão:** Event-driven
- **Requisito:** Quando um ciclo mensal for gerado, o SIFAP deve criar registros de pagamento para todos os beneficiários com status `ATIVO`, com status inicial `GERADO`.
- **source_legacy:** `legado-sifap/natural-programs/BATCHPGT.NSN#L178-L186`, `legado-sifap/natural-programs/CALCBENF.NSN#L283`
- **acceptance:** 10 ativos + 2 suspensos → 10 pagamentos com status `GERADO`.
- **related_mystery:** INC-002 (status 'G' agora documentado como `GERADO`).

### REQ-PGTO-002 — Preservação da ordem por CPF (contrato downstream)

- **Padrão:** Ubiquitous
- **Requisito:** O SIFAP deve gerar a remessa de pagamento ordenada por CPF crescente, preservando o contrato implícito com sistemas downstream.
- **source_legacy:** `legado-sifap/natural-programs/BATCHPGT.NSN#L178-L186`
- **acceptance:** remessa gerada → registros em ordem CPF crescente (teste de ordenação).
- **related_mystery:** MYS-009 (ordem virou contrato — preservada deliberadamente).

### REQ-PGTO-003 — Arredondamento financeiro único

- **Padrão:** Ubiquitous
- **Requisito:** O SIFAP deve arredondar todo valor monetário para o centavo mais próximo usando `HALF_UP`, de forma consistente em cálculo, pagamento e conciliação.
- **source_legacy:** `legado-sifap/natural-programs/BATCHPGT.NSN` (BR-03)
- **acceptance:** `R$ 100,125` → `R$ 100,13`; reconciliação cálculo↔pagamento↔conciliação sem divergência.
- **related_mystery:** MYS-005 / INC-004 (unifica 3 estratégias divergentes) · `[NEEDS CLARIFICATION]` validar impacto fiscal da mudança de truncamento → arredondamento.

### REQ-PGTO-004 — Conciliação por match triplo

- **Padrão:** Event-driven
- **Requisito:** Quando o arquivo de retorno bancário for processado, o SIFAP deve conciliar cada registro por match triplo (documento + CPF + competência) e atualizar o status para `PAGO`, `ERRO`, `REJEITADO` ou `DEVOLVIDO`.
- **source_legacy:** `legado-sifap/natural-programs/BATCHCON.NSN`
- **acceptance:** retorno com match exato → `PAGO`; sem match → `ERRO` com motivo.

---

## Contexto: Auditoria (REQ-AUD)

### REQ-AUD-001 — Trilha imutável

- **Padrão:** Unwanted
- **Requisito:** O SIFAP não deve permitir UPDATE nem DELETE em registros da tabela de auditoria.
- **source_legacy:** `legado-sifap/adabas-ddms/AUDITORIA.ddm`
- **acceptance:** tentativa de UPDATE/DELETE → 403 Forbidden; INSERT → ok.

### REQ-AUD-002 — Relatório de auditoria completo (inclui exclusões)

- **Padrão:** Ubiquitous
- **Requisito:** O SIFAP deve incluir registros com `acao = EX` (exclusão) em todos os relatórios de auditoria, corrigindo a ocultação do legado.
- **source_legacy:** `legado-sifap/natural-programs/RELAUDIT.NSN`
- **acceptance:** relatório de período com exclusões → exclusões aparecem; legado as ocultava.
- **related_mystery:** MYS-010 (achado de compliance — corrigido com feature-flag para auditoria retroativa).

### REQ-AUD-003 — Registro de toda alteração de entidade

- **Padrão:** Event-driven
- **Requisito:** Quando qualquer entidade de domínio for alterada, o SIFAP deve gravar um registro de auditoria com estado anterior e posterior em formato JSON, usuário e timestamp UTC.
- **source_legacy:** `legado-sifap/legacy-docs/REGRAS-NEGOCIO-2012.md` (RN-011)
- **acceptance:** alterar status de beneficiário → registro de auditoria com `before`/`after` JSON.

---

## Contexto: Segurança (REQ-SEC) — Greenfield

### REQ-SEC-001 — Autenticação OAuth2/JWT

- **Padrão:** Unwanted
- **Requisito:** O SIFAP não deve expor nenhum endpoint `/api/v1/*` sem token JWT válido, exceto `/health` e `/api/v1/auth/login`.
- **source_legacy:** `[GREENFIELD]` legado usa perfil mainframe; modernização exige OAuth2/JWT via Spring Security.
- **acceptance:** request sem token → 401; com token válido → 200.

### REQ-SEC-002 — Mascaramento de dados sensíveis em logs

- **Padrão:** Ubiquitous
- **Requisito:** O SIFAP deve mascarar CPF e valores de benefício em todos os logs usando o formato `XXX.XXX.NNN-NN`.
- **source_legacy:** `[GREENFIELD]` LGPD + política de segurança (OWASP) — inexistente no legado.
- **acceptance:** log de cadastro → CPF aparece mascarado; valor não aparece em claro.

---

## Resumo de Rastreabilidade

| Contexto   | REQ-IDs | Com `source_legacy` legado | Greenfield | `[NEEDS CLARIFICATION]` |
| ---------- | ------- | -------------------------- | ---------- | ----------------------- |
| Cadastro   | 5       | 5                          | 0          | 0                       |
| Cálculo    | 5       | 5                          | 0          | 3 (REQ-CALC-001/002, REQ-PGTO-003) |
| Pagamento  | 4       | 4                          | 0          | 1                       |
| Auditoria  | 3       | 3                          | 0          | 0                       |
| Segurança  | 2       | 0                          | 2          | 0                       |
| **Total**  | **19**  | **17**                     | **2**      | **4**                   |

> **DoD:** ✅ 19 REQ-IDs (meta ≥10), todos com `source_legacy` ou `[GREENFIELD]`, todos com `acceptance` testável. 4 marcadores `[NEEDS CLARIFICATION]` para `/speckit.clarify` antes do Estágio 3.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="bounded-contexts.md"><strong>bounded-contexts.md</strong></a><br/>
<sub>Os 4 contextos.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="c4-diagrams.md"><strong>c4-diagrams.md</strong></a><br/>
<sub>Diagramas C4 L1/L2/L3.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
