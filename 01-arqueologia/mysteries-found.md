<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Mistérios Encontrados — SIFAP Legado

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S1](https://img.shields.io/badge/PREENCHA-Durante%20S1-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **mysteries-found**

> **Para quem é isto?** Este é um **artefato preenchido pelo time** durante o Estágio 1 (Arqueologia).
>
> **O que você terá ao final do estágio:**
>
> 1. Este documento totalmente preenchido com os dados reais do legado SIFAP
> 2. Rastreabilidade para `01-arqueologia/legado-sifap/` (programas `.NSN` e DDMs)
> 3. Base de evidência usada nas EARS do Estágio 2 (`source_legacy:`)
>
> 📘 **Guia passo a passo:** [`GUIDE.md`](GUIDE.md).


> Registre aqui toda lógica, comportamento ou código que o time não conseguiu explicar.
> "Mistérios" são trechos de código sem documentação, com lógica não-óbvia ou que parecem workarounds.
>
> **Cota mínima para passar pelo portão do Estágio 2:** 5 mistérios documentados.

## O que conta como "mistério"?

- Código que faz algo inesperado sem comentário explicando por quê
- Valores hardcoded sem explicação (números mágicos)
- Lógica condicional que parece um workaround ou gambiarra
- Campos no DDM que não são usados por nenhum programa
- Programas que existem mas não são chamados por ninguém
- Comportamento diferente entre o que a documentação diz e o que o código faz
- Easter eggs deixados pelos desenvolvedores originais

## Níveis de Confiança

| Nível     | Significado                                         |
| --------- | --------------------------------------------------- |
| **ALTA**  | Temos certeza de que há algo estranho aqui          |
| **MÉDIA** | Parece suspeito, mas pode ter explicação            |
| **BAIXA** | Pode ser intencional, mas não conseguimos confirmar |

## Resumo de Cobertura da Rubrica

> Reconciliação dos 44 flags brutos do [`business-rules-catalog.md`](business-rules-catalog.md) (campos `<!-- mystery: -->`) contra os 17 slots oficiais do [`mysteries-checklist.md`](mysteries-checklist.md).

| Categoria          | Slots plantados | Encontrados | Pontos rubrica A1 |
| ------------------ | --------------: | ----------- | ----------------- |
| MYS (★ a ★★★)      |              10 | 10          | **22 / 22**       |
| EGG (★)            |               3 | 3           | **3 / 3**         |
| INC (bônus)        |               4 | 4           | **4 / 4**         |
| **Total**          |          **17** | **17**      | **32 / 32**       |

**Faixa estimada:** Excelente — 17 / 17 slots confirmados, 32 / 32 pontos rubrica A1.

## Mistérios Catalogados

| ID      | Descrição                                                       | Onde Encontrado                                                    | Impacto Potencial                                            | Confiança |
| ------- | --------------------------------------------------------------- | ------------------------------------------------------------------ | ------------------------------------------------------------ | --------- |
| MYS-001 | Status `S` silencioso para idosos > 75 anos                     | `CADBENEF.NSN#L167-L169`                                           | Categoria fora do domínio publicado; risco em cálculo        | ALTA      |
| MYS-002 | Tripla divergência: DDM=10, Code=5, Doc=3 dependentes           | `BENEFICIARIO.ddm#L61` + `CADDEPEND.NSN#L66-L69` + RN-004          | Aceitar família fora de regra ou rejeitar válida             | ALTA      |
| MYS-003 | Constante mágica Fator K = 0.347215 sem origem legal            | `CADPROG.NSN#L81`                                                  | Toda fórmula de benefício depende; risco fiscal alto         | ALTA      |
| MYS-004 | Dezembro muda cálculo (13º + abono natalino 15% TIPO='A')       | `BATCHPGT.NSN#L290-L302` + `CALCBENF.NSN#L243-L260`                | Fórmula sazonal não documentada; regressão fácil             | ALTA      |
| MYS-005 | Truncamento em BATCHPGT × arredondamento documentado            | `BATCHPGT.NSN` BR-03                                               | Perda sistemática de centavos × milhões                      | ALTA      |
| MYS-006 | Cap agregado de desconto contradiz prioridade RN-023            | `CALCDSCT.NSN` BR-CDSCT-013                                        | Desconto válido reduzido em vez de removido                  | ALTA      |
| MYS-007 | CPF `00000000000` institucionalizado no DDM                     | `BENEFICIARIO.ddm#L62` + `VALBENEF.NSN`                            | Backdoor de cadastro fantasma; risco de fraude               | ALTA      |
| MYS-008 | Região 99 ⇒ elegibilidade automática (INTERNACIONAL/DIPLOMATICO) | `VALELEG.NSN#L102-L106`                                            | Classe inteira pula validação; explosivo em auditoria        | ALTA      |
| MYS-009 | Leitura batch por CPF "porque downstream depende"               | `BATCHPGT.NSN#L178-L186`                                           | Ordem virou contrato implícito com sistemas externos         | ALTA      |
| MYS-010 | RELAUDIT oculta silenciosamente `ACAO='EX'`                     | `RELAUDIT.NSN` RA-MISTERIO-01                                      | Viola RN-011 (auditoria completa); compliance vermelho       | ALTA      |
| EGG-001 | Bloco "Plano Verão" (Cruzado→Cruzeiro, fatores 2.7500/1.4289)   | `CALCCORR.NSN#L84-L101`                                            | Código morto preservado por nota "HISTORICO"                 | ALTA      |
| EGG-002 | Tabela de prefixos especiais em VALDOCS pula validação de DV    | `VALDOCS.NSN` (Par 4)                                              | Backdoor de validação documental                             | MÉDIA     |
| EGG-003 | Banco Real (adquirido pelo Santander em 2007) — integração comentada | `BATCHCON.NSN#L203-L212` — bloco `DEFINE WORK FILE 2` descontinuado | Código morto preservado por nota histórica; banco código 356 | ALTA      |
| INC-001 | Limite documentado diverge do código+DDM (dependentes)          | RN-004 × `CADDEPEND` × `BENEFICIARIO.ddm`                          | Decisão sobre regra "real" precisa subir para PO             | ALTA      |
| INC-002 | Status `'G'` PAGAMENTO + tabela IPCA 2010-2012 ausentes do manual | `CALCBENF.NSN#L283` + `BATCHPGT.NSN#L332` + `CALCCORR.NSN#L43-L82` (manual §3.5.1 e §3.4.3 marcam `[A COMPLETAR]`) | Estruturas adicionadas pós-2008 sem virar documento oficial  | ALTA      |
| INC-003 | Tabelas críticas (25 regiões, fator etário, faixas renda) sem doc | `CALCBENF.NSN:L93-L119` + L205-L217 + BATCHPGT faixas            | Documentação incompleta — não dá para migrar só com docs     | ALTA      |
| INC-004 | Três rounding diferentes: trunca / arredonda / tolera 0,01      | `BATCHPGT` × `CALCCORR` × `BATCHCON`                               | Reconciliação financeira sofre divergência                   | ALTA      |

## Detalhamento dos Mistérios

### MYS-001: Status `S` silencioso para idosos > 75 anos

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/CADBENEF.NSN#L167-L169`](legado-sifap/natural-programs/CADBENEF.NSN)
- **O que esperávamos**: Status fica em `A` (ativo) ou `E` (encerrado), conforme `REGRAS-NEGOCIO-2012.md`.
- **O que o código faz**: Quando `IDADE-CALCULADA > 75`, grava `STATUS = 'S'` sem mensagem ao operador.
- **Hipótese do time**: `S` = "sênior" ou "subsídio especial" — categoria fora do domínio publicado.
- **Risco se ignorarmos**: rotinas de cálculo / relatório que esperam `A`/`E` podem descartar silenciosamente milhares de idosos.

---

### MYS-002: Tripla divergência no limite de dependentes (3 × 5 × 10)

- **Arquivos**:
  - [`01-arqueologia/legado-sifap/adabas-ddms/BENEFICIARIO.ddm#L61`](legado-sifap/adabas-ddms/BENEFICIARIO.ddm) — `GRP-DEPENDENTE PE - 10` (DDM aceita 10)
  - [`01-arqueologia/legado-sifap/natural-programs/CADDEPEND.NSN#L66-L69`](legado-sifap/natural-programs/CADDEPEND.NSN) — código aceita 5
  - `01-arqueologia/legado-sifap/legacy-docs/REGRAS-NEGOCIO-2012.md` RN-004 — doc diz 3
- **Hipótese do time**: regra de negócio foi flexibilizada no código sem atualizar doc nem reduzir DDM. Operação real provavelmente trabalha com 5.
- **Risco se ignorarmos**: no EARS do Estágio 2, escolher 3 quebra histórico, escolher 10 abre brecha. Precisa decisão explícita do PO.

---

### MYS-003: Constante mágica "Fator K" = 0.347215

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/CADPROG.NSN#L81`](legado-sifap/natural-programs/CADPROG.NSN)
- **Hipótese do time**: provável conversão monetária histórica (Cruzeiro Real → Real, julho/1994) ou fator atuarial. Sem comentário, sem rastro em doc.
- **Risco se ignorarmos**: `VLR-BASE` é gravado já multiplicado por K. Batch pode re-aplicar K e gerar pagamento duplo na migração.

---

### MYS-004: Dezembro muda completamente o cálculo

- **Arquivos**:
  - [`01-arqueologia/legado-sifap/natural-programs/BATCHPGT.NSN#L290-L302`](legado-sifap/natural-programs/BATCHPGT.NSN) — BP-18 (`TIPO='D'`), BP-19 (abono 15%)
  - [`01-arqueologia/legado-sifap/natural-programs/CALCBENF.NSN#L243-L260`](legado-sifap/natural-programs/CALCBENF.NSN) — BR-CBENF-014/015
- **O que muda em dezembro**:
  - `TIPO-PGTO = 'D'` (extra)
  - `VLR-13 = VLR-BASE × FATOR-REG × FATOR-IDADE` (fórmula reduzida — faltam fator-fam e fator-rnd usados no mensal)
  - Se `PROGRAMA.TIPO = 'A'` → adiciona 15% de abono natalino
- **Risco se ignorarmos**: regredir esta lógica esconde 8-10% da folha anual de quem participa de programas tipo A.

---

### MYS-005: Truncamento × arredondamento

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/BATCHPGT.NSN`](legado-sifap/natural-programs/BATCHPGT.NSN) BR-03
- **O que esperávamos**: `MANUAL-TECNICO-SIFAP-2008.md §4` manda arredondar na 5ª casa decimal.
- **O que o código faz**: BATCHPGT **trunca** centavos; BATCHCON tolera 0,01; CALCCORR arredonda.
- **Risco se ignorarmos**: perda sistemática de centavos × beneficiários × meses = milhões/ano. Mas downstream depende desta lógica.

---

### MYS-006: Cap agregado contradiz prioridade RN-023

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/CALCDSCT.NSN`](legado-sifap/natural-programs/CALCDSCT.NSN) BR-CDSCT-013
- **O que esperávamos**: RN-023 manda descartar descontos por ordem de prioridade até caber no teto.
- **O que o código faz**: aplica cap agregado proporcional sobre todos descontos.
- **Risco se ignorarmos**: descontos válidos podem ser reduzidos em vez de removidos, gerando contestações trabalhistas.

