# Fragmento — Par 5 (Operações): CONSBENF + RELAUDIT + RELPGT

> **Par:** 5 (Operações — DevOps + Tech Writer)
> **Escopo:** 1 consulta online (`CONSBENF`) + 2 relatórios batch (`RELAUDIT`, `RELPGT`)
> **Fontes cruzadas:** `REGRAS-NEGOCIO-2012.md`, `MANUAL-TECNICO-SIFAP-2008.md`
> **Convenção:** `[L###-###]` = intervalo de linhas no `.NSN`. Classificação: **Confirmada** (doc cita), **Inferida** (só código), **Mistério** (intenção ambígua).

---

## Regras de CONSBENF.NSN

> Tela online 3270, MAP `CONSBENF-M01`. **Busca por CPF ou NIS via `FIND` (não `READ LOGICAL`).** Histórico via `READ PAGAMENTO-V BY CPF-BENEF` (descritor `CPF-BENEF`).

| # | Declaração | EARS | Fonte | Classificação | Notas |
|---|---|---|---|---|---|
| CB-01 | Quando `#TIPO-BUSCA` vier em branco, o sistema assume `'C'` (busca por CPF). | *When* `#TIPO-BUSCA = ' '`, *the system shall* set `#TIPO-BUSCA = 'C'`. | CONSBENF.NSN [L80-82] | Inferida | Default silencioso — usuário não percebe a escolha. |
| CB-02 | O sistema deve buscar beneficiário por CPF (descritor `CPF`) **ou** NIS (descritor `NIS`) conforme `#TIPO-BUSCA`. | *When* operator submits busca, *the system shall* `FIND BENEFICIARIO WITH CPF=...` se `#TIPO-BUSCA='C'`, senão `WITH NIS=...`. | CONSBENF.NSN [L86-97] | Inferida | Usa `FIND` (não `READ LOGICAL`). Implica descritores `CPF` (PK) e `NIS` (DE) em BENEFICIARIO. |
| CB-03 | Tipo de busca diferente de `'C'` ou `'N'` deve abortar a consulta com mensagem "TIPO BUSCA INVALIDO". | *If* `#TIPO-BUSCA NOT IN ('C','N')`, *then the system shall* exibir erro e `ESCAPE ROUTINE`. | CONSBENF.NSN [L96-99] | Inferida | `NONE` do `DECIDE`. |
| CB-04 | Quando o beneficiário não for encontrado, exibir "BENEFICIARIO NAO ENCONTRADO" e abortar. | *If* `NOT #FOUND`, *then the system shall* exibir mensagem e `ESCAPE ROUTINE`. | CONSBENF.NSN [L102-105] | Inferida | — |
| CB-05 | O CPF exibido deve ser mascarado no formato `***.***.XXX-XX` (apenas dígitos 7–11 visíveis). | *When* exibe dados cadastrais, *the system shall* mascarar CPF mostrando apenas posições 7-11. | CONSBENF.NSN [L181-189] | Inferida | LGPD avant la lettre — proteção de dados sensíveis. |
| CB-06 | **BUG CONHECIDO:** quando `CPF < 10000000000` (CPF armazenado com zeros à esquerda), a máscara mostra os **3 primeiros** dígitos em vez dos últimos. **Não corrigir sem aprovação da auditoria.** | *If* `BENEFICIARIO.CPF < 10000000000`, *then the system shall* expor os 3 primeiros dígitos (comportamento conhecido). | CONSBENF.NSN [L175-180, L177-179] | **Mistério** | Comentário do código manda **não corrigir**. Por quê? Quem depende desse comportamento? Há sistema downstream que reconcilia por esse fragmento? Investigar com auditoria. |
| CB-07 | Status do beneficiário deve ser decodificado: `A→ATIVO`, `S→SUSPENSO`, `C→CANCELADO`, `I→INATIVO`, `D→DESLIGADO`. | *When* exibe status, *the system shall* mapear código → descrição conforme tabela. | CONSBENF.NSN [L107-121] | Inferida | RN-011 (REGRAS-2012) menciona `BN-CD-SIT='E'` (exclusão lógica) — **`E` não está mapeado aqui** → CB-MISTERIO-01. |
| CB-08 | O sistema deve exibir os **últimos 12 pagamentos** do beneficiário (descritor `CPF-BENEF` em PAGAMENTO). | *When* exibe histórico, *the system shall* listar no máximo 12 registros via `READ PAGAMENTO BY CPF-BENEF`. | CONSBENF.NSN [L154-170] | Inferida | Limite hard-coded `#QTD-HIST > 12 → ESCAPE BOTTOM`. |
| CB-09 | Quando o CPF do registro lido divergir do CPF buscado, encerrar leitura imediatamente. | *If* `PAGAMENTO.CPF-BENEF NE BENEFICIARIO.CPF`, *then the system shall* `ESCAPE BOTTOM`. | CONSBENF.NSN [L157-159] | Inferida | Padrão clássico de `READ LOGICAL` por descritor — sai na primeira chave diferente. |
| CB-10 | Se nenhum pagamento for encontrado, exibir "NENHUM PAGAMENTO ENCONTRADO". | *If* `#QTD-HIST = 0` after read, *the system shall* exibir mensagem. | CONSBENF.NSN [L172-174] | Inferida | — |

