# Fragmento — Par 2 (Arquitetura): BATCHCON + BATCHPGT + BATCHREL

> Extração linha-a-linha de regras de negócio a partir de blocos `IF / DECIDE / AT BREAK / END-FIND`.
> Fonte: programas Natural em `01-arqueologia/legado-sifap/natural-programs/`.
> Cross-ref: `legacy-docs/REGRAS-NEGOCIO-2012.md`, `MANUAL-TECNICO-SIFAP-2008.md`.

---

## Regras de BATCHCON.NSN

Programa de conciliação de pagamentos vs. arquivo de retorno bancário CNAB 240 (Banco do Brasil). 246 linhas.

| # | Declaração | Candidato EARS | Fonte | Classificação | Notas |
|---|------------|----------------|-------|---------------|-------|
| BC-01 | Quando o registro CNAB lido não é do tipo `'3'` (detalhe), o sistema deve ignorá-lo (`ESCAPE TOP`). | Unwanted | BATCHCON.NSN L108–L110 (`IF #CNAB-TIPO-REG NE '3'`) | Inferida | Layout CNAB 240 padrão FEBRABAN; somente registros tipo 3 carregam dados de pagamento. <!-- mystery: outros tipos (header 0, lote 1, trailer 5/9) não são contabilizados — possível lacuna de auditoria --> |
| BC-02 | Quando há `PAGAMENTO` com `NUM-PAGTO` igual ao documento do CNAB **E** `CPF-BENEF` igual ao CPF do CNAB **E** `COMPETENCIA` igual à competência do batch, o sistema deve marcar o registro como encontrado. | Event-driven | BATCHCON.NSN L130–L135 (`FIND PAGAMENTO-V ... IF CPF-BENEF = #CPF-NUM AND COMPETENCIA = #COMPETENCIA`) | Inferida | Chave de match é tripla (documento + CPF + competência), não só `NUM-PAGTO`. |
| BC-03 | Quando o pagamento do CNAB **não** é encontrado na base SIFAP, o sistema deve incrementar `#QTD-NAO-ENCONTRADOS`, registrar mensagem `'NAO ENCONTRADO'` e pular para o próximo registro. | Unwanted | BATCHCON.NSN L137–L143 (`IF NOT #FOUND ... ESCAPE TOP`) | Inferida | Não há tratamento de re-tentativa nem fila de exceção. |
| BC-04 | Quando a diferença absoluta entre `VLR-LIQUIDO` SIFAP e valor do banco excede R$ 0,01, o sistema deve classificar como **divergência**, gravar mensagem e registrar auditoria de divergência. | Unwanted | BATCHCON.NSN L146–L157 (`IF #DIFF > 0.01`) | Inferida | Tolerância de 1 centavo é numérica explícita. <!-- mystery: justificativa da tolerância de 0,01 não documentada; pode estar relacionada ao truncamento de centavos de RN-014 --> |
| BC-05 | Quando o pagamento concilia (diferença ≤ R$ 0,01) **e** o código de retorno bancário é `'00'`, o sistema deve marcar `STATUS-PGTO = 'P'` (Pago), gravar `DT-PAGAMENTO` e `COD-BANCO = 1`. | Event-driven | BATCHCON.NSN L160–L168 (`DECIDE ON FIRST VALUE OF #COD-RET VALUE '00'`) | Confirmada | `REGRAS-NEGOCIO-2012.md` seção 5.1 lista status do DDM PAGAMENTO; `MANUAL-TECNICO-SIFAP-2008.md` L214 cita BATCHPGT como folha mensal e implícito o retorno em BATCHCON. `COD-BANCO = 1` é hardcoded para BB. |
| BC-06 | Quando o pagamento concilia **e** o código de retorno é `'01'`, o sistema deve marcar `STATUS-PGTO = 'D'` (Devolvido). | Event-driven | BATCHCON.NSN L169–L175 | Inferida | Status `'D'` aparece em `BATCHREL.NSN` como "DEVOLVIDO". |
| BC-07 | Quando o pagamento concilia **e** o código de retorno é `'02'`, o sistema deve marcar `STATUS-PGTO = 'E'` (Estornado). | Event-driven | BATCHCON.NSN L176–L182 | Inferida | Status `'E'` aparece em `BATCHREL.NSN` como "ESTORNADO". |
| BC-08 | Quando o código de retorno bancário é diferente de `'00'`, `'01'` e `'02'` (cláusula `NONE`), o sistema deve registrar mensagem `'COD RETORNO DESCONHECIDO'` mas **não** atualiza o pagamento. | Unwanted | BATCHCON.NSN L183–L186 (`NONE` do `DECIDE`) | Inferida | <!-- mystery: o pagamento permanece em estado anterior sem reprocessamento; possível regra ausente para códigos `03..99` do CNAB 240 --> |
| BC-09 | O sistema deve incrementar sequencialmente o número de auditoria (`SEQ-AUDIT`) a partir do último valor existente no DDM AUDITORIA. | Ubiquitous | BATCHCON.NSN L82–L86 (`READ AUDITORIA-V BY SEQ-AUDIT DESCENDING ... ESCAPE BOTTOM`) | Confirmada | `REGRAS-NEGOCIO-2012.md` RN-010 ("auditoria automática"). |
| BC-10 | Quando ocorre conciliação OK, o sistema deve gravar registro de auditoria com `ACAO = 'CO'` (conciliado). | Event-driven | BATCHCON.NSN L191 + L200–L213 (`PERFORM GRAVA-AUDITORIA-CONC`) | Inferida | Códigos de ação `'CO'` / `'DV'` não estão na documentação RN-2012. |
| BC-11 | Quando ocorre divergência de valor, o sistema deve gravar registro de auditoria com `ACAO = 'DV'`, preservando valor SIFAP em `VLR-ANTERIOR` e valor banco em `VLR-NOVO`. | Event-driven | BATCHCON.NSN L153 + L215–L233 (`PERFORM GRAVA-AUDITORIA-DIVERG`) | Inferida | Captura para auditoria fiscal. |
| BC-12 | O bloco de integração com Banco Real está comentado e deve ser tratado como código morto (`* DEFINE WORK FILE 2 'RETORNO_REAL.DAT' ...`). | n/a (decisão de arquitetura) | BATCHCON.NSN L195–L213 (comentado) | Confirmada | Comentário do próprio código: "BANCO REAL FOI ADQUIRIDO PELO SANTANDER EM 2007". <!-- mystery: layout Banco Real (CPF posição 30-43, valor 100-112) difere do BB e não está documentado em lugar algum vivo --> |

