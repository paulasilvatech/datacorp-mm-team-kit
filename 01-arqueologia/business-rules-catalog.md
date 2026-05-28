<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD033 MD034 MD040 MD051 MD060 -->

# Catálogo de Regras de Negócio — SIFAP Legado

> **Estágio 1 · `/extract-business-rules`** · gerado em 2026-05-27
>
> **Modo de consolidação:** este catálogo é um **índice consolidado**. As
> tabelas detalhadas (187 regras com fonte `arquivo.NSN:Lstart-Lend`,
> classificação EARS e notas) vivem nos 5 fragments em
> [`_fragments/`](_fragments/), um por par. Não duplicamos as linhas aqui
> para manter rastreabilidade única.

---

## Resumo Geral

| Métrica | Valor |
| --- | ---: |
| Programas Natural lidos | 15 |
| DDMs cruzados | 4 |
| **Regras extraídas** | **187** |
| Confirmadas (cruzaram com docs) | 43 |
| Inferidas (só código, sem doc) | 104 |
| **Mistérios** (`<!-- mystery: -->`) | **44** |
| Divergências críticas doc × código | 9 |

> ⚠️ **Razão Inferida/Confirmada ≈ 2.4×**: a documentação histórica
> (1997/2008/2012) cobre menos de metade da lógica real. O Estágio 2 precisa
> tratar regras Inferidas como **candidatas a entrevista** com PO/SME, não
> como verdade pronta.

## Fragmentos por Par

| Par                    | Programas                        | Arquivo                                                                  | Regras | Mistérios |
| ---------------------- | -------------------------------- | ------------------------------------------------------------------------ | -----: | --------: |
| 1 · Visão              | CADBENEF, CADDEPEND, CADPROG     | [`_fragments/rules-par1-visao.md`](_fragments/rules-par1-visao.md)                 |     32 |        10 |
| 2 · Arquitetura        | BATCHCON, BATCHPGT, BATCHREL     | [`_fragments/rules-par2-arquitetura.md`](_fragments/rules-par2-arquitetura.md)     |     47 |        12 |
| 3 · Implementação      | CALCBENF, CALCCORR, CALCDSCT     | [`_fragments/rules-par3-implementacao.md`](_fragments/rules-par3-implementacao.md) |     44 |        11 |
| 4 · Qualidade          | VALBENEF, VALDOCS, VALELEG       | [`_fragments/rules-par4-qualidade.md`](_fragments/rules-par4-qualidade.md)         |     30 |         6 |
| 5 · Operações          | CONSBENF, RELAUDIT, RELPGT       | [`_fragments/rules-par5-operacoes.md`](_fragments/rules-par5-operacoes.md)         |     34 |         5 |

---

## Divergências Cross-Cutting (bloqueadores para o Estágio 2)

Estas são divergências **entre dois ou mais artefatos** (código × doc, ou
código × código entre programas). Precisam de decisão do PO + RE no
Passagem #1 antes de virar EARS.

| # | Tema                                                  | Conflito                                                                                                     | Onde aparece                                                                  |
| - | ----------------------------------------------------- | ------------------------------------------------------------------------------------------------------------ | ----------------------------------------------------------------------------- |
| 1 | **Limite de dependentes**                             | RN-004 diz **3**; `CADDEPEND.NSN:L66-L69` aceita **5**; `CALCBENF` aceita **>3**                             | Pares 1 e 3                                                                   |
| 2 | **Fórmula do benefício (Fator Familiar)**             | `REGRAS-NEGOCIO-2012.md` §6 = aditiva; `CALCBENF.NSN` = multiplicativa                                       | Par 3 (BR-CBENF-007/011)                                                      |
| 3 | **Significado de STATUS-PGTO = `P`**                  | Doc 2012 = "pendente"; Manual 2008 = "PAGO"; código de `RELPGT` trata como pago                              | Pares 3 e 5                                                                   |
| 4 | **Arredondamento × truncamento**                      | Manual 2008 §4 = arredonda 5 casas; `BATCHPGT` trunca                                                        | Par 2 (BR-03)                                                                 |
| 5 | **Fator K = 0.347215**                                | Constante mágica em `CADPROG.NSN:L81` sem fonte legal/regulatória                                            | Pares 1 e 2 (também em BP-16)                                                 |
| 6 | **Desconto 3% × 30%**                                 | Doc cita 3%; `BATCHCON` aplica 30%                                                                           | Par 2 (BP-20)                                                                 |
| 7 | **Validação de CPF duplicada em 4 lugares**           | `CADBENEF`, `CADDEPEND`, `VALBENEF`, `VALDOCS` reimplementam DV com pequenas variações                       | Mapa de dependências §Obs.                                                    |
| 8 | **`RELAUDIT` oculta ACAO='EX'**                       | Conflita com RN-011 (auditoria deve ser completa); compliance flag                                           | Par 5 (RA-MISTERIO-01)                                                        |
| 9 | **Cap de desconto agregado**                          | `CALCDSCT` aplica cap; RN-023 manda descartar por prioridade                                                 | Par 3 (BR-CDSCT-013)                                                          |