**Mistérios CONSBENF:**
- **CB-MISTERIO-01:** Status `'E'` (exclusão lógica, RN-011) **não aparece** no `DECIDE` de CONSBENF. Beneficiários excluídos são exibidos como "DESCONHECIDO"? Ou nunca aparecem porque a busca os filtra implicitamente? **Não há filtro de status na busca** — então um operador pode consultar um beneficiário excluído e ver "DESCONHECIDO". Investigar.
- **CB-MISTERIO-02:** Comentário [L175-180] proíbe correção do bug de máscara CPF "sem aprovação da auditoria". Sugere dependência externa não documentada.

---

## Regras de RELAUDIT.NSN

> Relatório da trilha de auditoria. Lê `AUDITORIA-V BY DT-EVENTO`. Saída tela (T) ou impressora (I). Filtros: período, ação, usuário, tabela.

| # | Declaração | EARS | Fonte | Classificação | Notas |
|---|---|---|---|---|---|
| RA-01 | Quando `#TIPO-SAIDA` vier em branco, o sistema assume `'T'` (tela). | *When* `#TIPO-SAIDA = ' '`, *the system shall* set `#TIPO-SAIDA = 'T'`. | RELAUDIT.NSN [L77-79] | Inferida | — |
| RA-02 | Quando `#DT-INI = 0`, assumir `19970101` (data de início do sistema). | *When* `#DT-INI = 0`, *the system shall* set `#DT-INI = 19970101`. | RELAUDIT.NSN [L81-83] | Inferida | **Data-mágica:** 01/01/1997 sugere data de origem do SIFAP. Confirma cabeçalho do projeto (29 anos = ~1996/1997). |
| RA-03 | Quando `#DT-FIM = 0`, assumir a data atual (`*DATN`). | *When* `#DT-FIM = 0`, *the system shall* set `#DT-FIM = #DT-HOJE`. | RELAUDIT.NSN [L84-86] | Inferida | — |
| RA-04 | A leitura deve parar imediatamente ao ultrapassar `#DT-FIM`. | *When* `AUDITORIA.DT-EVENTO > #DT-FIM`, *the system shall* `ESCAPE BOTTOM`. | RELAUDIT.NSN [L94-96] | Inferida | Padrão `READ BY DT-EVENTO`. |
| RA-05 | **REGRA CRÍTICA — EVENTOS DE EXCLUSÃO SÃO OCULTADOS DO RELATÓRIO.** Toda linha com `ACAO='EX'` é silenciosamente filtrada (contada em `#QTD-FILTRADOS`, nunca exibida). | *When* `AUDITORIA.ACAO = 'EX'`, *the system shall* incrementar `#QTD-FILTRADOS` e `ESCAPE TOP` (suprimir do relatório). | RELAUDIT.NSN [L102-108] | **Mistério** | **Conflito com RN-011** (exclusão lógica gera log de auditoria). Por que o **relatório de auditoria** oculta justamente o evento de exclusão? Bug? Feature? Compliance? Operador da auditoria pode nem saber que essas linhas existem. Comentário do código sinaliza intencionalidade ("EXCLUSOES NAO SAO EXIBIDAS"). |
| RA-06 | Filtros opcionais (`#ACAO-FILTRO`, `#USUARIO-FILTRO`, `#TABELA-FILTRO`) — em branco = todos. | *When* filtro `≠ ' '`, *the system shall* descartar registros que não casem. | RELAUDIT.NSN [L111-128] | Inferida | — |
| RA-07 | Cada ação deve ser contada e descrita: `IN→INCLUSAO`, `AL→ALTERACAO`, `CO→CONCILIACAO`, `CN→CONSULTA`, `DV→DIVERGENCIA`, outras→OUTRA. | *When* ação reconhecida, *the system shall* incrementar contador específico e mapear descrição. | RELAUDIT.NSN [L132-152] | Inferida | Note: `EX` **não está aqui** porque foi filtrado em RA-05. `CADBENEF` (manual 2008) cita LOGAUDIT — confirma origem dos eventos. |
| RA-08 | A hora deve ser formatada de `HHMMSS` para `HH:MM:SS`. | *When* exibe linha de detalhe, *the system shall* formatar `HR-EVENTO` com separadores `:`. | RELAUDIT.NSN [L155-157] | Inferida | — |
| RA-09 | A paginação deve usar 66 linhas/página, reimprimindo cabeçalho ao chegar em `#MAX-LINHAS - 5`. | *When* `#LINHA >= #MAX-LINHAS - 5`, *the system shall* `PERFORM IMPRIME-CAB-AUDIT`. | RELAUDIT.NSN [L160-163] | Inferida | Padrão mainframe: 66 linhas = formulário 11" × 6 lpi. |
| RA-10 | O cabeçalho deve repetir: título, página, período (`DT-INI` a `DT-FIM`), data corrente. | *When* nova página, *the system shall* imprimir cabeçalho completo e zerar `#LINHA = 7`. | RELAUDIT.NSN [L195-218] | Inferida | Cabeçalho difere entre tela (100 colunas) e impressora (120 colunas). |
| RA-11 | Ao final, exibir resumo com total, exibidos, filtrados, e contagem por tipo de ação. | *When* `END-READ`, *the system shall* imprimir bloco "RESUMO AUDITORIA". | RELAUDIT.NSN [L177-194] | Inferida | **Resumo expõe `#QTD-FILTRADOS`** — única pista de que existem registros ocultos (mas não diz por quê). |