---

## Regras de BATCHPGT.NSN

Programa **crítico** de geração mensal de pagamentos. 377 linhas. Executado no 1º dia útil.

| # | Declaração | Candidato EARS | Fonte | Classificação | Notas |
|---|------------|----------------|-------|---------------|-------|
| BP-01 | A competência do batch é calculada a partir de `*DATN` como `(ANO * 100) + MES`. | Ubiquitous | BATCHPGT.NSN L122–L125 | Confirmada | `REGRAS-NEGOCIO-2012.md` seção 5.1 cita execução mensal. |
| BP-02 | Quando o `CPF` lido é igual ao CPF anterior (`#CPF-ANT`), o sistema deve ignorar o registro como duplicata. | Unwanted | BATCHPGT.NSN L189–L194 (`IF BENEFICIARIO-V.CPF = #CPF-ANT`) | Inferida | Defesa contra registros duplicados no DDM BENEFICIARIO; depende da ordenação `BY CPF`. |
| BP-03 | Quando o `STATUS` do beneficiário é diferente de `'A'` (ativo), o sistema deve ignorá-lo. | Unwanted | BATCHPGT.NSN L197–L200 (`IF BENEFICIARIO-V.STATUS NE 'A'`) | Confirmada | `REGRAS-NEGOCIO-2012.md` RN-011 + seção 5.1: "Todos os beneficiários ativos (BN-CD-SIT = 'A') são processados". |
| BP-04 | Quando já existe pagamento do beneficiário na competência atual, o sistema deve ignorá-lo (idempotência mensal). | Unwanted | BATCHPGT.NSN L202–L210 (`FIND PAGAMENTO-V ... IF COMPETENCIA = #COMPETENCIA`) | Inferida | Garante reprocessamento seguro. Não documentado explicitamente em RN-2012. |
| BP-05 | Quando o programa social referenciado pelo beneficiário não existe, o sistema deve registrar erro e ignorar. | Unwanted | BATCHPGT.NSN L213–L226 (`IF NOT #FOUND-P`) | Confirmada | RN-003: "vínculo obrigatório com programa social ativo". |
| BP-06 | Quando o `STATUS-PROG` do programa social é diferente de `'A'`, o sistema deve ignorar o beneficiário. | Unwanted | BATCHPGT.NSN L227–L230 (`IF PROGRAMA-V.STATUS-PROG NE 'A'`) | Confirmada | RN-003 (programa social ativo). |
| BP-07 | Quando o código de região está entre 1 e 25, o fator regional vem da tabela `#TAB-REG`; caso contrário, o fator regional é `1.0000`. | State-driven | BATCHPGT.NSN L240–L244 (`IF #COD-REG >= 1 AND #COD-REG <= 25`) | Inferida | <!-- mystery: a tabela tem 27 posições mas o `IF` só usa 1–25; valores 26 e 27 (carregados como 1.0000) são código morto. Provável bug ou refactor incompleto --> |
| BP-08 | Quando há 0 dependentes, fator familiar = `1.0000`. | State-driven | BATCHPGT.NSN L247–L248 | Inferida | Cálculo escalonado por faixa de dependentes. |
| BP-09 | Quando há 1 ou 2 dependentes, fator familiar = `1.0 + (NUM-DEP × 0.05)`. | State-driven | BATCHPGT.NSN L249–L251 | Inferida | Acréscimo 5% por dependente até 2. |
| BP-10 | Quando há 3 ou 4 dependentes, fator familiar = `1.10 + ((NUM-DEP - 2) × 0.03)`. | State-driven | BATCHPGT.NSN L252–L253 | Inferida | Acréscimo 3% por dependente adicional na faixa 3–4. |
| BP-11 | Quando há 5 ou mais dependentes, fator familiar = `1.16 + ((NUM-DEP - 4) × 0.02)`. | State-driven | BATCHPGT.NSN L254–L256 | Inferida | Acréscimo 2% por dependente acima de 4. <!-- mystery: RN-004 do documento de 2012 afirma "máximo 3 dependentes" mas o código processa 4, 5+ dependentes — confirmação de que limite foi alterado e doc não foi atualizado --> |
| BP-12 | Quando idade ≥ 65, fator idade = `1.15`. | State-driven | BATCHPGT.NSN L263–L264 | Inferida | Bonificação idoso. |
| BP-13 | Quando idade está entre 60 e 64, fator idade = `1.10`. | State-driven | BATCHPGT.NSN L265–L267 | Inferida | Bonificação pré-idoso. |
| BP-14 | Quando idade < 18, fator idade = `1.05`. | State-driven | BATCHPGT.NSN L268–L270 | Inferida | Bonificação menor de idade. |
| BP-15 | Quando idade está entre 18 e 59, fator idade = `1.00`. | State-driven | BATCHPGT.NSN L271–L272 (else branch) | Inferida | Caso base. |
| BP-16 | O valor bruto base é `#VLR-BASE × #FATOR-REG × #FATOR-FAM × #FATOR-RND × #FATOR-IDADE × (1 + #FATOR-REAJ)`. | Ubiquitous | BATCHPGT.NSN L278–L280 | Confirmada (parcial) | RN-013 documenta fórmula simplificada `VALOR-BASE + (ACRESCIMO * QT-DEPEND)` — **divergente** do código. RN-2012 admite "fórmula básica" e cita "FATOR-K não explicado". <!-- mystery: o "FATOR-K" mencionado em RN-2012 nota L130 corresponde ao produto `FATOR-REG × FATOR-FAM × FATOR-RND × FATOR-IDADE`? --> |
| BP-17 | O valor calculado é truncado em centavos (`#VLR-TEMP = VLR × 100; VLR = #VLR-TEMP / 100`). | Ubiquitous | BATCHPGT.NSN L282–L284 | Confirmada | RN-014: "arredondamento para baixo (truncamento)". |
| BP-18 | Quando o mês é dezembro (`#MES = 12`), o sistema deve marcar `TIPO-PGTO = 'D'` e calcular 13º salário = `VLR-BASE × FATOR-REG × FATOR-IDADE`. | Event-driven | BATCHPGT.NSN L290–L296 (`IF #MES = 12`) | Inferida | RN-2012 seção 6 lista "Cálculo do 13o benefício" como **PENDENTE não documentado**. Esta é regra escondida descoberta no código. <!-- mystery: 13º não usa `FATOR-FAM` nem `FATOR-RND` (diferente do valor bruto mensal). Intencional? --> |
| BP-19 | Quando o mês é dezembro **e** `TIPO` do programa é `'A'` (abono), o sistema deve adicionar abono = `VLR-BENF × 0.15` (15% do valor mensal). | Event-driven | BATCHPGT.NSN L297–L302 (`IF #TIPO-PROG = 'A'`) | Inferida | <!-- mystery: o que significa `TIPO = 'A'` no DDM PROGRAMA-SOCIAL? Documentação não lista enumeração dos tipos. Provável "Abono natalino" mencionado em RN-2012 --> |
| BP-20 | Quando o valor bruto excede R$ 500,00, o sistema deve aplicar desconto de 3%; senão, desconto = 0. | Event-driven | BATCHPGT.NSN L313–L317 (`IF #VLR-BRUTO > 500.00`) | Inferida (conflitante) | **Conflito com RN-021**: documento de 2012 afirma "limite 30% do valor bruto" e cita programa `CALCDSCT` separado, mas este batch aplica simplificadamente 3% inline. <!-- mystery: BATCHPGT chama CALCDSCT? O cabeçalho menciona "CHAMA CALCBENF E CALCDSCT" (L11) mas o código fonte NÃO contém `CALLNAT` — comentário obsoleto OU lógica foi inline --> |
| BP-21 | Quando `VLR-LIQUIDO < 0`, o sistema deve forçá-lo a 0 (piso de zero). | Unwanted | BATCHPGT.NSN L321–L323 (`IF #VLR-LIQ < 0`) | Inferida | Defesa numérica. Não documentado. |
| BP-22 | Para cada 1000 pagamentos gerados, o sistema deve emitir log de progresso. | Ubiquitous (monitoria) | BATCHPGT.NSN L342–L344 (`IF #QTD-GERADOS MOD 1000 = 0`) | Inferida | Mecanismo operacional, não regra de negócio fiscal. |
| BP-23 | Cada pagamento gerado nasce com `STATUS-PGTO = 'G'` (Gerado). | Ubiquitous | BATCHPGT.NSN L332 (`MOVE 'G' TO PAGAMENTO-V.STATUS-PGTO`) | Confirmada | Implícito em RN-2012 seção 5.1; status `'P'` (pendente) mencionado no doc difere do código (`'G'` no código). <!-- mystery: RN-2012 diz "status 'P' (pendente)" mas o código grava `'G'`. Provável que doc esteja errado --> |
| BP-24 | A leitura ocorre **em ordem alfabética de CPF** (`READ BENEFICIARIO-V BY CPF`). Sistemas downstream dependem desta ordenação. | Ubiquitous | BATCHPGT.NSN L181–L186 (comentário + `READ ... BY CPF`) | Confirmada (parcial) | RN-2012 seção 5.1 nota fala em ordenação por **nome** (BN-NM-BENEF) e sugere que mudar a ordem "causaria divergências nos totalizadores". **Conflito**: código usa CPF, doc fala nome. <!-- mystery: divergência fundamental entre código (CPF) e doc (nome). Investigar versão atual em produção --> |

