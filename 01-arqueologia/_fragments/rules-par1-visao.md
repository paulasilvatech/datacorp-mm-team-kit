# Fragmento — Par 1 (Visão): CADBENEF + CADDEPEND + CADPROG

> Extração de regras de negócio realizada por leitura bloco-a-bloco dos 3 programas
> Natural atribuídos ao Par 1 (Visão). Cada regra cita o programa-fonte com faixa
> de linhas e é classificada como **Confirmada** (cruza com `REGRAS-NEGOCIO-2012.md`
> ou `MANUAL-TECNICO-SIFAP-2008.md`), **Inferida** (somente do código) ou
> **Mistério** (lógica clara mas intenção/origem desconhecida).

---

## Regras de CADBENEF.NSN

| # | Declaração da Regra | Candidato EARS | Fonte | Classificação | Notas |
|---|---|---|---|---|---|
| 1 | When the operator submits a value for operation field that is neither `I` (insert) nor `A` (update), the system shall reject the record with message "OPERACAO INVALIDA - INFORME I OU A". | Unwanted | CADBENEF.NSN:L101-L105 | Inferida | Validação de entrada não citada nos docs; comportamento explícito no código. |
| 2 | When the CPF field equals zero (not informed), the system shall reject the record with message "CPF OBRIGATORIO". | Unwanted | CADBENEF.NSN:L107-L111 | Confirmada | RN-001 (`REGRAS-NEGOCIO-2012.md §1.1`) — "Todo beneficiário deve possuir CPF válido". |
| 3 | The system shall validate the CPF using the Modulo-11 check-digit algorithm (subroutine `VALIDA-CPF`); if either verifier digit (DV1 or DV2) does not match, the record shall be rejected with message "CPF INVALIDO - DIGITO VERIFICADOR INCORRETO". | Unwanted | CADBENEF.NSN:L114-L118 (rejeição) + L219-L283 (algoritmo) | Confirmada | RN-001 cita "validação por dígito verificador - subprograma VALCPF". Manual 2008 §3.2.1 também referencia VALCPF. <!-- mystery: o doc menciona um subprograma externo `VALCPF`, mas o programa lido implementa o algoritmo *inline* em `VALIDA-CPF`. Ver se `VALCPF` é uma versão antiga ou outro caminho. --> |
| 4 | When the beneficiary name field is blank, the system shall reject the record with message "NOME OBRIGATORIO". | Unwanted | CADBENEF.NSN:L120-L124 | Inferida | Obrigatoriedade do nome não consta explicitamente no levantamento 2012; comportamento direto no código. |
| 5 | When the date-of-birth field equals zero (not informed), the system shall reject the record with message "DATA NASCIMENTO OBRIGATORIA". | Unwanted | CADBENEF.NSN:L126-L130 | Confirmada | RN-006 (`REGRAS-NEGOCIO-2012.md §1.1`) — "Data de nascimento é campo obrigatório". |
| 6 | When the sex field contains any value other than `M` or `F`, the system shall reject the record with message "SEXO INVALIDO". | Unwanted | CADBENEF.NSN:L132-L136 | Inferida | Domínio binário M/F não documentado nos docs cruzados; está hard-coded no programa. |
| 7 | When operation is `I` (insert) and the CPF already exists in the BENEFICIARIO file, the system shall reject the record with message "BENEFICIARIO JA CADASTRADO". | Unwanted | CADBENEF.NSN:L145-L148 | Confirmada | RN-002 (`REGRAS-NEGOCIO-2012.md §1.1`) — "Não é permitida a inclusão de beneficiário com CPF já existente". |
| 8 | When operation is `A` (update) and no record with the given CPF is found, the system shall reject the operation with message "BENEFICIARIO NAO ENCONTRADO PARA ALTERACAO". | Unwanted | CADBENEF.NSN:L150-L153 | Inferida | Pré-condição de existência para update; não citada nos docs mas lógica esperada. |
| 9 | When operation is `I` (insert), the system shall initialise the beneficiary STATUS to `A` (active). | State-driven | CADBENEF.NSN:L162-L164 | Confirmada | RN-002/RN-011 documentam o domínio do campo BN-CD-SIT com `A` = ativo, `E` = excluído. |
| 10 | When the computed beneficiary age (current year minus year-of-birth) exceeds 75, the system shall override STATUS to `S`, regardless of the previous STATUS value. | State-driven | CADBENEF.NSN:L167-L169 (cálculo de idade em L156-L160) | Mistério | <!-- mystery: o cabeçalho registra "ALTERADO 10/01/2011 - JOSE FERREIRA - AJUSTE STATUS IDOSO" e o status `S` não consta no domínio documentado (`A`, `E`, `C`, `D`). Nenhum dos docs cruzados menciona reclassificação por idade. Pode ser uma flag de "Senior" para fluxo de pagamento diferenciado ou um bypass de auditoria. --> |
| 11 | When the age calculation uses only year-of-birth (year of current date minus year of birth) and ignores month and day, the system effectively rounds age up at year boundaries (a person born in December who turns 76 only in December is already classified `S` from 1st January). | Inferida (cálculo) | CADBENEF.NSN:L156-L160 + L167-L169 | Mistério | <!-- mystery: imprecisão de ±1 ano. Pode ser intencional (folha mensal não exige precisão de dia) ou bug. Confirmar política de aniversariantes. --> |
| 12 | Whenever any validation error flag is set during the input phase, the system shall display the error message and abort the operation via `ESCAPE ROUTINE` (no record is written). | Unwanted | CADBENEF.NSN:L171-L174 | Inferida | Padrão de controle de fluxo, não declaração de negócio dos docs. |
| 13 | When operation is `I`, the system shall write a new record into the BENEFICIARIO file (FNR 150) populated with all input fields plus `DT-CADASTRO` and `DT-ATUALIZACAO` set to today's date. | Event-driven | CADBENEF.NSN:L177-L198 (DECIDE VALUE 'I' + STORE + END TRANSACTION) | Confirmada | Manual 2008 §3.2.1 — CADBENEF "permite inclusão" em FNR 150. |
| 14 | When operation is `A`, the system shall update the matching BENEFICIARIO record with the new values; the fields CPF, DT-NASCIMENTO, SEXO, DT-CADASTRO, COD-PROGRAMA, COD-REGIAO and NIS shall NOT be overwritten by this path. | Event-driven | CADBENEF.NSN:L199-L213 (DECIDE VALUE 'A' + UPDATE) | Mistério | <!-- mystery: campos imutáveis no path 'A' não estão documentados. RN-009 menciona que alterar CPF exige "nível SUPERVISOR" e mantém o CPF antigo em `BN-NR-CPF-ANT` — esse campo nem existe no DDM lido. Lacuna entre RN-009 e implementação atual. --> |
| 15 | When operation `A` succeeds, the system shall set `DT-ATUALIZACAO` to today's date. | Event-driven | CADBENEF.NSN:L210 | Confirmada | RN-010 — "Toda alteração cadastral gera registro de auditoria automático". Embora aqui só atualize a data (não chama LOGAUDIT). <!-- mystery: docs mencionam chamada `LOGAUDIT` mas o programa lido não a executa. --> |

