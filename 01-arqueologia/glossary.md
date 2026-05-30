<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Glossário do SIFAP Legado

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S1](https://img.shields.io/badge/PREENCHA-Durante%20S1-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **glossary**

> **Para quem é isto?** Este é um **artefato preenchido pelo time** durante o Estágio 1 (Arqueologia).
>
> **O que você terá ao final do estágio:**
>
> 1. Este documento totalmente preenchido com os dados reais do legado SIFAP
> 2. Rastreabilidade para `01-arqueologia/legado-sifap/` (programas `.NSN` e DDMs)
> 3. Base de evidência usada nas EARS do Estágio 2 (`source_legacy:`)
>
> 📘 **Guia passo a passo:** [`GUIDE.md`](GUIDE.md).


> Preencha esta tabela com todos os termos, abreviações e siglas encontrados no código Natural/Adabas.
> **Meta: no mínimo 30 termos.**

## Por que isso importa

Sistemas legados têm vocabulário próprio que ninguém documenta em lugar nenhum — só está no nome das variáveis. Se o time do Estágio 2 não souber o que `DSCT`, `BENF`, `PE` ou `CTC` significam, vai escrever uma spec sobre o que ele _acha_ que isso significa. Glossário é o que evita esse desencontro.

## Como preencher

- **Termo**: a abreviação ou sigla exatamente como aparece no código
- **Expansão**: o significado completo do termo
- **Programa**: em qual arquivo `.NSN` ou `.ddm` o termo foi encontrado
- **Contexto**: breve explicação de como/onde o termo é usado

## Dica de extração

Prompt útil no Copilot Chat (cole o conteúdo de 2–3 arquivos `.NSN` no chat antes):

> _"Liste todas as abreviações e siglas usadas neste código Natural. Para cada uma, sugira a expansão e marque com 'CONFIRMADO' ou 'HIPÓTESE'."_

## Termos encontrados

> Extraídos dos 15 programas `.NSN`, 4 DDMs Adabas e 3 documentos históricos. Status: **CONFIRMADO** quando há evidência literal no código/doc; **HIPÓTESE** quando inferido pelo contexto e ainda precisa validação com SME.

### Cadastro e Beneficiário (10)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 1  | `BENF` / `BN` | Beneficiário | `BENEFICIARIO.ddm`, `CADBENEF.NSN`, `VALBENEF.NSN` | Prefixo de campos da entidade principal (`BN-CD-CPF`, `BN-CD-SIT`) | CONFIRMADO |
| 2  | `CPF` | Cadastro de Pessoa Física | todos | Chave primária; validação por dígito verificador em 4 programas | CONFIRMADO |
| 3  | `NIS` | Número de Identificação Social | `CADBENEF.NSN`, RN-001 | Identificador alternativo do beneficiário | CONFIRMADO |
| 4  | `SIT` / `STATUS` | Situação | `BENEFICIARIO.ddm` (CE), `CADBENEF.NSN` | Estado do beneficiário (A/S/C/I/D/E) — domínio diverge entre DDM e doc | CONFIRMADO |
| 5  | `DEPEND` / `DEP` | Dependente | `CADDEPEND.NSN`, `BENEFICIARIO.ddm` (PE DA) | Filiação ao beneficiário titular; limite tripla divergência 3/5/10 | CONFIRMADO |
| 6  | `MAT` | Matrícula | `BENEFICIARIO.ddm` (AA) | Sinônimo de `NUM-INSCRICAO` — chave alternativa | HIPÓTESE |
| 7  | `EST-CIVIL` | Estado Civil | `BENEFICIARIO.ddm` (AH) | Domínio: S=solteiro, C=casado, D=divorciado, V=viúvo, U=união estável | CONFIRMADO |
| 8  | `LOTACAO` | Unidade Organizacional | `AUDITORIA.ddm` (ED) | Código da unidade de lotação do usuário | CONFIRMADO |
| 9  | `PARENTESCO` | — | `BENEFICIARIO.ddm` (DE), `CADDEPEND.NSN` | Domínio diverge: DDM={FI,CJ,NT,TU}; código aceita CO/IR/OU | CONFIRMADO |
| 10 | `BIOMETRIA` | — | `BENEFICIARIO.ddm` (FA-FD) | Adição 2005; `HASH-DIGITAL` órfão (nunca preenchido) | CONFIRMADO |

### Pagamento e Cálculo (8)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 11 | `PGTO` / `PG` | Pagamento | `PAGAMENTO.ddm`, `BATCHPGT.NSN`, `RELPGT.NSN` | Tabela transacional; ~180M registros sem purge | CONFIRMADO |
| 12 | `VLR-BASE` | Valor Base | `CALCBENF.NSN`, `PROGRAMA-SOCIAL.ddm` (BA) | Valor mensal individual antes de fatores | CONFIRMADO |
| 13 | `VLR-LIQUIDO` | Valor Líquido | `PAGAMENTO.ddm` (BB), `CALCDSCT.NSN` | Bruto menos descontos | CONFIRMADO |
| 14 | `FATOR-K` | Fator de correção SENARC | `PROGRAMA-SOCIAL.ddm` (BG), `CADPROG.NSN:L81-L83` | **MISTÉRIO** — constante 0.347215 sem origem documentada | HIPÓTESE |
| 15 | `FATOR-REG` | Fator regional | `CALCBENF.NSN:L93-L119` | 25 valores hardcoded (1.0000-1.4000); MA=1.4000, ES=1.0500 | CONFIRMADO |
| 16 | `FAIXA-RENDA` | Faixa de renda familiar | `CALCBENF.NSN:L121-L131` | 5 faixas hardcoded (300/600/1000/1500/9999,99); última carga 2013 | CONFIRMADO |
| 17 | `CICLO` | Ciclo de processamento | `PAGAMENTO.ddm` (AF), `BATCHPGT.NSN` | Número sequencial mensal de batch | CONFIRMADO |
| 18 | `ABONO` | Abono natalino (13º) | `BATCHPGT.NSN:L290-L302`, `CALCBENF.NSN:L243-L260` | Em dezembro, programas TIPO='A' ganham +15% | CONFIRMADO |

### Desconto (8)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 19 | `DSCT` | Desconto | `CALCDSCT.NSN`, `PAGAMENTO.ddm` (PE CA) | Tipo de dedução sobre valor bruto | CONFIRMADO |
| 20 | `IR` | Imposto de Renda | `CALCDSCT.NSN`, `PROGRAMA-SOCIAL.ddm` (MU EA) | Tipo de desconto fiscal | CONFIRMADO |
| 21 | `JD` / `J` | Judicial | `CALCDSCT.NSN:L113-L118` | Único tipo que **ignora** cap de 30% — sem respaldo legal documentado | CONFIRMADO |
| 22 | `CS` | Consignação Sindical | `CALCDSCT.NSN` | Desconto a favor de sindicato (1% padrão) | CONFIRMADO |
| 23 | `PA` | Pensão Alimentícia | `CALCDSCT.NSN` | Desconto judicial recorrente | CONFIRMADO |
| 24 | `EM` | Empréstimo | `CALCDSCT.NSN` | Consignado bancário | HIPÓTESE |
| 25 | `TX` | Taxa administrativa | `CALCDSCT.NSN` | Taxa do programa | HIPÓTESE |
| 26 | `EX` | Excepcional | `CALCDSCT.NSN`, `AUDITORIA.ddm` (BA) | Cuidado: também é código de ação de auditoria oculta | CONFIRMADO |

### Status de Pagamento (8)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 27 | `'P'` | Pendente | doc Manual §3.5.1 + `BATCHCON.NSN` | Estado documentado mas **não inicial** — divergência | CONFIRMADO |
| 28 | `'G'` | Gerado | `CALCBENF.NSN:L283`, `BATCHPGT.NSN:L332` | Status real inicial — **ausente do manual** (INC-002) | CONFIRMADO |
| 29 | `'E'` | Erro / Emitido | `PAGAMENTO.ddm` (DA), `BATCHCON.NSN` | Ambíguo: também usado para beneficiário excluído | CONFIRMADO |
| 30 | `'C'` | Cancelado / Conciliado | `PAGAMENTO.ddm` (DA), `BENEFICIARIO.ddm` (CE) | Sobrecarga entre PAGAMENTO e BENEFICIARIO | CONFIRMADO |
| 31 | `'D'` | Devolvido / Desligado | `PAGAMENTO.ddm`, `CADDEPEND.NSN` | Sobrecarga entre PAGAMENTO e BENEFICIARIO | CONFIRMADO |
| 32 | `'X'` | Excluído (lógico) | `PAGAMENTO.ddm` (DA) | Soft-delete | HIPÓTESE |
| 33 | `'R'` | Rejeitado | `PAGAMENTO.ddm` (DA) | Retorno bancário com erro | HIPÓTESE |
| 34 | `'S'` | Sênior / Suspenso | `BENEFICIARIO.ddm` (CE), `CADBENEF.NSN:L167-L169` | **MYS-001** — gravado silenciosamente para >75 anos | CONFIRMADO |

### Auditoria e Ação (10)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 35 | `AUD` / `AUDIT` | Auditoria | `AUDITORIA.ddm`, `RELAUDIT.NSN` | Trilha imutável; ~25M registros desde 1998 | CONFIRMADO |
| 36 | `IN` | Inclusão (ação) | `AUDITORIA.ddm` (BA) | Tipo de evento de auditoria | CONFIRMADO |
| 37 | `AL` | Alteração (ação) | `AUDITORIA.ddm` (BA) | Tipo de evento | CONFIRMADO |
| 38 | `EX` (ação) | Exclusão (ação) | `AUDITORIA.ddm` (BA), `RELAUDIT.NSN` | **MYS-010** — RELAUDIT filtra silenciosamente | CONFIRMADO |
| 39 | `CO` | Consulta (ação) | `AUDITORIA.ddm` (BA) | Não gravada desde 2010 (decisão CGTI 213/2010) | CONFIRMADO |
| 40 | `LG`/`LO` | Login/Logout | `AUDITORIA.ddm` (BA) | Eventos de sessão | CONFIRMADO |
| 41 | `BT` | Batch | `AUDITORIA.ddm` (BA) | Evento gerado por job batch | CONFIRMADO |
| 42 | `ER` | Erro | `AUDITORIA.ddm` (BA) | Falha rastreada | CONFIRMADO |
| 43 | `AU`/`RE` | Autorização/Rejeição | `AUDITORIA.ddm` (BA) | Aprovação ou negação | CONFIRMADO |
| 44 | `LOGAUDIT` | Subprograma de log | doc RN-010 | **Citado em doc, ausente do código CADBENEF SF02** — D-06 | CONFIRMADO |

### Técnico Natural / Adabas (10)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 45 | `DDM` | Data Definition Module | `*.ddm` | Schema Adabas (tipo de FDT visto pelo Natural) | CONFIRMADO |
| 46 | `FDT` | Field Definition Table | doc Manual 2008 | Estrutura física do arquivo Adabas | CONFIRMADO |
| 47 | `FNR` | File Number | `*.ddm` (BENF=150, PROG=151, PGTO=152, AUD=153) | ID numérico do arquivo Adabas | CONFIRMADO |
| 48 | `PE` | Periodic Group | `BENEFICIARIO.ddm` (DA), `PAGAMENTO.ddm` (CA) | Grupo de campos repetível com cardinalidade fixa | CONFIRMADO |
| 49 | `MU` | Multiple-Value Field | `PROGRAMA-SOCIAL.ddm` (EA), `AUDITORIA.ddm` (DB-DF) | Campo com múltiplos valores (array) | CONFIRMADO |
| 50 | `DE` | Descriptor | `*.ddm` (várias colunas) | Campo indexado para busca | CONFIRMADO |
| 51 | `S1`/`S2`/`S3` | Super-Descriptor | `*.ddm` | Índice composto (chave composta) | CONFIRMADO |
| 52 | `ISN` | Internal Sequence Number | (implícito) | ID físico do registro Adabas | CONFIRMADO |
| 53 | `CALLNAT` | Chamada de subprograma | todos `.NSN` | Chamada para subprograma externo (compilação separada) | CONFIRMADO |
| 54 | `PERFORM` | Chamada de sub-rotina interna | vários `.NSN` | Chamada interna ao mesmo programa | CONFIRMADO |

### CNAB e Banco (5)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 55 | `CNAB` | Centro Nacional de Automação Bancária | `BATCHPGT.NSN`, `BATCHCON.NSN` | Layout 240 para envio/retorno ao Banco do Brasil | CONFIRMADO |
| 56 | `FEBRABAN` | Federação Brasileira de Bancos | `PAGAMENTO.ddm` (EA) | Código do banco (3 dígitos) | CONFIRMADO |
| 57 | `SIAFI` | Sistema Integrado de Adm. Financeira | `PAGAMENTO.ddm` (FA-FE) | Integração federal (campos adicionados em 2002) | CONFIRMADO |
| 58 | `BB` | Banco do Brasil | `BATCHPGT.NSN` | Banco pagador padrão | CONFIRMADO |
| 59 | `Banco Real` (356) | Banco extinto | `BATCHCON.NSN#L203-L212` | **EGG-003** — integração comentada após aquisição pelo Santander (2007) | CONFIRMADO |

### Programas e Transações (5)

| #  | Termo | Expansão | Programa | Contexto | Status |
| -- | ----- | -------- | -------- | -------- | ------ |
| 60 | `SF01..SF06` | Transações de cadastro | doc Manual 2008 §3 | SF01=incluir, SF02=alterar, SF03=excluir, SF04=dependentes, SF06=programas | CONFIRMADO |
| 61 | `BATCHPGT` | Batch de pagamento | `BATCHPGT.NSN` | Job mensal (1º DU) — ~2h45min em 2008 | CONFIRMADO |
| 62 | `BATCHCON` | Batch de conciliação | `BATCHCON.NSN` | Match tripla (documento + CPF + competência) | CONFIRMADO |
| 63 | `BATCHREL` | Batch de relatórios | `BATCHREL.NSN` | Paginação 132×66 (mainframe) | CONFIRMADO |
| 64 | `RELAUDIT` / `RELPGT` / `CONSBENF` | Relatórios e consulta online | `*.NSN` | Apuração analítica; CONSBENF tem bug conhecido em máscara CPF | CONFIRMADO |

## Exemplo de linha bem preenchida

| #   | Termo  | Expansão | Programa                        | Contexto                                                                                                         |
| --- | ------ | -------- | ------------------------------- | ---------------------------------------------------------------------------------------------------------------- |
| 1   | `DSCT` | Desconto | `CALCDSCT.NSN`, `PAGAMENTO.ddm` | Tipo de dedução aplicada sobre valor bruto do pagamento. Tipos: 'J' (judicial), 'I' (imposto), 'T' (trabalhista) |

## Observações

**Convenções de prefixo encontradas em campos DDM:**

- `BN-` → Beneficiário (em BENEFICIARIO.ddm)
- `PG-` → Pagamento (em PAGAMENTO.ddm)
- `PR-` → Programa Social (em PROGRAMA-SOCIAL.ddm)
- `AU-` → Auditoria (em AUDITORIA.ddm)
- `CD-` → Código (`CD-CPF`, `CD-SIT`, `CD-REGIAO`)
- `DT-` → Data (`DT-NASC`, `DT-CADASTRO`)
- `VLR-` → Valor monetário (`VLR-BASE`, `VLR-LIQUIDO`)
- `GRP-` → Grupo periódico (`GRP-DEPENDENTE`, `GRP-DESCONTO`)
- `IND-` → Indicador / flag binária
- `NUM-` → Número sequencial (`NUM-INSCRICAO`, `NUM-CICLO`)
- `TX-` → Texto livre / observação

**Convenções de prefixo em programas Natural (`.NSN`):**

- `CAD*` → Cadastro / CRUD online (CADBENEF, CADDEPEND, CADPROG)
- `BATCH*` → Job batch noturno/mensal (BATCHPGT, BATCHCON, BATCHREL)
- `CALC*` → Cálculo de valor (CALCBENF, CALCCORR, CALCDSCT)
- `VAL*` → Validação reutilizável (VALBENEF, VALDOCS, VALELEG)
- `CONS*` → Consulta online (CONSBENF)
- `REL*` → Relatório (RELAUDIT, RELPGT)

**Termos ambíguos que precisam de validação com SME:**

- `'P'` vs `'G'` — manual diz `'P'` (Pendente) é inicial; código grava `'G'` (Gerado). **INC-002** — qual é a verdade?
- `'E'` — significa Erro em PAGAMENTO ou Excluído em BENEFICIARIO? Sobrecarga perigosa.
- `'C'`, `'D'`, `'X'` — semântica diferente entre PAGAMENTO e BENEFICIARIO/DEPENDENTE.
- `EX` — em AUDITORIA é "Exclusão"; em DESCONTO é "Excepcional". Contexto desambigua.
- `FATOR-K = 0.347215` — **MYS-003** — origem legal/atuarial sem documentação.
- `MAT` (matrícula) — sinônimo de `NUM-INSCRICAO`? Validar com Cadastro.
- Domínio de `PARENTESCO` — DDM lista {FI,CJ,NT,TU}; código aceita CO/IR/OU; manual diz {FI, CJ, AS, PA, MA, IR, OU}. **D-09**.

**Observações gerais:**

- Comentários em Natural são em **maiúsculas** sem acentos (limitação do encoding mainframe).
- Nomes de variáveis usam `-` (não `_`); JPA precisará mapear via `@Column(name = "BN-CD-CPF")` ou renomear.
- Padding com zeros à esquerda em campos numéricos é cultural (`00012345` em vez de `12345`).
- Decimais empacotados (formato `P`) — última nibble é sinal; cuidado na migração para `NUMERIC`/`BigDecimal`.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="GUIDE.md"><strong>GUIDE do Estágio 1</strong></a><br/>
<sub>Passo a passo do estágio.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="business-rules-catalog.md"><strong>business-rules-catalog.md</strong></a><br/>
<sub>Catálogo de regras.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="README.md">Voltar ao Kit PT-BR</a></sub>