### Sub-rotina DET-FAIXA-RENDA-BATCH

| # | Declaração | Candidato EARS | Fonte | Classificação | Notas |
|---|------------|----------------|-------|---------------|-------|
| BP-25 | Para determinar o fator renda, o sistema deve percorrer as 5 faixas em ordem crescente e aplicar o fator da **primeira faixa** cujo limite superior seja ≥ renda declarada. | Ubiquitous | BATCHPGT.NSN L367–L373 (`FOR ... IF #RENDA <= #FAIXA-RENDA(#J) ... ESCAPE BOTTOM`) | Confirmada | RN-018 descreve exatamente este padrão. Faixas hardcoded: 300 / 600 / 1000 / 1500 / 9999,99 com fatores 1,00 / 0,85 / 0,70 / 0,55 / 0,40. |

---

## Regras de BATCHREL.NSN

Geração de relatórios consolidados mensais (por região, status e total). 198 linhas.

| # | Declaração | Candidato EARS | Fonte | Classificação | Notas |
|---|------------|----------------|-------|---------------|-------|
| BR-01 | Quando a competência do pagamento lido difere da competência solicitada, o sistema deve encerrar a leitura (`ESCAPE BOTTOM`). | State-driven | BATCHREL.NSN L92–L94 (`IF PAGAMENTO-V.COMPETENCIA NE #COMPETENCIA`) | Inferida | Otimização de leitura sequencial via descritor `COMPETENCIA`. |
| BR-02 | Quando `COD-REGIAO` está entre 1 e 5, agrupar em índice 1 (NORTE); 6–10 → 2 (NORDESTE); 11–15 → 3 (SUDESTE); 16–20 → 4 (SUL); demais (incluindo 21–27 e 99) → 5 (CENTRO-OESTE). | State-driven | BATCHREL.NSN L104–L118 (`IF #COD-REG >= 1 AND #COD-REG <= 5 ...`) | Inferida (parcial / conflitante) | **Conflito**: RN-005 documenta 27 valores (UFs); este relatório agrupa em 5 regiões geográficas mas o mapeamento "código regional → região geográfica" não consta em nenhuma documentação. <!-- mystery: o agrupamento "21–27 → CENTRO-OESTE" é provavelmente bug — Centro-Oeste do Brasil tem só 4 UFs. Catch-all `else` engole o "bypass região 99" mencionado em RN-005 e na nota de RN-2012 L198 --> |
| BR-03 | Para cada pagamento, o sistema deve arredondar o valor bruto somando 0,005 antes do truncamento (`#VLR-ARR = VLR-BRUTO + 0.005; trunc cent.`). | Ubiquitous | BATCHREL.NSN L122–L125 + comentário L121 | Inferida (conflitante) | **Conflito**: comentário no código L121 diz "ARREDONDAMENTO DIFERE DO CALCBENF (ROUND VS TRUNCATE)". Relatório arredonda matematicamente; cálculo (`BATCHPGT` BP-17) trunca. Totais do relatório podem **não bater** com soma exata dos pagamentos. <!-- mystery: divergência reconhecida pelo autor, mas nunca corrigida. Impacto fiscal? --> |
| BR-04 | Quando `STATUS-PGTO = 'G'`, classificar em índice 1 (GERADO). | State-driven | BATCHREL.NSN L133–L134 (`DECIDE ON FIRST VALUE`) | Confirmada | Status `'G'` confirmado em BP-23. |
| BR-05 | Quando `STATUS-PGTO = 'P'`, classificar em índice 2 (PAGO). | State-driven | BATCHREL.NSN L135–L136 | Confirmada | Status `'P'` confirmado em BC-05. |
| BR-06 | Quando `STATUS-PGTO = 'C'`, classificar em índice 3 (CANCELADO). | State-driven | BATCHREL.NSN L137–L138 | Inferida | <!-- mystery: status `'C'` (CANCELADO) não é atribuído em BATCHCON nem BATCHPGT. Que programa cria esse status? --> |
| BR-07 | Quando `STATUS-PGTO = 'D'`, classificar em índice 4 (DEVOLVIDO). | State-driven | BATCHREL.NSN L139–L140 | Confirmada | Status `'D'` confirmado em BC-06. |
| BR-08 | Quando `STATUS-PGTO = 'E'`, classificar em índice 5 (ESTORNADO). | State-driven | BATCHREL.NSN L141–L142 | Confirmada | Status `'E'` confirmado em BC-07. |
| BR-09 | Quando `STATUS-PGTO` é diferente de `'G' / 'P' / 'C' / 'D' / 'E'` (cláusula `NONE`), o pagamento é classificado em GERADO por default. | Unwanted | BATCHREL.NSN L143–L144 (`NONE MOVE 1 TO #IDX-STS`) | Inferida | Comportamento defensivo silencioso — pagamentos com status inesperado **inflacionam contagem de GERADO**. <!-- mystery: regra silenciosamente errada — mascara dados corrompidos --> |
| BR-10 | O relatório usa formato de impressora mainframe com `#MAX-LINHAS = 66` por página e form feed entre páginas. | Ubiquitous | BATCHREL.NSN L75–L77 + L185–L191 | Inferida | Padrão de impressora de linha de 132 colunas. Decisão de arquitetura de saída. |