**Confirmações cruzadas RELAUDIT:**
- `MANUAL-TECNICO-SIFAP-2008.md` [L191, L222]: confirma que RELAUDIT foi reestruturado na v3.0 (2005) e **não está documentado no manual de 2008** — explica por que há pouco cross-ref disponível.
- `REGRAS-NEGOCIO-2012.md` [L249]: confirma que "Regras de auditoria (RELAUDIT)" estavam **fora do escopo do levantamento de 2012** → toda regra de RELAUDIT é Inferida ou Mistério.

**Mistérios RELAUDIT:**
- **RA-MISTERIO-01 (RA-05):** Por que eventos de exclusão (`ACAO='EX'`) são suprimidos no relatório de trilha de auditoria? Quem decidiu? Quem fica sabendo? Há outro relatório que mostra `EX`?

---

## Regras de RELPGT.NSN

> Relatório analítico de pagamentos com **AT BREAK por código de programa** (subtotal). Saída exclusivamente impressora (66 linhas/página).

| # | Declaração | EARS | Fonte | Classificação | Notas |
|---|---|---|---|---|---|
| RP-01 | A leitura percorre pagamentos por `COMPETENCIA` iniciando em `#COMP-INI`. | *When* user submits filter, *the system shall* `READ PAGAMENTO BY COMPETENCIA = #COMP-INI`. | RELPGT.NSN [L86-87] | Inferida | Descritor `COMPETENCIA` em PAGAMENTO. |
| RP-02 | A leitura encerra ao ultrapassar `#COMP-FIM`. | *When* `PAGAMENTO.COMPETENCIA > #COMP-FIM`, *the system shall* `ESCAPE BOTTOM`. | RELPGT.NSN [L88-90] | Inferida | — |
| RP-03 | Filtro opcional por programa: `#COD-PROG-FILTRO = 0` significa todos. | *When* `#COD-PROG-FILTRO ≠ 0 AND PAGAMENTO.COD-PROGRAMA ≠ #COD-PROG-FILTRO`, *the system shall* `ESCAPE TOP`. | RELPGT.NSN [L92-95] | Inferida | — |
| RP-04 | **Quebra de controle (`AT BREAK`-equivalente) por `COD-PROGRAMA`.** Quando o programa mudar e não for o primeiro registro, imprimir subtotal do programa anterior e zerar acumuladores. | *When* `PAGAMENTO.COD-PROGRAMA ≠ #PROG-ANT AND #PROG-ANT ≠ 0`, *the system shall* `PERFORM IMPRIME-SUBTOTAL` e zerar `#SUB-BRUTO`, `#SUB-LIQ`, `#QTD-SUB`. | RELPGT.NSN [L98-103] | Inferida | Implementação manual de break (sem `AT BREAK` nativo). Adicionado em 2010 (cabeçalho). |
| RP-05 | Para cada pagamento, enriquecer com nome (30 caracteres) e UF do beneficiário via `FIND BENEFICIARIO WITH CPF`. | *When* monta linha de detalhe, *the system shall* `FIND BENEFICIARIO-V WITH CPF = PAGAMENTO.CPF-BENEF`. | RELPGT.NSN [L108-112] | Inferida | **Sem tratamento de "não encontrado"** — campos ficam em branco se beneficiário foi excluído. |
| RP-06 | CPF deve ser mascarado no formato `***.XXX.XXX-XX` (apenas dígito 4-11 visíveis). | *When* imprime linha, *the system shall* compor `***.<4-6>.<7-9>-<10-11>`. | RELPGT.NSN [L114-118] | Inferida | **Diferente de CONSBENF (CB-05/CB-06)** — aqui mostra dígitos 4–11; em CONSBENF mostra 7–11. Inconsistência de máscara entre programas. |
| RP-07 | Tipo de pagamento deve ser decodificado: `N→NORMAL`, `D→DECIMO`, `T→TERCEIRO`, outros→OUTRO. | *When* imprime tipo, *the system shall* mapear código → descrição. | RELPGT.NSN [L121-130] | Inferida | "DECIMO" e "TERCEIRO" coexistem → provável evolução histórica. Investigar diferença. |
| RP-08 | Status do pagamento deve ser decodificado: `G→GERADO`, `P→PAGO`, `C→CANCELAD`, `D→DEVOLVID`, `E→ESTORNAD`. | *When* imprime status, *the system shall* mapear código → descrição. | RELPGT.NSN [L133-145] | **Confirmada** | REGRAS-2012 [L218] confirma `STATUS='P'` (pendente). **Conflito:** aqui `P=PAGO`. Investigar — pode ser estado misto ou doc desatualizada. |
| RP-09 | A paginação usa 66 linhas/página; cabeçalho reimprime ao chegar em `#MAX-LINHAS - 5`. | *When* `#LINHA >= #MAX-LINHAS - 5`, *the system shall* `PERFORM IMPRIME-CABECALHO`. | RELPGT.NSN [L148-150] | Inferida | Form feed `'/'` no início do cabeçalho — padrão impressora mainframe. |
| RP-10 | Para cada registro, acumular nos totais gerais (bruto, desconto, líquido, abono, qtd). | *When* linha impressa, *the system shall* somar valores em `#TOT-*` e incrementar `#QTD-REG`. | RELPGT.NSN [L165-172] | Inferida | `VLR-ABONO` aparece **apenas** nos totais (não na linha de detalhe). |
| RP-11 | Subtotal por programa exibe: programa, qtd, bruto, líquido (sem desconto nem abono). | *When* break de programa, *the system shall* imprimir `SUBTOTAL PROGRAMA`. | RELPGT.NSN [L222-229] | Inferida | Subtotal **omite desconto e abono** — granularidade reduzida vs. total geral. |
| RP-12 | Após o `END-READ`, se houve pelo menos um programa processado, imprimir o subtotal do último programa. | *When* `#PROG-ANT ≠ 0` after read, *the system shall* `PERFORM IMPRIME-SUBTOTAL`. | RELPGT.NSN [L178-180] | Inferida | Garante último break não perdido. |
| RP-13 | O total geral final exibe: quantidade, bruto, desconto, líquido, e total de abonos em linha separada. | *When* todos os registros processados, *the system shall* imprimir bloco "TOTAL GERAL". | RELPGT.NSN [L184-189] | Inferida | — |