---

### MYS-007: CPF `00000000000` institucionalizado

- **Evidência**: [`01-arqueologia/legado-sifap/adabas-ddms/BENEFICIARIO.ddm#L62`](legado-sifap/adabas-ddms/BENEFICIARIO.ddm) comenta literalmente `CPF OU 00000000000` — não é bug, é feature.
- **Hipótese**: usado para dependentes sem CPF (criança/idoso) ou registros institucionais. `VALBENEF` tem exceção explícita.
- **Risco se ignorarmos**: nenhum **se** documentado. Hoje é backdoor de cadastro fantasma sem rastreabilidade.

---

### MYS-008: Região 99 ⇒ elegibilidade automática

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/VALELEG.NSN#L102-L106`](legado-sifap/natural-programs/VALELEG.NSN)
- **Evidência inline**: `* REGIAO 99 - INTERNACIONAL/DIPLOMATICO` (alteração 05/04/2013).
- **O que o código faz**: `COD-REGIAO=99` retorna elegível direto, pulando todas as validações.
- **Risco se ignorarmos**: classe inteira de beneficiários nunca passou pela validação documental — auditoria explosiva.

---

### MYS-009: Ordem batch virou contrato implícito

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/BATCHPGT.NSN#L178-L186`](legado-sifap/natural-programs/BATCHPGT.NSN)
- **Comentário literal no código**:

```natural
* LEITURA EM ORDEM ALFABETICA POR CPF (OTIMIZACAO 1999)
* NOTA: SISTEMAS DOWNSTREAM DEPENDEM DESTA ORDENACAO
```

- **O que esperávamos**: ordenação por nome ou data, conforme manual.
- **O que o código faz**: leitura por CPF (numérico) — virou contrato com sistemas que ninguém mapeou.
- **Risco se ignorarmos**: migrar sem preservar ordem CPF quebra integrações invisíveis.

---

### MYS-010: RELAUDIT oculta ações de exclusão

- **Arquivo**: [`01-arqueologia/legado-sifap/natural-programs/RELAUDIT.NSN`](legado-sifap/natural-programs/RELAUDIT.NSN) RA-MISTERIO-01
- **O que esperávamos**: RN-011 — auditoria deve listar **todas** as ações.
- **O que o código faz**: filtra silenciosamente registros com `ACAO='EX'` antes de imprimir.
- **Risco se ignorarmos**: viola RN-011 — bandeira vermelha de compliance que pode ter resultado em multas históricas não detectadas.

---

## Easter Eggs

> Dica: existem **3 easter eggs** escondidos no código legado.

1. [x] **EGG-001 — Plano Verão**: bloco preservado em [`CALCCORR.NSN#L84-L101`](legado-sifap/natural-programs/CALCCORR.NSN). Comentário literal: `CORRECAO PLANO VERAO - PERIODO 01/1989 A 01/1991 / UTILIZADO DURANTE TRANSICAO MOEDA CRUZADO->CRUZEIRO`. Política econômica do Plano Verão (Sarney, jan/1989) preservada como código morto com fatores 2.7500 e 1.4289.
2. [x] **EGG-002 — Backdoor VALDOCS**: tabela de prefixos especiais em [`VALDOCS.NSN`](legado-sifap/natural-programs/VALDOCS.NSN) que faz dígito verificador "passar" sem cálculo real. Parece código de teste/debug que ficou em produção.
3. [x] **EGG-003 — Banco Real**: confirmado em [`BATCHCON.NSN#L203-L212`](legado-sifap/natural-programs/BATCHCON.NSN). Bloco comentado referencia integração descontinuada com Banco Real (código FEBRABAN 356), adquirido pelo Santander em 2007. Layout CNAB preservado como referência histórica conforme nota original do responsável Marcos Ribeiro (18/09/2005). Comentário literal: `* BANCO REAL FOI ADQUIRIDO PELO SANTANDER EM 2007 / * MANTER CODIGO PARA REFERENCIA HISTORICA`.