---

## Regras de CADDEPEND.NSN

| # | Declaração da Regra | Candidato EARS | Fonte | Classificação | Notas |
|---|---|---|---|---|---|
| 16 | When the CPF of the titular beneficiary is not found in the BENEFICIARIO file, the system shall reject the operation with message "BENEFICIARIO NAO ENCONTRADO" and shall not allow dependent registration. | Unwanted | CADDEPEND.NSN:L54-L57 | Inferida | Pré-condição esperada; docs não declaram explicitamente, mas o vínculo titular-dependente está descrito no Manual 2008 §3.2.2. |
| 17 | When the titular beneficiary has STATUS equal to `C` (cancelled) or `D` (desligado), the system shall block dependent inclusion with message "BENEFICIARIO CANCELADO/DESLIGADO - NAO PERMITE INCLUSAO". | Unwanted | CADDEPEND.NSN:L59-L62 | Mistério | <!-- mystery: os códigos `C` (cancelado) e `D` (desligado) não constam no domínio documentado de BN-CD-SIT (docs só mencionam `A`, `E`). O programa CADBENEF lido também não introduz esses códigos. Outro programa (não no escopo) deve mutá-los. Investigar origem dos status `C` e `D`. --> |
| 18 | When the titular already has more than 5 active dependents, the system shall block new inclusions with message "LIMITE DE DEPENDENTES ATINGIDO" and exit the loop. | Unwanted | CADDEPEND.NSN:L66-L69 | Confirmada (com contradição) | **CONTRADIÇÃO CRÍTICA**: RN-004 (`REGRAS-NEGOCIO-2012.md §1.1`) e Manual 2008 §3.2.1 documentam o limite como **3** dependentes. O código real impõe **5**. A nota inline em RN-004 já levanta a suspeita ("há indícios no código de que o limite foi alterado para 5"). O cabeçalho de CADDEPEND registra "ALTERADO 14/03/2008 - ROBERTO MENDES - AJUSTE PE GROUP" — provavelmente quando o limite mudou. <!-- mystery: nenhum doc oficializa a mudança 3→5. Necessário decreto/portaria de respaldo. --> |
| 19 | When the dependent name is blank, the system shall reject the dependent entry with message "NOME DO DEPENDENTE OBRIGATORIO" and re-prompt the next iteration. | Unwanted | CADDEPEND.NSN:L80-L83 | Inferida | Obrigatoriedade não declarada nos docs; explícita no código. |
| 20 | The relationship code (`PARENTESCO`) shall be one of: `FI` (filho), `CO` (cônjuge), `IR` (irmão), `OU` (outro); any other value shall be rejected with message "PARENTESCO INVALIDO". | Unwanted | CADDEPEND.NSN:L85-L89 | Inferida | Manual 2008 §3.2.2 menciona "cônjuge, filho, outro" sem citar `IR` (irmão) nem os códigos exatos. O código adiciona `IR` ao domínio documentado. |
| 21 | When two dependents would share the same non-zero CPF for the same titular, the system shall reject the new entry with message "DEPENDENTE JA CADASTRADO (CPF DUPLICADO)". | Unwanted | CADDEPEND.NSN:L97-L104 | Inferida | Anti-duplicação não declarada nos docs cruzados. |
| 22 | When the dependent CPF is zero (not informed), the duplicate-check shall be skipped (the system allows multiple dependents without CPF). | Optional / Unwanted-bypass | CADDEPEND.NSN:L99 (cláusula `AND #CPF-DEP NE 0`) | Mistério | <!-- mystery: política de aceitar dependentes sem CPF não é discutida nos docs. Pode ser intencional (crianças sem CPF) ou brecha exploitable que permite cadastrar N dependentes fantasmas zerando o CPF. --> |
| 23 | Upon successful validation, the system shall append the dependent into the periodic group `DEPENDENTES` of the titular record (index = current count + 1) and persist via `UPDATE` + `END TRANSACTION`. | Event-driven | CADDEPEND.NSN:L109-L121 | Confirmada | Manual 2008 §3.2.2 + estrutura PE no DDM confirmam o modelo de armazenamento por periodic group. |
| 24 | After each successful dependent inclusion, the system shall prompt "INCLUIR OUTRO DEPENDENTE? (S/N)" and continue the loop only if the operator answers `S`. | Event-driven | CADDEPEND.NSN:L125-L130 | Inferida | Fluxo interativo, não regra de negócio nos docs. |

