<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Catálogo de Regras Documentais — SIFAP Legado (1997/2008/2012)

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![FONTE 3 docs históricos](https://img.shields.io/badge/FONTE-3%20docs%20históricos-1A1A1A?style=for-the-badge) ![RASTREÁVEL para código](https://img.shields.io/badge/RASTREÁVEL-para%20código-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **legacy-docs-catalog**

> **Para quem é isto?** Para especificadores, arquitetos e tech leads que precisam saber quais regras estão documentadas e como elas mapeiam para o código legado.
>
> **O que você terá ao final desta leitura:**
>
> 1. Catálogo consolidado das 3 fontes documentais (1997/2008/2012)
> 2. Mapeamento direto para os fragmentos de código (`rules-par{1..5}.md`)
> 3. Divergências críticas que bloqueiam o Estágio 2 até decisão
> 4. Lacunas — regras que existem só no código
> 5. Rastreabilidade pronta para alimentar `source_legacy:` nas EARS

---

## Resumo Executivo

| Métrica | Valor |
|---|---:|
| RN-NNN documentadas (2012) | 23 |
| MT-NNN operacionais (2008) | 9 transações + 8 batches + 3 consultas |
| AR-NNN arquiteturais (1997) | 7 decisões + 4 módulos + 4 DDMs + 7 fases |
| Cruzadas com código (187 regras) | 43 confirmadas, 104 inferidas, 44 com mistério |
| Divergências críticas | 13 bloqueadoras do Estágio 2 |
| Lacunas (sem doc em nenhuma fonte) | 11 áreas |

---

## 1. RN-NNN — Regras de Negócio Documentadas (2012)

> **Fonte:** `01-arqueologia/legado-sifap/legacy-docs/REGRAS-NEGOCIO-2012.md`
> **Status:** rascunho — interrompido em ago/2012 (cobertura estimada ~25% do sistema)
> **Cobertura:** módulos cadastro, cálculo, validação parcial; descontos parciais

| ID | Declaração | Módulo | Status doc | Confirmada no código | Divergência | Notas |
|---|---|---|---|---|---|---|
| **RN-001** | CPF e NIS obrigatórios, validação por dígito verificador | Cadastro | DOCUMENTADA | ✅ | Nenhuma | Cita `VALCPF`; código implementa inline em `VALIDA-CPF` (CADBENEF, VALBENEF, VALDOCS) |
| **RN-002** | CPF único para beneficiário ativo (status `A`) | Cadastro | DOCUMENTADA | ✅ | Nenhuma | CADBENEF impede insert duplicado |
| **RN-003** | Vínculo obrigatório com programa social ativo | Cadastro | DOCUMENTADA | ✅ | Nenhuma | BATCHPGT (BP-05) e VALELEG verificam |
| **RN-004** | Máx 3 dependentes | Cadastro | DOCUMENTADA | ⚠️ | **CRÍTICA** | Código aceita 5; DDM permite 10. Tripla divergência |
| **RN-005** | Região válida (01-27), 99 reservado | Cadastro | DOCUMENTADA | ⚠️ | **CRÍTICA** | VALELEG trata 99 como bypass de elegibilidade |
| **RN-006** | Idade mínima 16 anos na inclusão | Cadastro | DOCUMENTADA | ✅ | Nenhuma | Idade calculada só por ano (±1 imprecisão) |
| **RN-007** | Dados bancários obrigatórios para ativos | Cadastro | DOCUMENTADA | ✅ | Nenhuma | Sem validação contra tabela de bancos atual |
| **RN-008** | Regras de alteração de dados bancários | Cadastro | PENDENTE | ❌ | N/A | Levantamento incompleto; CADBENEF SF02 marca CPF/banco/agência/conta como imutáveis |
| **RN-009** | Alteração de CPF exige supervisor + `BN-NR-CPF-ANT` | Cadastro | DOCUMENTADA | ❌ | **CRÍTICA** | Campo não existe no DDM; provavelmente feature nunca implementada |
| **RN-010** | Auditoria automática via `LOGAUDIT` em UPDATE | Cadastro | DOCUMENTADA | ⚠️ | **CRÍTICA** | CADBENEF não chama `LOGAUDIT`; AUDITORIA é alimentada por outro caminho |
| **RN-011** | Exclusão sempre lógica (`SIT='E'`) | Cadastro | DOCUMENTADA | ✅ | Parcial | RELAUDIT filtra `ACAO='EX'` do relatório — auditoria oculta exclusões |
| **RN-012** | Bloqueio de exclusão com pagamentos pendentes | Cadastro | DOCUMENTADA | ⚠️ | Parcial | Doc fala em status `P`; código grava `G` |
| **RN-013** | Fórmula `VALOR = BASE + (ACRES × QT-DEP)` | Cálculo | DOCUMENTADA | ❌ | **CRÍTICA** | Código é multiplicativo: `BASE × FATOR-REG × FATOR-FAM × FATOR-RND × FATOR-IDADE × (1+REAJ)` |
| **RN-014** | Truncamento, não arredondamento | Cálculo | DOCUMENTADA | ✅ | Parcial | BATCHREL arredonda, BATCHPGT trunca — divergência interna |
| **RN-015** | Regras de elegibilidade por programa | Elegibilidade | PENDENTE | ⚠️ | N/A | VALELEG implementa 19 regras inferidas; doc nunca cobriu |
| **RN-016** | Integração com CadÚnico | Elegibilidade | PENDENTE | ❌ | **CRÍTICA** | Doc fala em “implementação emergencial 2006”; código não localizado nos 15 .NSN |
| **RN-017** | Faixas parametrizadas em PROGRAMA-SOCIAL (≤10) | Cálculo | DOCUMENTADA | ✅ | Parcial | CALCBENF tem 5 faixas hardcoded; DDM tem PE de 5 ocorrências |
| **RN-018** | Atribuição por “primeira faixa cujo teto ≥ renda” | Cálculo | DOCUMENTADA | ✅ | Nenhuma | CALCBENF (DET-FAIXA-RENDA) + BATCHPGT (BP-25) |
| **RN-019** | Reajuste anual em janeiro via decreto | Cálculo | DOCUMENTADA | ✅ | Parcial | Tabela IPCA estática 2010-2012; fora dessa janela sem correção silenciosa |
| **RN-020** | Reajuste incide sobre VALOR-BASE | Cálculo | DOCUMENTADA | ⚠️ | Nenhuma | Doc nota “não validada”; código aplica conforme |
| **RN-021** | Limite 30% do valor bruto para descontos | Descontos | DOCUMENTADA | ✅ | Parcial | CALCDSCT respeita; tipo `J` (judicial) ignora o cap |
| **RN-022** | Tipos de desconto (lista incompleta) | Descontos | DOCUMENTADA | ⚠️ | **CRÍTICA** | Doc lista 5 tipos; código usa 6+ (C/I/J/S/P/A) |
| **RN-023** | Descarte por prioridade (01→05) | Descontos | DOCUMENTADA | ⚠️ | **CRÍTICA** | Código apenas trunca total agregado em 30%, não descarta por prioridade |

### Status geral RN-NNN

| Status | Quantidade |
|---|---:|
| DOCUMENTADA + ✅ confirmada | 12 |
| DOCUMENTADA + ⚠️ divergente/parcial | 9 |
| DOCUMENTADA + ❌ ausente no código | 2 |
| PENDENTE (não levantada em 2012) | 3 |

---

## 2. MT-NNN — Operações e Fluxos Técnicos (2008)

> **Fonte:** `01-arqueologia/legado-sifap/legacy-docs/MANUAL-TECNICO-SIFAP-2008.md`
> **Versão:** 2.3.1 (nov/2008)

### Transações online

| ID | TX | Programa | Descrição | Confirmada | Notas |
|---|---|---|---|---|---|
| MT-TRX-001 | SF01 | CADBENEF | Inclusão de beneficiário | ✅ | Status inicial forçado a `A` |
| MT-TRX-002 | SF02 | CADBENEF | Alteração de beneficiário | ✅ | CPF/sexo/banco imutáveis |
| MT-TRX-003 | SF03 | CADBENEF | Exclusão lógica | ✅ | Marca `SIT='E'` |
| MT-TRX-004 | SF04 | CADDEPEND | Cadastro de dependentes | ✅ | Limite 5 (não 3 como RN-004) |
| MT-TRX-005 | SF06 | CADPROG | Manutenção de programas sociais | ⚠️ | Fator K = 0.347215 não documentado |

### Programas de cálculo

| ID | Programa | Descrição | Confirmada | Notas |
|---|---|---|---|---|
| MT-CALC-001 | CALCBENF | Cálculo mensal de benefício | ✅ | Fórmula multiplicativa — diverge de RN-013 |
| MT-CALC-002 | CALCCORR | Reajuste/correção anual | ⚠️ | Tabela IPCA estática 2010-2012 |
| MT-CALC-003 | CALCDSCT | Descontos (a partir de 2015) | ✅ | Não estava no Manual 2008 — adicionado posteriormente |

### Programas de validação

| ID | Programa | Descrição | Confirmada | Notas |
|---|---|---|---|---|
| MT-VAL-001 | VALBENEF | Validação cadastral | ✅ | Implementada inline também em CADBENEF |
| MT-VAL-002 | VALELEG | Validação de elegibilidade | ✅ | 19 regras inferidas, sem cobertura doc |
| MT-VAL-003 | VALDOCS | Validação de documentação | ✅ | Prefixos especiais anulam erros (backdoor) |

### Fluxo batch mensal

| ID | Etapa | Descrição | Confirmada | Notas |
|---|---|---|---|---|
| MT-BATCH-001 | D-5 | Atualização CADPROG | ✅ | — |
| MT-BATCH-002 | D-3 | Fechamento de cadastro | ✅ | Procedimento manual |
| MT-BATCH-003 | D-2 | Validação elegibilidade batch | ✅ | — |
| MT-BATCH-004 | D-1 | Relatório prévio | ✅ | — |
| MT-BATCH-005 | D (1º DU) | BATCHPGT — processamento mensal | ✅ | Crítico; tempo ~2h45min em 2008 |
| MT-BATCH-006 | D+1 | Envio CNAB 240 ao BB | ✅ | Gerado por BATCHPGT |
| MT-BATCH-007 | D+2 | Envio ao SIAFI | ⚠️ | Layout divergiu 1997→2002 |
| MT-BATCH-008 | D+4 | BATCHCON — conciliação | ✅ | Match tripla (documento + CPF + competência) |
| MT-BATCH-009 | D+5 | BATCHREL — relatórios finais | ✅ | Paginação 66 linhas; agrupamento regional divergente |

### Consultas e relatórios online

| ID | Programa | Descrição | Confirmada | Notas |
|---|---|---|---|---|
| MT-CONS-001 | CONSBENF | Consulta de beneficiário | ✅ | Bug conhecido em máscara CPF |
| MT-CONS-002 | RELAUDIT | Relatório de auditoria | ✅ | Oculta `ACAO='EX'` (compliance) |
| MT-CONS-003 | RELPGT | Relatório analítico de pagamentos | ✅ | Subtotais por programa |

---

## 3. AR-NNN — Arquitetura e Decisões (1997)

> **Fonte:** `01-arqueologia/legado-sifap/legacy-docs/ARQUITETURA-ORIGINAL-1997.md`
> **Data:** mai/1997 (pré-desenvolvimento)

### Plataforma

| ID | Decisão | Planejado (1997) | Realizado | Status |
|---|---|---|---|---|
| AR-TECH-001 | Linguagem | Natural 4.2.6 | Natural 6.3.12 (2005) | ✅ mantido |
| AR-TECH-002 | SGBD | Adabas 6.1.4 | Adabas 7.4.3 (2005) | ✅ mantido |
| AR-TECH-003 | TP Monitor | Com*plete 6.1.2 | Com*plete 6.3.1 | ✅ mantido |
| AR-TECH-004 | Scheduler | JES2 MVS/ESA | JES2 z/OS 1.8 | ✅ mantido |
| AR-TECH-005 | S.O. | MVS/ESA 5.2.2 | z/OS 1.8 | ✅ mantido |

### Estrutura modular

| ID | Módulo | Planejado | Realizado | Status |
|---|---|---|---|---|
| AR-MOD-001 | CADASTRO | CADBENEF/CADDEPEND/CADPROG | igual | ✅ |
| AR-MOD-002 | PROCESSAMENTO | BATCHPGT/BATCHREL/BATCHCON | + CALCBENF/CALCCORR/CALCDSCT (2015) | ⚠️ expandido |
| AR-MOD-003 | CONSULTA | CONSBENF/CONSPGT | CONSBENF/RELPGT/RELAUDIT | ⚠️ divergente |
| AR-MOD-004 | AUDITORIA | AUDCONSUL/AUDRELAT | RELAUDIT (2005) | ⚠️ substituído |
| AR-MOD-004B | VALIDAÇÃO | (não planejado) | VALBENEF/VALDOCS/VALELEG | ➕ novo |

### Modelo de dados

| ID | Componente | Planejado | Realizado | Status |
|---|---|---|---|---|
| AR-DDM-001 | BENEFICIARIO (150) | ✅ | ✅ | OK |
| AR-DDM-002 | PROGRAMA-SOCIAL (151) | ✅ | ✅ | OK |
| AR-DDM-003 | PAGAMENTO (152) | ✅ | ✅ | OK |
| AR-DDM-004 | AUDITORIA (153) | (era PE em BENEFICIARIO) | criado em 2005 | ➕ novo |

### Roadmap original (7 fases, 1997-2000)

| Fase | Prazo | Scope | Realizado | Status |
|---|---|---|---|---|
| F1 | 1997 H2 | Cadastro | sim (atraso 2m) | ✅ |
| F2 | 1998 H1 | Batch (BATCHPGT/BATCHREL) | sim | ✅ |
| F3 | 1998 H2 | Auditoria + BATCHCON + SIAFI | parcial (BATCHCON em 2002) | ⚠️ |
| F4 | 1999 H1 | Validação | sim (VALELEG só em 2015) | ✅ |
| F5 | 1999 H2 | Relatórios gerenciais avançados | não | ❌ |
| F6 | 2000 H1 | Módulo Web (Natural Web Interface) | não | ❌ |
| F7 | 2000 H2 | Integração RF online | implementado diferente (CICS, 2002) | ⚠️ |

---

## 4. Cruzamento Código × Documentação

| Categoria | RN | MT | AR | Total |
|---|---:|---:|---:|---:|
| ✅ Confirmada (doc + código) | 12 | 25+ | 15 | 52 |
| ⚠️ Divergente | 9 | 3 | 8 | 20 |
| ❌ Ausente / pendente | 5 | — | 1 | 6 |
| Sem doc (só código) | — | — | — | 104 inferidas + 44 com mistério |

### Divergências críticas (bloqueadoras Estágio 2)

| # | Tema | Doc | Código | Ação |
|---|---|---|---|---|
| D-01 | Limite de dependentes (RN-004) | 3 | 5 | Decisão PO + investigar portaria |
| D-02 | Região 99 (RN-005) | Reservado | Bypass de elegibilidade | Investigar com SME |
| D-03 | Fórmula de cálculo (RN-013) | Aditiva | Multiplicativa | Risco fiscal — escalar |
| D-04 | Status inicial de pagamento | `P` | `G` | Diagrama de máquina de estados |
| D-05 | Campo `BN-NR-CPF-ANT` (RN-009) | Existe | Não existe | Feature nunca implementada? |
| D-06 | `LOGAUDIT` em UPDATE (RN-010) | Obrigatório | Não chamado | Investigar origem dos eventos |
| D-07 | Tipos de desconto (RN-022) | 5 | 6+ | Validar enum legal |
| D-08 | Descarte por prioridade (RN-023) | Sim | Cap agregado | Decisão PO/jurídico |
| D-09 | Trunca vs arredonda | Trunca | BATCHPGT trunca, BATCHREL arredonda | Padronizar |
| D-10 | Exceção judicial 30% (RN-021) | Não confirmada | Confirmada (tipo `J`) | Buscar respaldo legal |
| D-11 | CadÚnico (RN-016) | Programa não catalogado | Implementação emergencial | Localizar código fora do escopo |
| D-12 | RELAUDIT oculta `EX` | Auditoria completa | Filtra exclusões | Compliance |
| D-13 | Agrupamento regional 21-27 | 27 UFs + 99 | 21-27 → “Centro-Oeste” | Bug ou regra? |

---

## 5. Lacunas (sem doc em nenhuma fonte)

| # | Área | Onde aparece no código | Prioridade |
|---|---|---|---|
| L-01 | Fator K | CADPROG (0.347215) + BATCHPGT (4 fatores) | **ALTA** |
| L-02 | 13º benefício (abono natalino) | BATCHPGT:L290-L302, CALCBENF:L243-L260 | **ALTA** |
| L-03 | Fator regional (25 valores) | CALCBENF:L93-L119 | MÉDIA |
| L-04 | Faixas de renda hardcoded | CALCBENF:L121-L131 (última carga 2013) | MÉDIA |
| L-05 | Descontos tipo `J` sem cap | CALCDSCT:L113-L118 | **ALTA** |
| L-06 | FATOR-RENDA não parametrizado | CALCBENF | MÉDIA |
| L-07 | Status `C`/`D` (cancelado/desligado) | CADDEPEND bloqueia, mas ninguém os cria | **ALTA** |
| L-08 | Integração CadÚnico | mencionado em RN-016, código ausente | **ALTA** |
| L-09 | Tabela IPCA estática | CALCCORR:L46-L82 | MÉDIA |
| L-10 | Bloco Plano Verão comentado | CALCCORR:L84-L96 | BAIXA |
| L-11 | Máquina de estados PAGAMENTO completa | BATCHPGT/BATCHCON/RELPGT | MÉDIA |

---

## 6. Recomendações para o Estágio 2

1. **Entrevistas com SME:** Fator K e 13º (SENARC); limite de dependentes; auditoria (CADBENEF × LOGAUDIT).
2. **Resolver D-01..D-13 com ADRs:** cada divergência crítica vira uma decisão registrada antes de virar EARS.
3. **Mapear L-01..L-11:** áreas sem doc precisam de requisito novo (GREENFIELD) com `source_legacy:` apontando para o código real.
4. **EARS rastreáveis:** `source_legacy:` deve apontar para RN-/MT-/AR- quando existir, e para arquivo:linha do .NSN/DDM sempre.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="business-rules-catalog.md"><strong>business-rules-catalog</strong></a><br/>
<sub>Catálogo de regras extraídas do código (187 regras).</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="discovery-report.md"><strong>discovery-report</strong></a><br/>
<sub>Síntese final do Estágio 1.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="README.md">Voltar ao Estágio 1</a></sub>