## Mistérios "extra" (27 flags de campo, fora da rubrica)

> O catálogo bruto em [`business-rules-catalog.md`](business-rules-catalog.md) tem **44** flags `<!-- mystery: -->`. Os **17 acima** mapeiam para slots oficiais. Os **27 restantes** são bandeiras legítimas que viram `[NEEDS CLARIFICATION]` no Spec-Kit do Estágio 2, mas não pontuam aqui.

| Categoria                                  | Qtd | Exemplos |
| ------------------------------------------ | --: | -------- |
| Magic numbers sem suporte legal            |   8 | Alíquotas contribuição 3/5/7/9% (CALCDSCT), tolerância 0,01 (BATCHCON), sindical 1%, idade-corte 65/60/18 |
| Códigos de status fora de domínio          |   5 | `'G'` gerado, `'S'` sênior, `'P'` ambíguo pago/pendente |
| Validações redundantes/divergentes         |   4 | CPF reimplementado em 4 programas (CADBENEF, CADDEPEND, VALBENEF, VALDOCS) com pequenas diferenças |
| Branches defensivos sem doc                |   6 | Piso de zero, idempotência mensal, deflação IPCA ignorada, etc. |
| Bugs aprovados / dependências externas     |   2 | Bug máscara CPF "não pode corrigir sem auditoria" (Par 5) |
| Decisões de UX/relatório                   |   2 | Layout mainframe BATCHREL (66 linhas/página), subtotais manuais RELPGT |

> 💡 **Por que essa distinção importa?** O agente arqueólogo é deliberadamente paranoico — flag tudo que cheira estranho. A rubrica é mais seletiva — só conta itens plantados com intenção didática. Curadoria (separar rubrica × engenharia) é o que `/catalog-mysteries` faz.

## Resumo

- **Total de mistérios encontrados:** 17 oficiais + 27 flags de campo = **44 ao todo**
- **Confiança ALTA:** 15 (todos os MYS + EGG-001/003 + INC-001/002/003/004)
- **Confiança MÉDIA:** 2 (EGG-002 backdoor VALDOCS + 1 mistério de bordo)
- **Confiança BAIXA:** 0
- **Easter eggs encontrados:** 3 / 3 ✅
- **Pontuação estimada na rubrica A1:** **32 / 32** (Excelente)

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="mysteries-checklist.md"><strong>mysteries-checklist.md</strong></a><br/>
<sub>Lista do que procurar.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="discovery-report.md"><strong>discovery-report.md</strong></a><br/>
<sub>Síntese final.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="README.md">Voltar ao Kit PT-BR</a></sub>