---

## Regras de CADPROG.NSN

| # | Declaração da Regra | Candidato EARS | Fonte | Classificação | Notas |
|---|---|---|---|---|---|
| 25 | When the operator submits an operation value other than `I` (insert) or `C` (consult), the system shall reject with message "OPERACAO INVALIDA". | Unwanted | CADPROG.NSN:L51-L54 | Inferida | Manual 2008 §3.2.3 lista transação SF06 mas não enumera operações suportadas. |
| 26 | When the operation is `C` (consult), the system shall display the program record fields and exit; if `*NUMBER(PROGRAMA-V) = 0` (no record returned), the system shall print "PROGRAMA NAO ENCONTRADO". | Event-driven | CADPROG.NSN:L56-L59 + L100-L115 (subroutine CONSULTA-PROG) | Inferida | Fluxo de consulta; docs não descrevem em detalhe. |
| 27 | When the operation is `I` (insert) and the program code already exists in PROGRAMA-SOCIAL (FNR 151), the system shall reject with message "PROGRAMA JA CADASTRADO". | Unwanted | CADPROG.NSN:L75-L78 | Inferida | Unicidade do código de programa é esperada mas não declarada nos docs. |
| 28 | The system shall compute a "Fator K" multiplier as `FATOR-K = 1.00 + (FATOR-REAJUSTE × 0.347215)` and store the program base value as `VLR-BASE × FATOR-K`. The literal `0.347215` is a magic constant with no documentation. | Ubiquitous (calculation rule) | CADPROG.NSN:L81-L83 | Mistério | <!-- mystery: a constante `0.347215` não aparece em nenhum decreto, manual técnico ou no levantamento 2012. RN-013 e a seção 6 de `REGRAS-NEGOCIO-2012.md` listam "Fator K (multiplicador de cálculo)" como **prioridade Alta** e expressamente não-documentada ("Marcos Antônio não soube explicar"). O cabeçalho do programa registra "ALTERADO 05/07/2003 - MARCOS RIBEIRO - INC FATOR CORRECAO". --> |
| 29 | When inserting a new social program, the system shall persist the base value as the *adjusted* value (`VLR-CALC`), not the operator-entered `VLR-BASE`. The original input value is discarded. | Event-driven | CADPROG.NSN:L88 (`MOVE #VLR-CALC TO PROGRAMA-V.VLR-BASE`) | Mistério | <!-- mystery: o operador informa um valor base mas o sistema grava silenciosamente o valor já ajustado pelo Fator K. Não há tela ou log mostrando que o input foi modificado. Implica que toda re-aplicação posterior do Fator K em CALCBENF seria *dupla aplicação* — ou então CALCBENF lê este campo já ajustado. --> |
| 30 | Upon insertion, the system shall force the program status (`STATUS-PROG`) to `A` (active), regardless of input. | State-driven | CADPROG.NSN:L94 (`MOVE 'A' TO PROGRAMA-V.STATUS-PROG`) | Inferida | Estado inicial análogo ao de CADBENEF; docs não declaram explicitamente para programas. |
| 31 | The program record includes parameters `RENDA-MAX`, `IDADE-MIN`, `IDADE-MAX` that are persisted but **not validated** at insertion (no checks for negative values, IDADE-MIN > IDADE-MAX, etc.). | Inferida (ausência de regra) | CADPROG.NSN:L90-L98 | Inferida | <!-- mystery: docs descrevem essas faixas como insumo de elegibilidade (RN-015, RN-017, RN-018), mas o cadastro não impede valores incoerentes. --> |
| 32 | The `TIPO` field accepts values `A` (assistencial), `P` (previdenciário), `T` (trabalho) per the DDM comment, but no validation enforces these values at insertion. | Inferida (ausência de regra) | CADPROG.NSN:L17 (comentário DDM) + L65-L98 (sem IF de validação) | Mistério | <!-- mystery: comentário documenta domínio mas a validação não existe. Outro programa (não escopo) pode bloquear, ou tipos inválidos podem estar em produção. --> |