### Sub-rotina IMPRIME-CABECALHO

| # | Declaração | Candidato EARS | Fonte | Classificação | Notas |
|---|------------|----------------|-------|---------------|-------|
| BR-11 | A cada chamada de `IMPRIME-CABECALHO`, o sistema deve incrementar `#PAG` e reiniciar contador de linha. | Ubiquitous | BATCHREL.NSN L185–L191 | Inferida | Paginação. |

---

## Resumo Par 2

| Classificação  | Contagem |
|----------------|---------:|
| Confirmada     |        9 |
| Confirmada (parcial / conflitante) |        4 |
| Inferida       |       23 |
| Inferida (conflitante) |        3 |
| Mistérios marcados (`<!-- mystery: ... -->`) |       12 |
| **Total de regras**                          |   **47** |

### Mistérios mais críticos para o Par 1 (Visão) priorizar

1. **BP-16 / "FATOR-K"** — fórmula real diverge radicalmente do que `REGRAS-NEGOCIO-2012.md` RN-013 documenta. Impacto fiscal direto.
2. **BP-24** — código ordena por **CPF**, doc afirma ordem por **nome**. Sistemas downstream dependem da ordem (mas qual?).
3. **BP-23** — status inicial: código grava `'G'`, doc fala `'P'`. Qual é a verdade?
4. **BR-02** — agrupamento de regiões 21–27 em "Centro-Oeste" parece bug; engole bypass região 99.
5. **BR-03** — relatório arredonda, batch trunca → totais não batem. Reconhecido pelo autor, nunca corrigido.
6. **BP-20** — desconto de 3% inline em BATCHPGT versus regra de 30% do `CALCDSCT` (RN-021). O `CALCDSCT` ainda é chamado?
7. **BR-06** — quem cria status `'C'` (CANCELADO)? Nenhum dos três batches faz isso.
8. **BC-08 / BR-09** — cláusulas `NONE` silenciam erros (códigos de retorno desconhecidos, status inesperados). Risco de auditoria.

> Próximo passo (Estágio 2): cada mistério acima deveria virar item em `mysteries-found.md` e ser endereçado por ADR ou requisito EARS explícito antes de ser reimplementado.
