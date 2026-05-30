<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Catálogo de Schema — DDMs Adabas SIFAP

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![TIPO Schema Analysis](https://img.shields.io/badge/TIPO-Schema%20Analysis-1A1A1A?style=for-the-badge) ![LEIA Durante S1](https://img.shields.io/badge/LEIA-Durante%20S1-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **ddm-schema-catalog**

> **Para quem é isto?** Para o time durante o Estágio 1 (Arqueologia), lendo os 4 DDMs Adabas e extraindo regras de schema.
>
> **O que você terá ao final desta leitura:**
>
> 1. Estrutura dos 4 DDMs com campos, descritores e grupos
> 2. Identificação de Periodic Groups (PE), Multi-Value (MU) e seus limites
> 3. Relacionamentos cross-DDM, divergências e campos órfãos
> 4. Implicações JPA/PostgreSQL para o Estágio 3
>
> 📚 **Evidência canônica:** [`01-arqueologia/legado-sifap/adabas-ddms/*.ddm`](legado-sifap/adabas-ddms/)

---

## Resumo Executivo

| Métrica | Valor |
|---|---:|
| **DDMs catalogados** | 4 |
| **Total de campos** | ~178 |
| **Periodic Groups (PE)** | 5 |
| **Multi-Value Fields (MU)** | grupos em PROGRAMA-SOCIAL e AUDITORIA |
| **Descritores únicos** | 15+ |
| **Super-descriptors (S1–S3)** | 11 |
| **Campos órfãos (DDM mas nunca usados nos 15 .NSN)** | 6+ |
| **Divergências críticas DDM × código** | 3 |
| **Packed decimals** | 25+ campos (N9.2, N7.2, N5.4, N3.4) |

---

## 1. DDM BENEFICIARIO (FNR 150)

**Propósito:** cadastro de beneficiários — base principal do SIFAP. Estimativa: ~4,2 milhões de registros. Mudanças de ordem de campos exigem aprovação (Portaria 847/2003).

### Campos principais

| Short | Long-name | Tipo | Tam | Oc | Descriptor | Domínio / Comentário |
|---|---|---|--:|--:|---|---|
| AA | NUM-INSCRICAO | N | 11 | — | — | Matrícula alternativa |
| **AB** | **NUM-CPF** | A | 11 | — | **DE, S1** | CPF sem formatação (chave principal) |
| AC | NOME-COMPLETO | A | 60 | — | — | Nome civil |
| AD | NOME-MAE | A | 60 | — | — | Obrigatório |
| AE | NOME-PAI | A | 60 | — | — | Opcional |
| AF | DT-NASCIMENTO | N | 8 | — | — | AAAAMMDD |
| AG | SEXO | A | 1 | — | — | M / F / I |
| AH | EST-CIVIL | A | 1 | — | — | S/C/D/V/U |
| BA | GRP-ENDERECO | — | — | — | — | Grupo estrutural |
| BB-BH | LOGRADOURO..CEP | A/N | — | — | — | Endereço completo |
| **BG** | **UF** | A | 2 | — | **DE, S2** | UF |
| BI | COD-IBGE | N | 7 | — | — | ⚠️ órfão |
| BJ | COD-REGIAO | A | 2 | — | — | 01–05 ou 99 |
| **CA** | **COD-PROGRAMA** | A | 4 | — | **DE, S3** | FK lógico → PROGRAMA-SOCIAL.AA |
| **CB** | **DT-CADASTRO** | N | 8 | — | **DE** | AAAAMMDD |
| CC | DT-INICIO-BENEF | N | 8 | — | — | AAAAMMDD |
| CD | DT-FIM-BENEF | N | 8 | — | — | 0 = sem prazo |
| **CE** | **SIT-BENEFICIARIO** | A | 1 | — | **DE, S2, S3** | A/S/C/I/D (divergente com RN-002) |
| CF | MOT-SITUACAO | A | 3 | — | — | Código motivo |
| CH | VLR-RENDA-FAMILIAR | N | 9.2 | — | — | Packed decimal |
| CI | QTD-MEMBROS-FAMILIA | N | 2 | — | — | — |
| CJ | IND-RENDA-PERCAP | N | 7.2 | — | — | ⚠️ órfão (calculável) |
| **DA** | **GRP-DEPENDENTE** | PE | — | **10** | — | **Periodic Group — máx 10** |
| DB | CPF-DEPENDENTE | A | 11 | — | — | aceita `00000000000` (sentinela) |
| DC | NOME-DEPENDENTE | A | 60 | — | — | — |
| DD | DT-NASC-DEPEND | N | 8 | — | — | AAAAMMDD |
| DE | PARENTESCO | A | 2 | — | — | FI/CJ/NT/TU (divergente) |
| DF | SIT-DEPENDENTE | A | 1 | — | — | A/I/D |
| DG | IND-DEFICIENCIA | A | 1 | — | — | ⚠️ órfão |
| EA-EC | Tel/Email | A | — | — | — | Adicionados em 2015 |
| FA-FD | Biometria | A/N | — | — | — | FD = HASH-DIGITAL órfão |
| **GA** | **DT-INCLUSAO** | N | 8 | — | **DE** | AAAAMMDD |
| GB-GG | Audit fields | A/N | — | — | — | GG (NUM-VERSAO) órfão |

### Regras de Schema (DR-BENE-*)

| ID | Regra |
|---|---|
| DR-BENE-001 | Chave primária = AB (NUM-CPF); não admite nulo |
| DR-BENE-002 | Valor-sentinela: `00000000000` aceito em DB (CPF de dependente) |
| DR-BENE-003 | Periodic group DA com máx 10 ocorrências — **divergente com CADDEPEND (limite 5) e RN-004 (limite 3)** |
| DR-BENE-004 | Super-descriptor S1 = AB |
| DR-BENE-005 | Super-descriptor S2 = BG + CE (UF + Situação) |
| DR-BENE-006 | Super-descriptor S3 = CA + CE (Programa + Situação) |
| DR-BENE-007 | Domínio CE = {A, S, C, I, D} — divergente com RN-002 ({A, E}) |
| DR-BENE-008 | Domínio DE (PARENTESCO) = {FI, CJ, NT, TU} segundo DDM; código usa também CO/IR/OU |
| DR-BENE-009 | Packed decimals: CH (N9.2) → `NUMERIC(9,2)` em PostgreSQL |
| DR-BENE-010 | Campos órfãos: BI, CJ, DG, FD, GG (nunca lidos/escritos pelos 15 programas) |

### Implicações JPA/PostgreSQL

- **PE → tabela separada** `beneficiary_dependent(beneficiary_cpf, ordinal, ...)` com constraint `MAX 10`.
- **Packed decimal** → `BigDecimal` + `NUMERIC(p,s)`; nunca `DOUBLE`.
- **Sentinela `00000000000`** → permitir no schema, validar/encapsular em domain service.
- **Status `S/C/I/D`** → enum com máquina de estados explícita.

---

## 2. DDM PAGAMENTO (FNR 152)

**Propósito:** histórico de pagamentos. Tabela transacional crítica — ~180 milhões de registros, sem política de purge (retenção legal TCU).

### Campos principais

| Short | Long-name | Tipo | Tam | Oc | Descriptor | Domínio / Comentário |
|---|---|---|--:|--:|---|---|
| **AA** | **NUM-PAGAMENTO** | N | 15 | — | **DE** | Sequencial único |
| **AB** | **NUM-CPF** | A | 11 | — | **DE, S1** | FK lógico → BENEFICIARIO.AB |
| AC | NUM-INSCRICAO | N | 11 | — | — | — |
| **AD** | **COD-PROGRAMA** | A | 4 | — | **DE, S2** | FK lógico → PROGRAMA-SOCIAL |
| **AE** | **ANO-MES-REF** | N | 6 | — | **DE, S1, S2** | AAAAMM — competência |
| AF | NUM-CICLO | N | 6 | — | **S3** | Ciclo de processamento |
| BA | VLR-BRUTO | N | 9.2 | — | — | Packed |
| BB | VLR-LIQUIDO | N | 9.2 | — | — | Bruto − descontos |
| BC | VLR-DESCONTO-TOTAL | N | 7.2 | — | — | Soma descontos |
| **CA** | **GRP-DESCONTO** | PE | — | **8** | — | **Periodic Group — máx 8 tipos** |
| CB | TIPO-DESCONTO | A | 3 | — | — | IR/JD/CS/PA/EM/TX/OU/EX |
| CC | VLR-DESCONTO | N | 7.2 | — | — | — |
| CD | PCT-DESCONTO | N | 3.2 | — | — | — |
| CE | NUM-PROCESSO | A | 20 | — | — | Processo judicial (se JD) |
| CF/CG | DT-INICIO/FIM-DSCT | N | 8 | — | — | AAAAMMDD |
| **DA** | **SIT-PAGAMENTO** | A | 1 | — | — | P/G/E/C/D/X/R (máquina de estados) |
| **DB** | **DT-GERACAO** | N | 8 | — | **DE, S2** | AAAAMMDD |
| DC-DG | Geração/Confirmação/Cancelamento | N/A | — | — | — | — |
| EA-EE | Dados bancários | A | — | — | — | COD-BANCO, AGENCIA, CONTA, TIPO, OPERACAO |
| FA-FE | Integração SIAFI | A | — | — | — | Adicionado 2002 |
| GA-GE | Conciliação | A/N | — | — | — | Match com retorno CNAB 240 |
| HA/HB | HASH-ARQ-REMESSA/RETORNO | A | 64 | — | — | SHA-256 (adição 2015, ⚠️ campos preparados mas pouco usados) |
| IA-IF | Audit fields | A/N | — | — | — | IF (USR-ULT-ALTERACAO) órfão |

### Regras de Schema (DR-PGTO-*)

| ID | Regra |
|---|---|
| DR-PGTO-001 | Chave primária = AA (NUM-PAGAMENTO) |
| DR-PGTO-002 | FK lógico: AB → BENEFICIARIO.AB |
| DR-PGTO-003 | Periodic group CA com máx 8 tipos de desconto |
| DR-PGTO-004 | Super-descriptor S1 = AB + AE (CPF + Competência) |
| DR-PGTO-005 | Super-descriptor S2 = AD + AE + DA (Programa + Competência + Situação) |
| DR-PGTO-006 | Super-descriptor S3 = AF + DA (Ciclo + Situação) |
| DR-PGTO-007 | Domínio DA = {P, G, E, C, D, X, R} — máquina de estados parcialmente documentada |
| DR-PGTO-008 | Campos HA/HB (HASH-*) são append-only após gravação |
| DR-PGTO-009 | Packed decimals: BA/BB (N9.2), BC/CC (N7.2), CD (N3.2) → `NUMERIC` |
| DR-PGTO-010 | Sem política de purge — retenção legal indefinida (TCU) |

### Implicações JPA/PostgreSQL

- **PE descontos** → `payment_discount` com FK e `MAX 8`.
- **Particionamento** por `ano_mes_ref` (competência) recomendado dado o volume.
- **Sem soft-delete via flag**; usar evento de auditoria em `auditoria`.
- **Índices compostos** alinhados aos super-descriptors S1/S2/S3.

---

## 3. DDM PROGRAMA-SOCIAL (FNR 151)

**Propósito:** cadastro paramétrico de programas sociais. ~45 programas ativos. Fator K inserido em ago/2008 sem documentação formal (“atende solicitação SENARC”).

### Campos principais

| Short | Long-name | Tipo | Tam | Oc | Descriptor | Domínio / Comentário |
|---|---|---|--:|--:|---|---|
| **AA** | **COD-PROGRAMA** | A | 4 | — | **DE, S1** | Chave primária |
| AB | NOME-PROGRAMA | A | 60 | — | — | Nome oficial |
| AC | SIGLA-PROGRAMA | A | 10 | — | — | PBF/BPC/PETI |
| **AD** | **TIPO-PROGRAMA** | A | 1 | — | **S2** | A/T/P (assistência/trabalho/previdência) |
| AE | ORGAO-RESPONSAVEL | A | 10 | — | — | MDS/MDAS |
| AF | LEI-CRIACAO | A | 20 | — | — | Lei/decreto |
| AG/AH | DT-CRIACAO/ENCERRAMENTO | N | 8 | — | — | AAAAMMDD |
| **AI** | **SIT-PROGRAMA** | A | 1 | — | **S2** | A/I/E |
| BA-BF | Valores base/teto/piso/reajuste | N | 7.2/9.2/3.2 | — | — | Parâmetros financeiros |
| **BG** | **FATOR-K** | N | 5.4 | — | — | ⚠️ **mistério crítico** — fórmula `1.00 + (FATOR-REAJ × 0.347215)` |
| CA-CI | Regras elegibilidade | N/A | — | — | — | Renda, idade, flags S/N |
| **DA** | **GRP-FAIXA-CALCULO** | PE | — | **5** | — | **Periodic Group — máx 5 faixas** |
| DB-DF | Renda inicio/fim, fator, adicional | N/A | — | — | — | — |
| **EA** | **TIPO-DSCT-APLIC** | MU | 3 | **8** | — | **Multi-Value — máx 8 tipos** |
| **FA** | **GRP-PARAM-REGIONAL** | PE | — | **6** | — | **Periodic Group — 5 regiões + especial 99** |
| FB-FE | Região, fator, complemento, ativo | A/N | — | — | — | — |
| GA-GD | Audit fields | A/N | — | — | — | Inclusão/alteração |

### Regras de Schema (DR-PROG-*)

| ID | Regra |
|---|---|
| DR-PROG-001 | Chave primária = AA (COD-PROGRAMA) |
| DR-PROG-002 | Super-descriptor S1 = AA |
| DR-PROG-003 | Super-descriptor S2 = AD + AI |
| DR-PROG-004 | Periodic group DA com máx 5 faixas de renda |
| DR-PROG-005 | Multi-value EA com máx 8 tipos `{IR,JD,CS,PA,EM,TX,OU,EX}` |
| DR-PROG-006 | Periodic group FA com 6 ocorrências (regiões 1-5 + 99 especial) |
| DR-PROG-007 | **BG (FATOR-K)** sem documentação formal — fórmula em CADPROG.NSN:L81-L83 |
| DR-PROG-008 | Packed decimals: BA/BB/BD (N7.2), BC (N9.2), DD/FC (N3.4), BE (N3.2) |
| DR-PROG-009 | Flags CD-CI controlam VALELEG.NSN |
| DR-PROG-010 | Sem campos órfãos — todos lidos por cálculo/validação |

### Implicações JPA/PostgreSQL

- **Faixa de cálculo (PE)** → `program_calculation_range(program_id, ordinal, renda_inicio, renda_fim, fator, adicional)` com `MAX 5`.
- **Tipo de desconto aplicável (MU)** → `program_discount_type(program_id, discount_type)` com `MAX 8`.
- **Parâmetro regional (PE)** → `program_regional_param(program_id, cod_regiao, fator, complemento, ativo)` com 6 linhas fixas.
- **FATOR-K** → coluna `NUMERIC(5,4)` + ADR explícita apontando para investigação.

---

## 4. DDM AUDITORIA (FNR 153)

**Propósito:** trilha de auditoria. Imutável (INSERT ONLY), retenção indefinida (IN-TCU 63/2010). ~25M registros estimados. Ações `CO` (consulta) não gravadas desde 2010.

### Campos principais

| Short | Long-name | Tipo | Tam | Oc | Descriptor | Domínio / Comentário |
|---|---|---|--:|--:|---|---|
| **AA** | **NUM-AUDITORIA** | N | 15 | — | **DE, S1** | Sequencial único |
| **AB** | **DT-EVENTO** | N | 8 | — | **DE, S1, S2** | AAAAMMDD |
| AC | HR-EVENTO | N | 6 | — | — | HHMMSS |
| AD | TS-EVENTO | N | 14 | — | — | AAAAMMDDHHMMSS |
| **BA** | **COD-ACAO** | A | 2 | — | **DE, S1** | IN/AL/EX/CO/LG/LO/BT/ER/AU/RE |
| BB | COD-MODULO | A | 8 | — | — | Nome programa Natural |
| BC | DES-ACAO | A | 80 | — | — | Descrição livre |
| **CA** | **TIPO-ENTIDADE** | A | 4 | — | **S2** | BENF/PGTO/PROG/ADMN/SIST |
| **CB** | **ID-ENTIDADE** | A | 15 | — | **DE, S2** | Chave da entidade |
| **CC** | **NUM-CPF-AFETADO** | A | 11 | — | **DE, S2** | CPF (se aplicável) |
| DA | GRP-ANTES | — | — | — | — | Estado anterior |
| DB | CAMPO-ALTERADO-ANT | MU | 30 | **20** | — | Multi-Value máx 20 |
| DC | VALOR-ANTERIOR | MU | 80 | **20** | — | Multi-Value máx 20 |
| DD | GRP-DEPOIS | — | — | — | — | Estado posterior |
| DE/DF | CAMPO/VALOR-POSTERIOR | MU | 30/80 | **20** | — | Multi-Value máx 20 |
| EA | USR-EVENTO | A | 8 | — | **DE, S3** | Login Natural |
| EB-EF | Usuário/sessão | A/N | — | — | — | EE (IP-ORIGEM) adicionado 2012 |
| FA-FE | Contexto batch | A/N | — | — | — | Ciclo, job, situação, mensagem erro |
| GA/GB | ID-CORRELACAO + seq | A/N | — | — | — | UUID para operações compostas |

### Regras de Schema (DR-AUD-*)

| ID | Regra |
|---|---|
| DR-AUD-001 | Chave primária = AA (NUM-AUDITORIA) |
| DR-AUD-002 | Registro imutável — apenas INSERT |
| DR-AUD-003 | Super-descriptor S1 = AB + BA (data + ação) |
| DR-AUD-004 | Super-descriptor S2 = CA + CB + AB (entidade + data) |
| DR-AUD-005 | Super-descriptor S3 = EA + AB (usuário + data) |
| DR-AUD-006 | Grupos DA/DD + MU (DB/DC/DE/DF) com máx 20 campos alterados |
| DR-AUD-007 | Ações `CO` não gravadas desde 2010 (decisão CGTI 213/2010) |
| DR-AUD-008 | RELAUDIT filtra `ACAO='EX'` do relatório (compliance flag) |
| DR-AUD-009 | UUID de correlação (GA) rastreia operações compostas |
| DR-AUD-010 | Retenção indefinida desde 1998 (sem purge) |

### Implicações JPA/PostgreSQL

- **Imutabilidade** garantida em `@PreUpdate`/`@PreRemove` (lançar exceção).
- **MU → tabela** `audit_change(audit_id, is_before, ordinal, field_name, field_value)` com `MAX 20` por lado.
- **Particionamento por ano** para 25M+ registros.
- **Índices** compostos alinhados aos super-descriptors.

---

## 5. Análise Cross-DDM

### 5.1 Relacionamentos implícitos

| FK lógica | Origem | Campo | Destino | Campo | Programas que fazem o JOIN |
|---|---|---|---|---|---|
| CPF beneficiário | PAGAMENTO | AB | BENEFICIARIO | AB | BATCHREL, CONSBENF, RELPGT |
| Código programa | BENEFICIARIO | CA | PROGRAMA-SOCIAL | AA | CALCBENF, VALELEG |
| Código programa | PAGAMENTO | AD | PROGRAMA-SOCIAL | AA | BATCHPGT |
| Auditoria de beneficiário | BENEFICIARIO | GA/GD | AUDITORIA | AB/CC | rastreamento implícito |

### 5.2 Divergências DDM × código (críticas para o Estágio 2)

| # | Tema | Conflito | Onde |
|---|---|---|---|
| DIV-001 | **Limite de dependentes** | DDM = 10, CADDEPEND = 5, RN-004 = 3 | BENEFICIARIO PE DA vs CADDEPEND.NSN |
| DIV-002 | **Domínio PARENTESCO** | DDM = {FI, CJ, NT, TU}; código aceita CO/IR/OU | BENEFICIARIO.DE vs CADDEPEND |
| DIV-003 | **FATOR-K** | Campo presente sem documentação; fórmula em código | PROGRAMA-SOCIAL.BG vs CADPROG.NSN:L81-L83 |

### 5.3 Campos órfãos

| Campo | DDM | Razão | Ação Estágio 3 |
|---|---|---|---|
| BI (COD-IBGE) | BENEFICIARIO | nunca lido/escrito | candidato a remoção ou migração para tabela de referência |
| CJ (IND-RENDA-PERCAP) | BENEFICIARIO | redundante com CH | recalcular dinamicamente ou remover |
| DG (IND-DEFICIENCIA) | BENEFICIARIO (PE) | nunca lido/escrito | manter para futuro de acessibilidade |
| FD (HASH-DIGITAL) | BENEFICIARIO | não implementado | remover ou tabela separada |
| GG (NUM-VERSAO) | BENEFICIARIO | obsoleto | usar `@Version` JPA |
| IF (USR-ULT-ALTERACAO) | PAGAMENTO | nunca preenchido | remover ou usar audit trail |
| HA/HB (HASH-*) | PAGAMENTO | preparado, pouco usado | implementar de fato no Estágio 3 |

---

## 6. Top 3 Implicações para JPA/PostgreSQL

1. **Packed decimal strategy** — todo `N?.?` vira `NUMERIC(p,s)` + `BigDecimal`. Nunca `DOUBLE`.
2. **PE/MU → normalização** — cada grupo periódico/multi-value vira tabela com FK e constraint de cardinalidade.
3. **Auditoria imutável + retenção indefinida** — bloquear UPDATE/DELETE no nível JPA e particionar por ano.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="mysteries-found.md"><strong>Mistérios Encontrados</strong></a><br/>
<sub>Documentação incompleta e regras escondidas do legado.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="discovery-report.md"><strong>Relatório de Descoberta</strong></a><br/>
<sub>Síntese geral da arqueologia do Estágio 1.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="README.md">Voltar ao Estágio 1</a></sub>
