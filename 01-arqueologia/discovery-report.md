<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Relatório de Descoberta — Estágio 1: Arqueologia Digital

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S1](https://img.shields.io/badge/PREENCHA-Durante%20S1-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **discovery-report**

> **Para quem é isto?** Este é um **artefato preenchido pelo time** durante o Estágio 1 (Arqueologia).
>
> **O que você terá ao final do estágio:**
>
> 1. Este documento totalmente preenchido com os dados reais do legado SIFAP
> 2. Rastreabilidade para `01-arqueologia/legado-sifap/` (programas `.NSN` e DDMs)
> 3. Base de evidência usada nas EARS do Estágio 2 (`source_legacy:`)
>
> 📘 **Guia passo a passo:** [`GUIDE.md`](GUIDE.md).


> Este documento consolida todas as descobertas do Estágio 1.
> Preencha cada seção com as conclusões do time. **Este é o input principal do Estágio 2** — sem ele, a especificação vira chute.

**Time**: SERPRO Curitiba — Workshop Preto 00
**Data**: 19/05/2026
**Edição**: Demo
**Participantes**: 5 pares (Visão · Arquitetura · Implementação · Qualidade · Operações) cobrindo 10 personas, conduzidos pelo `@archaeologist`.

---

## 1. Sumário Executivo

O SIFAP é um sistema de pagamento de benefícios sociais escrito em Natural/Adabas, em produção há **29 anos** (1996–2025), rodando em mainframe mensalmente para ~3,2M de beneficiários e movimentando ~R$ 4,2 bilhões/ano. O time analisou **100% do código disponível** (15 programas `.NSN`, 4 DDMs Adabas, 3 documentos históricos: REGRAS-NEGOCIO-2012.md, MANUAL-TECNICO-SIFAP-2008.md, ARQUITETURA-LEGADA-1996.md) e produziu **187 regras de negócio rastreadas a fonte**, **44 mistérios catalogados (17 oficiais — score 32/32)**, **glossário de 64 termos** e **13 divergências críticas código vs documentação**. A criticidade é máxima: falhas afetam cidadãos vulneráveis; existe risco fiscal não documentado (Fator-K, truncamento, RELAUDIT oculta exclusões). O código está **estável e operacional**, mas a janela técnica fecha — apenas 2 desenvolvedores Natural ativos no SERPRO, ambos perto da aposentadoria.

---

## 2. Visão Geral do Sistema

### 2.1 Propósito do SIFAP

O SIFAP (Sistema de Fiscalização e Administração de Pagamentos) gerencia o ciclo completo de pagamento de benefícios sociais federais:

1. **Cadastro** de beneficiários, dependentes e programas sociais (transações online SF01–SF06).
2. **Cálculo** mensal de valor a pagar, aplicando fator regional, fator etário, fator de família, faixa de renda e o misterioso "Fator-K".
3. **Aplicação de descontos** (IR, judicial, sindical, pensão alimentícia, taxa administrativa) com regras de prioridade e cap de 30% (exceto judicial).
4. **Geração de remessa CNAB 240** para o Banco do Brasil (banco pagador) e bancos parceiros (Caixa, Itaú, Bradesco).
5. **Conciliação** dos retornos bancários por match triplo (documento + CPF + competência).
6. **Auditoria** completa (~25M registros desde 1998) e relatórios analíticos para CGU/TCU.
7. **Correção monetária** via tabela IPCA quando há atraso > 30 dias.

### 2.2 Arquitetura Legada

- **4 DDMs Adabas** (file numbers 150–153): BENEFICIARIO (~52 campos, ~3,2M registros), PAGAMENTO (~50 campos, ~180M registros), PROGRAMA-SOCIAL (~42 campos, 47 programas ativos), AUDITORIA (~34 campos, ~25M registros, append-only).
- **15 programas Natural** agrupados em 6 famílias: cadastro online (`CAD*`), batch noturno/mensal (`BATCH*`), cálculo (`CALC*`), validação reutilizável (`VAL*`), consulta (`CONS*`), relatório (`REL*`).
- **Fluxos críticos:**
  - **Mensal — BATCHPGT** (1º DU às 02:00; ~2h45min): lê beneficiários ativos por CPF, chama CALCBENF → CALCDSCT → CALCCORR, grava PAGAMENTO com status `'G'`, gera arquivo CNAB 240.
  - **Mensal — BATCHCON** (após retorno do banco): faz match triplo, atualiza status para `'P'` (Pago), `'E'` (Erro), `'R'` (Rejeitado) ou `'D'` (Devolvido); tolerância de 0,01.
  - **Diário — RELAUDIT**: trilha de auditoria — **mas filtra silenciosamente registros com `ACAO='EX'`** (MYS-010).
- **Integração externa**: Banco do Brasil (FEBRABAN 001) como pagador principal; campos SIAFI (FA-FE) adicionados em 2002; bloco Banco Real (356) comentado em `BATCHCON.NSN#L203-L212` após aquisição pelo Santander (2007) — EGG-003.

### 2.3 Usuários e Perfis

- **Operadores SF01–SF06** (~120 usuários em 27 unidades): cadastro online de beneficiários, dependentes, programas.
- **Analistas de pagamento** (~30 usuários): execução manual de BATCHPGT em casos excepcionais; reprocessamento.
- **Auditores (CGU/TCU/SERPRO)**: leitura de RELAUDIT e RELPGT — **com cegueira para exclusões** (MYS-010).
- **DBA mainframe** (~3 pessoas): manutenção de FDT e jobs JCL.
- **Sistemas downstream não mapeados**: dependem da ordem alfabética por CPF gerada por BATCHPGT (MYS-009 — comentário literal "SISTEMAS DOWNSTREAM DEPENDEM DESTA ORDENACAO").

---

## 3. Principais Descobertas

### 3.1 Regras de Negócio Críticas

> Top 10 entre as 187 regras catalogadas — ver [`business-rules-catalog.md`](business-rules-catalog.md) completo.

1. **BR-CBENF-001/Fator-K** ([`CADPROG.NSN#L81-L83`](legado-sifap/natural-programs/CADPROG.NSN)): toda fórmula de cálculo aplica constante `0.347215` sem origem documentada — **MYS-003, risco fiscal alto**.
2. **BR-CBENF-009/Fórmula multiplicativa** ([`CALCBENF.NSN#L181-L191`](legado-sifap/natural-programs/CALCBENF.NSN)): valor = base × fator-reg × fator-idade × fator-fam × fator-rnd — manual diz aditivo (`+`). **D-01, divergência crítica**.
3. **BR-CDEP-004/Limite dependentes** ([`CADDEPEND.NSN#L66-L69`](legado-sifap/natural-programs/CADDEPEND.NSN)): código aceita 5, DDM aceita 10, doc RN-004 diz 3. **MYS-002 / INC-001 — decisão do PO obrigatória**.
4. **BR-CDSCT-004/Cap judicial isento** ([`CALCDSCT.NSN#L113-L118`](legado-sifap/natural-programs/CALCDSCT.NSN)): desconto judicial ignora o cap de 30% do total bruto — sem respaldo legal documentado.
5. **BR-BPGT-018/19/Dezembro especial** ([`BATCHPGT.NSN#L290-L302`](legado-sifap/natural-programs/BATCHPGT.NSN)): em dezembro emite 13º; programas TIPO='A' ganham +15% abono natalino. **MYS-004 — fórmula sazonal não documentada**.
6. **BR-CCORR-001/IPCA 36 meses** ([`CALCCORR.NSN#L43-L82`](legado-sifap/natural-programs/CALCCORR.NSN)): tabela `#IPCA-ANO(10,12)` hardcoded, última carga 2013 — **deflação ignorada** ([`L98-L102`](legado-sifap/natural-programs/CALCCORR.NSN)). INC-002.
7. **BR-RA-MISTERIO-01/RELAUDIT oculta EX** ([`RELAUDIT.NSN`](legado-sifap/natural-programs/RELAUDIT.NSN)): viola RN-011 (auditoria deve listar todas as ações) — **bandeira vermelha de compliance**. MYS-010.
8. **BR-VELG-004/Região 99 backdoor** ([`VALELEG.NSN#L102-L106`](legado-sifap/natural-programs/VALELEG.NSN)): `COD-REGIAO=99` (INTERNACIONAL/DIPLOMATICO) pula todas as validações. MYS-008.
9. **BR-BPGT-03/Truncamento** ([`BATCHPGT.NSN`](legado-sifap/natural-programs/BATCHPGT.NSN)): trunca centavos em vez de arredondar (manual §4 diz arredondar 5ª casa). MYS-005, INC-004 — milhões/ano em discrepância.
10. **BR-CBENF-014/15/Status 'G'** ([`CALCBENF.NSN#L283`](legado-sifap/natural-programs/CALCBENF.NSN), [`BATCHPGT.NSN#L332`](legado-sifap/natural-programs/BATCHPGT.NSN)): grava status inicial `'G'` (Gerado), **ausente do manual §3.5.1**. INC-002.

### 3.2 Dependências Complexas

> Ver [`dependency-map.md`](dependency-map.md) e [`dependency-map.mmd`](dependency-map.mmd) para grafo completo.

- **BATCHPGT é o hub**: chama CALCBENF, CALCDSCT, CALCCORR, VALBENEF, VALDOCS, VALELEG e grava em PAGAMENTO + AUDITORIA. Qualquer mudança aqui exige regressão completa.
- **Cadeia financeira crítica**: `BATCHPGT → CALCBENF → CALCDSCT → CALCCORR` — 4 fórmulas encadeadas; cada uma faz arredondamento diferente (truncar / arredondar 5ª / tolerar 0,01). INC-004.
- **VAL\* reutilizadas em múltiplos pontos**: VALBENEF e VALDOCS são chamadas por CADBENEF, CADDEPEND e BATCHPGT; **divergência interna de CPF** entre os 4 implementadores.
- **PROGRAMA-SOCIAL como tabela de configuração**: 47 programas ativos, mas só ~12 usam Fator-K diferente do default — risco de tratar como dado quando é regra.
- **AUDITORIA append-only**: ~25M registros; **nunca houve purge** desde 1998 (decisão CGTI 213/2010). Migração precisa de estratégia de archive.

### 3.3 Dívida Técnica Identificada

- [ ] **Fator-K hardcoded sem origem legal** — bloqueia migração formal (MYS-003).
- [ ] **3 estratégias de arredondamento** em programas que devem reconciliar (BATCHPGT trunca, CALCCORR arredonda, BATCHCON tolera 0,01) — INC-004.
- [ ] **Validação de CPF reimplementada 4 vezes** (CADBENEF, CADDEPEND, VALBENEF, VALDOCS) com diferenças sutis.
- [ ] **CPF `00000000000` institucionalizado** no DDM como feature (MYS-007) — backdoor de cadastro fantasma.
- [ ] **Tabelas críticas hardcoded** (25 regiões, 5 faixas de renda, fator etário) sem versionamento — última carga 2013.
- [ ] **180M registros em PAGAMENTO sem purge nem particionamento** — performance e custo de armazenamento.
- [ ] **Layout de relatório 132×66 mainframe** em RELPGT e BATCHREL — não traduz direto para web.
- [ ] **Ordem batch por CPF virou contrato implícito** com sistemas downstream não mapeados (MYS-009).
- [ ] **Códigos extintos preservados** (Banco Real 356, Plano Verão) como código morto — EGG-001, EGG-003.
- [ ] **Status sobrecarregados** ('C', 'D', 'E' significam coisas diferentes em PAGAMENTO vs BENEFICIARIO).
- [ ] **Biometria órfã** — campos `HASH-DIGITAL` adicionados em 2005 nunca foram preenchidos.
- [ ] **Apenas 2 devs Natural ativos no SERPRO**, ambos próximos da aposentadoria — risco humano máximo.

### 3.4 Gaps de Documentação

> Ver [`legacy-docs-catalog.md`](legacy-docs-catalog.md) seção "11 Lacunas (L-01..L-11)" e seção "13 Divergências Críticas (D-01..D-13)".

Os 3 documentos disponíveis (REGRAS-NEGOCIO-2012, MANUAL-TECNICO-SIFAP-2008, ARQUITETURA-LEGADA-1996) **NÃO cobrem**:

- Status `'G'` (Gerado) — apenas `'P'`, `'E'`, `'C'`, `'D'` documentados — **L-04 / INC-002**.
- Tabela IPCA 2010–2012 — documento marca `[A COMPLETAR]` (L-05).
- Fórmula multiplicativa real — documento mostra aditiva (D-01).
- Fator-K = 0.347215 — origem nunca documentada (L-06).
- Limite real de dependentes — três valores diferentes em três fontes (D-04).
- Domínio real de PARENTESCO — três conjuntos diferentes (D-09).
- Subprograma LOGAUDIT citado pelo RN-010 mas ausente do código CADBENEF SF02 (D-06).
- Critério exato do status `'S'` (Sênior) gravado para idosos > 75 anos (MYS-001, L-07).
- Razão de manter Banco Real 356 ativo no código — só consta nota interna 2007 (L-08).
- Ordem batch por CPF — contrato implícito sem documento (L-09).
- Política de cap judicial isento — sem referência legal (L-10).

---

## 4. Mistérios e Riscos

### 4.1 Mistérios Não Resolvidos

> Ver [`mysteries-found.md`](mysteries-found.md) — **17 oficiais / 32 pontos rubrica A1** (Excelente). Tabela abaixo destaca os de maior risco para a migração.

| ID      | Descrição                                                       | Risco para Migração                                            |
| ------- | --------------------------------------------------------------- | -------------------------------------------------------------- |
| MYS-001 | Status `'S'` silencioso para idosos > 75                         | Categoria fora do domínio publicado; risco em cálculo          |
| MYS-002 | Tripla divergência: DDM=10, Code=5, Doc=3 dependentes           | EARS precisa de decisão explícita do PO antes de codificar     |
| MYS-003 | Constante mágica Fator K = 0.347215 sem origem legal            | Toda fórmula depende; risco fiscal e jurídico alto             |
| MYS-004 | Dezembro: 13º + abono 15% TIPO='A'                              | Esconde 8-10% da folha anual se regredido                      |
| MYS-005 | Truncamento × arredondamento × tolerância                       | Reconciliação financeira sofre divergência sistemática         |
| MYS-006 | Cap agregado contradiz prioridade RN-023                        | Descontos válidos reduzidos em vez de removidos                |
| MYS-007 | CPF `00000000000` institucionalizado                            | Backdoor de fraude sem rastreabilidade                         |
| MYS-008 | Região 99 ⇒ elegibilidade automática                           | Classe inteira nunca passou pela validação documental          |
| MYS-009 | Ordem batch por CPF virou contrato implícito                    | Migrar sem preservar ordem CPF quebra integrações invisíveis   |
| MYS-010 | RELAUDIT oculta `ACAO='EX'`                                     | Viola RN-011; compliance vermelho                              |
| EGG-001 | Plano Verão (Cruzado→Cruzeiro, fatores 2.7500/1.4289)           | Código morto seguro, mas mostra padrão de preservação histórica |
| EGG-002 | Backdoor VALDOCS (prefixos especiais pulam DV)                  | Backdoor de validação documental — precisa decisão de remoção  |
| EGG-003 | Banco Real (356) — integração comentada pós-aquisição 2007      | Bloco preservado por nota histórica — sem risco operacional    |
| INC-001 | Limite documentado diverge de código+DDM (dependentes)          | Mesma raiz de MYS-002 — decisão de PO                           |
| INC-002 | Status `'G'` + tabela IPCA 2010–2012 fora do manual              | Manual desatualizado em ≥ 2 pontos críticos                    |
| INC-003 | Tabelas críticas (25 regiões, fator etário, faixas) sem doc     | Não dá para migrar só pelos documentos                         |
| INC-004 | 3 rounding diferentes: trunca / arredonda / tolera 0,01         | Reconciliação financeira — escolher 1 quebra outro             |

### 4.2 Riscos para o Estágio 2

1. **Sem decisão explícita do PO sobre os trios divergentes** (D-04 dependentes, D-09 parentesco, D-10 status pagamento), o Estágio 2 vai produzir EARS ambíguos. **Bloqueador hard**.
2. **Fator-K precisa de validação jurídica** (origem legal) antes de virar requisito. Se for ilegal, EARS muda de "aplica constante" para "calcula via fórmula auditável".
3. **MYS-010 (RELAUDIT oculta EX) é potencialmente um achado de compliance** que pode escalar para o TCU. EARS precisa decidir: replicar bug ou corrigir (com auditoria retroativa).
4. **180M registros em PAGAMENTO** exigem decisão de arquitetura ANTES da EARS (particionamento, archive, cold storage) — Par 2.
5. **Sistemas downstream não mapeados** (MYS-009) podem aparecer durante UAT como bug "novo" — escopo defensivo no EARS recomendado.
6. **2 devs Natural ativos** — janela de SME-availability fechando. Marcar entrevistas semanais nas próximas 4 semanas.

---

## 5. Recomendações

### 5.1 O que migrar primeiro

| Prioridade | Funcionalidade                                | Justificativa                                                                |
| ---------- | --------------------------------------------- | ---------------------------------------------------------------------------- |
| 1          | **Cadastro online de beneficiários (CADBENEF)** | Volume conhecido, regras maduras, fluxo síncrono — bom MVP de strangler-fig |
| 2          | **Cálculo mensal (BATCHPGT + CALCBENF + CALCDSCT + CALCCORR)** | Core do sistema; valor entregue maior; risco mais alto — fazer com testes de equivalência |
| 3          | **Auditoria (gravação)**                      | Pré-requisito de compliance para qualquer mudança em cadastro/cálculo        |
| 4          | **Geração CNAB 240 + Conciliação BATCHCON**   | Integração com banco — alto risco se quebrar, alto valor se modernizar      |
| 5          | **Relatórios analíticos (RELAUDIT/RELPGT)**   | Pode esperar; mainframe 132×66 não traduz direto                            |

### 5.2 O que descartar

- **Bloco Plano Verão** (EGG-001): código morto desde 1991. Sem risco em descartar.
- **Bloco Banco Real** (EGG-003): integração extinta desde 2007. Manter como nota histórica em ADR, descartar do código.
- **Campos biométricos órfãos** (`HASH-DIGITAL`): nunca foram preenchidos. Descartar do modelo.
- **Layout mainframe 132×66** em relatórios: substituir por export PDF/CSV web-friendly.
- **Backdoor VALDOCS** (EGG-002): bug de produção. Decisão do PO se remove (recomendado) ou preserva.

### 5.3 O que evoluir

- **Validação de CPF**: consolidar 4 implementações em um único validator service.
- **Estratégia de arredondamento**: padronizar em "arredondar para o centavo mais próximo (HALF_UP)" em toda a cadeia financeira (corrige INC-004 mas exige regressão).
- **Status PAGAMENTO**: documentar formalmente `'G'` (Gerado) e remover sobrecargas com BENEFICIARIO; usar enum dedicado por entidade.
- **Auditoria com archive automático**: particionar AUDITORIA por ano + cold storage > 5 anos.
- **RELAUDIT incluir `ACAO='EX'`** (corrige MYS-010) — com flag de feature para auditoria retroativa.
- **Tabelas hardcoded → tabelas de configuração versionadas** (regiões, fator etário, faixas renda, IPCA).
- **Fator-K → fórmula auditável** após validação jurídica.

---

## 6. Métricas do Estágio

| Métrica                       | Valor             |
| ----------------------------- | ----------------- |
| Programas analisados          | **15 / 15** ✅     |
| DDMs mapeados                 | **4 / 4** ✅       |
| Documentos legados analisados | **3 / 3** ✅       |
| Regras de negócio encontradas | **187**           |
| Regras escondidas encontradas | **10 / 10** ✅     |
| Easter eggs encontrados       | **3 / 3** ✅       |
| Inconsistências doc × código  | **4 / 4** ✅       |
| Termos no glossário           | **64**            |
| Mistérios catalogados         | **17 oficiais + 27 flags = 44** |
| Score rubrica A1              | **32 / 32** (Excelente) |
| Divergências cross-fonte (D-NN) | **13**          |
| Lacunas de documentação (L-NN) | **11**           |
| Tempo total gasto             | **~4 horas** (Estágio 1 inteiro) |

---

## 7. Notas para o Próximo Estágio

> Para o time do Estágio 2 (Especificação Moderna) — `@architect`:

**Use estes 7 artefatos como entrada do Spec-Kit:**

1. [`business-rules-catalog.md`](business-rules-catalog.md) — 187 regras com `Programa Fonte` preenchido (vira `source_legacy:` no EARS).
2. [`mysteries-found.md`](mysteries-found.md) — 17 mistérios oficiais (todo `[NEEDS CLARIFICATION]` deve referenciar um MYS/EGG/INC).
3. [`glossary.md`](glossary.md) — 64 termos (use no `/speckit.constitution` para fixar vocabulário).
4. [`dependency-map.md`](dependency-map.md) + [`dependency-map.mmd`](dependency-map.mmd) — grafo de chamadas (entrada para bounded contexts).
5. [`ddm-schema-catalog.md`](ddm-schema-catalog.md) — 4 DDMs com 178 campos + 4 FKs implícitas + 6 órfãos (entrada para JPA).
6. [`legacy-docs-catalog.md`](legacy-docs-catalog.md) — 13 D-NN + 11 L-NN (entrada para `[NEEDS CLARIFICATION]`).
7. [`mysteries-raw-44-analysis.md`](mysteries-raw-44-analysis.md) — análise dos 27 flags extras (vira `[NEEDS CLARIFICATION]` engenharia).

**Hard gates antes do `/speckit.specify`:**

- [ ] PO precisa decidir D-04 (dependentes 3 vs 5 vs 10), D-09 (parentesco), D-10 (status pagamento).
- [ ] Time jurídico precisa validar Fator-K (MYS-003) — se inválido, EARS muda fundamentalmente.
- [ ] Decisão sobre MYS-010 (RELAUDIT) — replicar bug ou corrigir? Impacta compliance.
- [ ] Decisão sobre INC-004 (arredondamento) — qual estratégia única adotar?

**Padrão recomendado no EARS:**

```yaml
- id: REQ-CBENF-001
  description: O sistema deve calcular o valor base aplicando fator-regional, fator-idade, fator-família e fator-renda
  source_legacy: legado-sifap/natural-programs/CALCBENF.NSN#L181-L191
  related_mystery: MYS-003 (Fator-K)
  needs_clarification:
    - Fator-K = 0.347215 tem origem legal? Validar com jurídico.
    - Fórmula é multiplicativa (código) ou aditiva (doc D-01)?
```

**Bounded contexts candidatos** (proposta inicial do `@archaeologist`, refinar no `@architect`):

1. **Cadastro** (BENEFICIARIO, DEPENDENTE, PROGRAMA-SOCIAL) — CADBENEF, CADDEPEND, CADPROG, VAL\*.
2. **Cálculo** (motor financeiro) — CALCBENF, CALCCORR, CALCDSCT, BATCHPGT (parte cálculo).
3. **Pagamento** (PAGAMENTO + integração bancária) — BATCHPGT (parte CNAB), BATCHCON.
4. **Auditoria** (AUDITORIA + relatórios) — RELAUDIT, RELPGT, BATCHREL.
5. **Consulta** (read-side) — CONSBENF (com bug conhecido em máscara CPF).

**Estratégia recomendada**: **Strangler-Fig** começando por Cadastro (menor risco, valor visível), com testes de equivalência via shadow-write contra o legado durante 3-6 meses por contexto.

---

## Definição de Pronto deste relatório

- [x] Todas as seções acima preenchidas (sem placeholders).
- [x] Pelo menos 5 regras críticas listadas em §3.1 (entregamos 10), cada uma referenciando uma `BR-XXX` do catálogo.
- [x] Decisões de migrar/descartar/evoluir em §5 cobrem as 8+ funcionalidades principais.
- [x] Métricas de §6 conferem com os outros artefatos (glossary.md, business-rules-catalog.md, mysteries-found.md, ddm-schema-catalog.md, legacy-docs-catalog.md).

— Paula


---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="mysteries-found.md"><strong>mysteries-found.md</strong></a><br/>
<sub>Lista de mistérios.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="../02-spec-moderna/GUIDE.md"><strong>Estágio 2 — Spec</strong></a><br/>
<sub>Próximo estágio: spec moderna.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>