---

## Resumo Par 1

| Classificação | Contagem |
|---|---|
| Confirmada | 8 |
| Inferida | 14 |
| Mistério | 10 |
| **Total** | **32** |

### Mistérios prioritários a investigar no Estágio 1

1. **Status `S` para idosos > 75 anos** (CADBENEF L167-L169) — código de status não documentado; impacto provável em cálculo/elegibilidade.
2. **Status `C`/`D`** referenciados em CADDEPEND mas não introduzidos em CADBENEF (procurar produtor desses status em outros programas).
3. **Limite de dependentes 3 vs 5** — divergência confirmada entre RN-004 e código atual; requer respaldo legal.
4. **Fator K e constante `0.347215`** em CADPROG L81 — sem origem documental; provavelmente o mesmo Fator K mencionado em RN-013 como prioridade Alta.
5. **VLR-BASE gravado já ajustado** (CADPROG L88) — risco de dupla aplicação do Fator K no CALCBENF.
6. **CPF de dependente zero permitido** (CADDEPEND L99) — possível brecha de cadastro fantasma.
7. **Discrepância DDM**: o programa lido define o PE Group inline em CADDEPEND e referencia campos como `BENEFICIARIO-V.CPF-DEP(#IDX)`; confirmar contra o DDM real (`adabas-ddms/BENEFICIARIO.ddm`).
8. **Ausência da chamada `LOGAUDIT`** em CADBENEF apesar de RN-010 prescrever auditoria automática.
9. **Cálculo de idade somente por ano** (CADBENEF) — desvio de ±1 ano potencialmente intencional.
10. **`VALCPF` no doc vs `VALIDA-CPF` inline no código** — inconsistência de nome/escopo do subprograma.