**Mistérios RELPGT:**
- **RP-MISTERIO-01 (RP-08):** Conflito `STATUS='P'`: doc 2012 = "pendente", código 2010 = "PAGO". Mudança de semântica? Estado migrou? Confirmar com QA + DBA.
- **RP-MISTERIO-02 (RP-07):** Diferença entre `D=DECIMO` e `T=TERCEIRO` — ambos sugerem 13º salário. São períodos diferentes (1ª/2ª parcela)? Tipos de benefício distintos?
- **RP-MISTERIO-03 (RP-05):** `FIND` sem tratamento de erro — pagamentos órfãos (beneficiário excluído) saem com nome/UF em branco silenciosamente. Pode mascarar fraude.

---

## Resumo Par 5

| Classificação | Contagem |
|---|---|
| **Confirmada** (doc cita) | 1 |
| **Inferida** (só código) | 28 |
| **Mistério** (intenção ambígua) | 5 |
| **Total de regras** | **34** |

### Por programa

| Programa | Regras | Mistérios | Tipo |
|---|---|---|---|
| CONSBENF | 10 | 2 (CB-06, CB-MISTERIO-01/02) | Consulta online |
| RELAUDIT | 11 | 1 (RA-05 / RA-MISTERIO-01) | Relatório batch |
| RELPGT   | 13 | 2 (RP-MISTERIO-01/02/03 → 3 mistérios, mas 1 regra com confirmação parcial) | Relatório batch |