---

## Mistérios Prioritários (sobem para `mysteries-found.md`)

Top 10 por impacto, extraídos dos 44 mistérios distribuídos nos fragments:

1. **Fator K = 0.347215** sem origem documentada — afeta benefícios e cálculo de pagamento (Par 1 + 2)
2. **Tabela de 25 fatores regionais 1.0000–1.4000** sem critério legal (Par 3)
3. **Faixas de renda hardcoded** (R$ 300/600/1000/1500) sem indexação desde 2013 (Par 3)
4. **Bloco "Plano Verão" comentado** preservado no fonte com fatores 2.7500 e 1.4289 (Par 3)
5. **Status `S` para idade > 75** fora do domínio documentado `A/E` (Par 1)
6. **CPF `00000000000` aceito** em CADDEPEND e por exceção em VALBENEF (Par 1 + 4)
7. **Região 99 ⇒ elegibilidade automática** — backdoor em VALELEG (Par 4)
8. **Tabela de prefixos especiais** em VALDOCS que anula erros de DV (Par 4)
9. **RELAUDIT oculta exclusões** — viola requisito de auditoria completa (Par 5)
10. **Tabela IPCA estática 2010–2012** — fora dessa janela correção é silenciosamente ignorada (Par 3)

A lista completa está em [`mysteries-found.md`](mysteries-found.md).

---

## Como os 44 Mistérios se Conectam às Regras de Negócio

Os 44 flags **não são 44 regras novas separadas**. Eles são anotações de risco,
incerteza ou divergência sobre regras já extraídas nos fragments. A leitura correta é:

Uma regra de negócio extraída carrega quatro camadas de informação:

- comportamento observado no código legado;
- fonte Natural/DDM com linha;
- classificação: Confirmada / Inferida / Mistério;
- quando houver mistério, decisão necessária antes do EARS moderno.

Exemplo prático:

| Regra no catálogo | Mistério ligado | Como vira requisito moderno |
| --- | --- | --- |
| `CADDEPEND` bloqueia inclusão acima de 5 dependentes | Doc diz 3 e DDM permite 10 | EARS deve declarar o limite escolhido e citar as três fontes em `source_legacy:` |
| `BATCHPGT` calcula pagamento mensal com fatores | Fórmula real diverge da doc | EARS preserva fórmula real ou marca `[NEEDS CLARIFICATION]` para decisão do PO |
| `RELAUDIT` lista eventos de auditoria | `ACAO='EX'` é ocultada | EARS/ADR de auditoria decide se o moderno preserva, corrige ou expõe exclusões |

Portanto, o lugar certo para os 44 pontos neste catálogo é uma **matriz de rastreio**:
ela aponta qual regra original recebeu o flag, qual decisão precisa ser tomada e qual
artefato do Estágio 2 deve absorver o tema.

### Matriz de Rastreio dos 44 Flags