### Mistérios consolidados (prioridade para handoff H1)

1. **RA-MISTERIO-01 (CRÍTICO):** RELAUDIT silenciosamente suprime `ACAO='EX'`. Conflita com RN-011 (exclusão gera log). Compliance precisa saber.
2. **RP-MISTERIO-01:** Significado de `STATUS-PGTO='P'` — doc diz "pendente", código diz "PAGO". Bloqueia desenho de máquina de estados em Estágio 2.
3. **CB-MISTERIO-01:** CONSBENF não decodifica status `'E'` (excluído). Operador vê "DESCONHECIDO".
4. **CB-06:** Bug conhecido de máscara CPF que **não pode ser corrigido sem auditoria**. Dependência externa oculta.
5. **RP-MISTERIO-03:** `FIND` órfão em RELPGT mascara pagamentos sem beneficiário.

---

## Note on CONSBENF mystery

> **Veredicto: CONSBENF É um programa isolado — confirmado.**

**Evidências (CONSBENF.NSN [L1-198]):**

1. **Nenhum `CALLNAT`** no fonte. Toda invocação externa foi verificada por leitura linha-a-linha do `DEFINE DATA` ao `END`.
2. **Único `PERFORM`** existente é interno: `PERFORM MASCARA-CPF` [L96, L141] → invoca `DEFINE SUBROUTINE MASCARA-CPF` [L182-197], também interna.
3. **Nenhum `INCLUDE`** de copycode.
4. **Acesso a dados** se dá diretamente por duas views Adabas:
   - `FIND BENEFICIARIO-V WITH CPF` (descritor primário) ou `WITH NIS` (descritor secundário) [L86-94]
   - `READ PAGAMENTO-V BY CPF-BENEF` (descritor) [L156]
5. **MAP** `CONSBENF-M01` referenciado [L73] — única dependência externa não-Natural (artefato de tela 3270).

**Implicação para o dependency-map:**

```
CONSBENF
  ├─→ MAP: CONSBENF-M01 (tela 3270)
  ├─→ DDM: BENEFICIARIO (FIND por CPF/NIS)
  └─→ DDM: PAGAMENTO (READ LOGICAL BY CPF-BENEF)
```

Sem arestas para outros `.NSN`. **O flag de "mistério isolado" do inventário se confirma**: CONSBENF é uma folha do call graph, sem dependências de subprogramas. Tecnicamente trivial de strangler-fig migrar (sem acoplamento upstream), mas funcionalmente compartilha **regras de máscara CPF** e **decode de status** com RELPGT/CADBENEF — qualquer refactor em paralelo precisa de ADR de unificação dessas decodificações.