| Programa | Regra(s) conectada(s) | Quantidade | Tipo de conexão com negócio | Onde detalhar / resolver |
| --- | --- | ---: | --- | --- |
| CADBENEF | Regras 3, 10, 11, 14, 15 | 5 | CPF, status por idade, imutabilidade cadastral e auditoria | `mysteries-raw-44-analysis.md` §1; EARS de cadastro; ADR de auditoria |
| CADDEPEND | Regras 17, 18, 22 | 3 | Estado do titular, limite de dependentes, CPF ausente | §2; EARS de dependentes; decisão PO sobre limite |
| CADPROG | Regras 28, 29, 31, 32, 30 | 5 | Fator K, valor base ajustado, parâmetros sem validação, tipo/status de programa | §3; ADR de parametrização; EARS de programa social |
| BATCHCON | BC-01, BC-04, BC-08, BC-12 | 4 | Conciliação CNAB, tolerância, retorno desconhecido, banco extinto | §4; ADR de integração bancária; testes de conciliação |
| BATCHPGT | BP-07, BP-11, BP-16, BP-18, BP-19, BP-20, BP-23, BP-24 | 8 | Motor de pagamento, dezembro, desconto, status e contrato downstream | §5; EARS de cálculo; golden master; ADR de contrato batch |
| BATCHREL | BR-02, BR-03, BR-06, BR-09 | 4 | Agrupamento regional, rounding, status cancelado e default silencioso | §6; EARS de relatório; ADR de status |
| CALCBENF | BR-CBENF-006, 007, 010, 011, 014/015 | 5 | Fatores regionais/familiares/renda, fórmula real, 13º e abono | §7; EARS de cálculo; testes parametrizados |
| CALCCORR | BR-CCORR-007, 009, 010, 008 | 4 | Deflação ignorada, IPCA estático, Plano Verão, lacuna de índice | §8; ADR histórico; tabela de índices versionada |
| CALCDSCT | BR-CDSCT-004, 010, 013 | 3 | Alíquotas, desconto sindical, cap agregado | §9; EARS de descontos; decisão jurídico/PO |
| VALBENEF | Regras 3, 5, 8 | 3 | CPF especial, data bissexta, domínio de status | §10; testes de validação; ADR de status |
| VALDOCS | Regras 12, 13 | 2 | Prefixos especiais e documentos coletados sem validação | §11; EARS de documentação; decisão de segurança |
| VALELEG | Regras 17, 24, 28 | 3 | Região 99, renda hardcoded, tipo de programa desconhecido | §12; EARS de elegibilidade; parametrização |
| CONSBENF | CB-06, CB-MISTERIO-01 | 2 | Máscara CPF compatível e status excluído sem decode | §13; ADR de privacidade; testes de UI/consulta |
| RELAUDIT | RA-05 | 1 | Exclusões omitidas do relatório de auditoria | §14; ADR de compliance; requisito de auditoria completa |
| RELPGT | RP-08, RP-07 | 2 | Status `P` ambíguo e tipo de pagamento `D/T` | §15; ADR de máquina de estados; enum moderno |
| **Total** | **Todas as regras acima** | **44** | **Curadoria para EARS/ADR** | **Passagem para Estágio 2** |

### Regra prática para o Estágio 2

Para cada item da matriz, o time deve decidir uma destas quatro saídas:

| Saída | Quando usar | Exemplo |
| --- | --- | --- |
| **Preservar** | O comportamento legado é financeiro/core e precisa bater com histórico | truncamento, fórmula multiplicativa, ordem por CPF |
| **Parametrizar** | O valor é regra volátil ou legalmente versionada | alíquotas, faixas de renda, IPCA, fatores regionais |
| **Corrigir** | É bug claro sem dependência conhecida | status desconhecido cair como gerado, data inválida |
| **Escalar decisão** | Há impacto legal, segurança, auditoria ou fraude | CPF zero, prefixos especiais, região 99, RELAUDIT ocultando `EX` |

No Spec-Kit, cada decisão deve virar EARS com `source_legacy:` ou uma marca
`[NEEDS CLARIFICATION]` quando a equipe ainda não puder decidir.

---

## Lembrete de Definition of Done

- [x] Todo bloco IF/THEN/ELSE/DECIDE/AT BREAK examinado (15 programas)
- [x] Cada regra tem fonte `arquivo.NSN:Lstart-Lend` (rastreabilidade nos fragments)
- [x] Regras confirmadas citam seção da doc (43 de 187)
- [x] Mistérios marcados com `<!-- mystery: -->` (44)
- [x] EARS proposto para cada regra confirmada
- [x] Divergências cross-cutting consolidadas (9)
- [x] Matriz de rastreio dos 44 mistérios para regras de negócio e artefatos do Estágio 2

## Próximos passos do Estágio 1

1. Usar a matriz dos 44 flags para marcar quais pontos viram EARS, ADR ou `[NEEDS CLARIFICATION]`
2. Rodar `/discovery-report` para sintetizar tudo (este catálogo + mapa de dependências + mistérios + glossário) num documento de Passagem #1 para o Par 2 (Arquitetura)
3. Par 1 (PO + RE) decide quais das 9 divergências viram `[NEEDS CLARIFICATION]` no Estágio 2
