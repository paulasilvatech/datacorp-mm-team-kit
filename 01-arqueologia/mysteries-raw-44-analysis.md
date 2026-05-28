<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD033 MD034 MD040 MD051 MD060 -->

# Análise dos 44 Flags de Mistério — SIFAP Legado

> Este documento explica os **44 flags brutos** levantados durante a leitura dos programas Natural/Adabas.
> Eles não são todos "mistérios oficiais" da rubrica: alguns são divergências críticas, outros são decisões técnicas sem documentação, magic numbers, regras inferidas ou dívidas de modernização.

## Como ler este documento

Cada item responde a cinco perguntas:

| Campo | Significado |
| --- | --- |
| **Onde** | Programa, trecho e contexto funcional onde o flag apareceu |
| **Por que considerei mistério** | Critério usado: divergência documental, magic number, regra implícita, comportamento silencioso, risco de auditoria, etc. |
| **Risco** | O que pode quebrar se migrarmos literalmente ou se corrigirmos sem decisão |
| **Boa prática** | Como tratar esse tipo de achado numa modernização segura |
| **Como resolver** | Próxima ação prática: EARS, ADR, teste de equivalência, decisão de PO, parametrização, auditoria, etc. |

## Classificação usada

| Tipo | Quando usar | Melhor tratamento |
| --- | --- | --- |
| **Rubrica oficial** | Item plantado em `mysteries-checklist.md` | Preencher `mysteries-found.md` e usar como evidência do Estágio 1 |
| **Divergência doc x código** | Código executa diferente do manual/regra 2012 | Decisão explícita do PO + requisito EARS com `source_legacy:` |
| **Magic number** | Número com efeito de negócio sem origem legal | Parametrizar ou documentar em ADR; nunca "embelezar" sem validação |
| **Regra implícita** | Comportamento real inferido só do código | Criar teste de equivalência antes de reimplementar |
| **Backdoor / bypass** | Validação pulada por condição especial | Subir para segurança/auditoria; decidir manter, bloquear ou migrar com controle |
| **Bug compatível** | Parece bug, mas pode ter dependência externa | Preservar inicialmente com teste; corrigir só em mudança controlada |

---

## Mapa por Programa

| Programa | Flags | Tema dominante |
| --- | ---: | --- |
| CADBENEF | 5 | Status, idade, auditoria e divergência com docs |
| CADDEPEND | 3 | Dependentes, status ocultos e CPF zerado |
| CADPROG | 5 | Fator K, persistência ajustada e validação ausente |
| BATCHCON | 4 | Conciliação bancária, tolerância e banco descontinuado |
| BATCHPGT | 8 | Cálculo mensal, dezembro, desconto, status e ordem downstream |
| BATCHREL | 4 | Relatório financeiro, regiões, rounding e status silencioso |
| CALCBENF | 5 | Fórmula real, fatores e abono natalino |
| CALCCORR | 4 | IPCA, deflação e Plano Verão |
| CALCDSCT | 3 | Alíquotas, sindicato e cap de desconto |
| VALBENEF | 3 | CPF especial, bissexto e status divergente |
| VALDOCS | 2 | Prefixos especiais e documentos não validados |
| VALELEG | 3 | Região 99, renda hardcoded e tipo de programa |
| CONSBENF | 2 | Máscara CPF e status excluído |
| RELAUDIT | 1 | Exclusão omitida da auditoria |
| RELPGT | 2 | Status `P` e tipo de pagamento ambíguo |
| **Total** | **44** |  |

---

## 1. CADBENEF.NSN — Cadastro de Beneficiários

### 1.1 `VALCPF` documentado, mas CPF validado inline

- **Onde**: `CADBENEF.NSN:L114-L118` e subrotina `VALIDA-CPF` em `L219-L283`.
- **Contexto**: o manual cita um subprograma externo `VALCPF`, mas o programa implementa a validação dentro do próprio CADBENEF.
- **Por que considerei mistério**: divergência entre arquitetura documentada e implementação real. Isso muda o mapa de dependências: não há `CALLNAT VALCPF` aqui.
- **Risco**: migrar criando um serviço `ValCpfService` como se fosse dependência externa pode duplicar lógica ou perder variações locais.
- **Boa prática**: tratar validações duplicadas como candidatos a domínio compartilhado, mas primeiro catalogar todas as versões.
- **Como resolver**: escrever teste de equivalência para CPF usando CADBENEF, VALBENEF e VALDOCS; depois decidir em ADR se haverá uma política única de CPF.

### 1.2 Status `S` para idosos acima de 75 anos

- **Onde**: `CADBENEF.NSN:L156-L169`.
- **Contexto**: no cadastro, a idade é calculada apenas por ano e, se maior que 75, o status é sobrescrito para `S`.
- **Por que considerei mistério**: status `S` não aparece no domínio original documentado (`A`, `E`) e altera regra de vida do beneficiário silenciosamente.
- **Risco**: pagamentos podem deixar de ser gerados se batches filtram apenas `STATUS='A'`; relatórios podem interpretar `S` como suspenso.
- **Boa prática**: status de entidade deve ter máquina de estados explícita, significado documentado e dono de negócio.
- **Como resolver**: criar requisito EARS para status sênior/suspenso após decisão do PO; mapear todos os produtores e consumidores de status `S`.

### 1.3 Idade calculada só pelo ano

- **Onde**: `CADBENEF.NSN:L156-L160`.
- **Contexto**: idade = ano atual - ano nascimento, sem mês/dia.
- **Por que considerei mistério**: comportamento gera off-by-one anual; pode ser simplificação intencional da folha ou bug histórico.
- **Risco**: beneficiário nascido em dezembro muda de faixa desde janeiro.
- **Boa prática**: em migração, não "corrigir" cálculo de idade sem avaliar impacto retroativo.
- **Como resolver**: manter cálculo legado em teste de equivalência para pagamentos históricos; criar decisão de produto para novas competências.

### 1.4 Campos imutáveis no update sem documentação

- **Onde**: `CADBENEF.NSN:L199-L213`.
- **Contexto**: no caminho de alteração (`A`), vários campos não são sobrescritos: CPF, nascimento, sexo, cadastro, programa, região, NIS.
- **Por que considerei mistério**: RN-009 fala em alteração de CPF com supervisor e campo antigo, mas o DDM/programa lido não implementa isso.
- **Risco**: tela moderna pode permitir editar campos que o legado implicitamente proíbe.
- **Boa prática**: separar campos mutáveis e imutáveis no modelo de domínio; exigir caso de uso próprio para alterações sensíveis.
- **Como resolver**: documentar EARS de imutabilidade e abrir `[NEEDS CLARIFICATION]` para alteração supervisionada de CPF/NIS.

### 1.5 Auditoria documentada, mas sem chamada `LOGAUDIT`

- **Onde**: `CADBENEF.NSN:L177-L213`.
- **Contexto**: inclusão/alteração atualizam dados, mas não chamam rotina de auditoria, apesar de RN-010 falar em auditoria automática.
- **Por que considerei mistério**: divergência de compliance; pode haver trigger Adabas, batch externo ou lacuna real.
- **Risco**: reimplementar sem auditoria mantém falha; reimplementar com auditoria pode gerar eventos novos e quebrar reconciliação histórica.
- **Boa prática**: eventos de auditoria devem ser explícitos na arquitetura moderna.
- **Como resolver**: no Estágio 2, criar ADR de auditoria e requisito para registrar eventos cadastrais; confirmar se AUDITORIA é alimentada por outro programa.

---

## 2. CADDEPEND.NSN — Cadastro de Dependentes

### 2.1 Status `C`/`D` bloqueiam dependentes, mas origem é desconhecida

- **Onde**: `CADDEPEND.NSN:L59-L62`.
- **Contexto**: inclusão de dependente é bloqueada se titular está cancelado/desligado.
- **Por que considerei mistério**: CADBENEF não cria `C`/`D`, e a documentação original não lista esses status.
- **Risco**: máquina de estados incompleta na migração; status pode ser produzido por rotina não lida.
- **Boa prática**: antes de modelar enum moderno, levantar todos os produtores/consumidores de cada código.
- **Como resolver**: procurar `MOVE 'C' TO ...STATUS` e `MOVE 'D' TO ...STATUS` no legado; criar diagrama de estados.

### 2.2 Limite de dependentes: doc=3, código=5, DDM=10

- **Onde**: `CADDEPEND.NSN:L66-L69`; `BENEFICIARIO.ddm:L59-L61`.
- **Contexto**: documento 2012 fala em 3 dependentes; programa bloqueia acima de 5; DDM permite 10 ocorrências no grupo periódico.
- **Por que considerei mistério**: é tripla divergência entre lei/regra, implementação e capacidade física do dado.
- **Risco**: escolher o número errado causa perda de histórico, fraude ou rejeição indevida.
- **Boa prática**: quando doc, código e schema divergem, o requisito moderno deve declarar a decisão, não escolher silenciosamente.
- **Como resolver**: PO decide regra futura; testes de equivalência preservam legado para dados existentes; migração valida registros com 4-10 dependentes.

### 2.3 CPF de dependente zero pula checagem de duplicidade

- **Onde**: `CADDEPEND.NSN:L97-L104`; DDM em `BENEFICIARIO.ddm:L62`.
- **Contexto**: dependente com CPF zero não entra na checagem de duplicidade.
- **Por que considerei mistério**: pode ser regra legítima para dependentes sem CPF, mas também permite múltiplos dependentes sem identificação forte.
- **Risco**: cadastro fantasma, duplicidade e fraude.
- **Boa prática**: exceções de identificação precisam de justificativa, data, motivo e controle de auditoria.
- **Como resolver**: criar requisito para CPF ausente com motivo obrigatório; migrar CPF zero como estado explícito, não como número válido.

---

## 3. CADPROG.NSN — Cadastro de Programas Sociais

### 3.1 Constante `0.347215` no Fator K

- **Onde**: `CADPROG.NSN:L81-L83`.
- **Contexto**: `FATOR-K = 1.00 + (FATOR-REAJUSTE × 0.347215)`.
- **Por que considerei mistério**: magic number financeiro sem fonte legal; RN-013 já marca Fator K como não explicado.
- **Risco**: impacto fiscal direto em todos os benefícios ligados ao programa.
- **Boa prática**: constantes financeiras devem ser parametrizadas, versionadas e rastreadas a norma/portaria.
- **Como resolver**: ADR para parametrização de fatores; requisito EARS citando o código legado; teste de equivalência com valores históricos.

### 3.2 `VLR-BASE` gravado já ajustado

- **Onde**: `CADPROG.NSN:L88`.
- **Contexto**: operador informa valor base, mas o sistema grava `VLR-CALC` no campo `VLR-BASE`.
- **Por que considerei mistério**: o nome do campo mente; não preserva o input original.
- **Risco**: dupla aplicação do Fator K em cálculo posterior ou perda de auditabilidade do valor informado.
- **Boa prática**: separar valor informado, valor calculado e versão da regra de cálculo.
- **Como resolver**: no modelo moderno, usar campos distintos (`baseValue`, `adjustedBaseValue`, `calculationPolicyVersion`) e migrar com cuidado.

### 3.3 Parâmetros de elegibilidade persistidos sem validação

- **Onde**: `CADPROG.NSN:L90-L98`.
- **Contexto**: renda máxima, idade mínima e máxima são gravadas sem checar negativos ou mínimo > máximo.
- **Por que considerei mistério**: dados de configuração controlam elegibilidade, mas não há guardrails.
- **Risco**: programa mal cadastrado torna todos inelegíveis ou elegíveis.
- **Boa prática**: configuração de regra deve ter validação forte e testes de fronteira.
- **Como resolver**: Bean Validation no backend moderno; migração identifica registros incoerentes para saneamento.

### 3.4 Domínio `TIPO` existe no DDM, mas não é validado

- **Onde**: `CADPROG.NSN:L17` e `L65-L98`.
- **Contexto**: DDM comenta `A/P/T`, mas cadastro aceita qualquer valor.
- **Por que considerei mistério**: VALELEG e BATCHPGT dependem de `TIPO`, então valor inválido muda elegibilidade e abono.
- **Risco**: tipo desconhecido vira inelegível ou perde abono sem explicação.
- **Boa prática**: enums de domínio devem ser fechados, versionados e validados no ponto de entrada.
- **Como resolver**: catalogar tipos reais no banco legado; criar enum moderno com política para valores desconhecidos.

### 3.5 Status de programa forçado para `A`

- **Onde**: `CADPROG.NSN:L94`.
- **Contexto**: inclusão sempre cria programa ativo.
- **Por que considerei mistério**: não há fluxo de rascunho/aprovação; cadastro já entra operacional.
- **Risco**: programa incompleto começa a pagar benefício.
- **Boa prática**: cadastros críticos devem ter workflow de publicação.
- **Como resolver**: ADR define ciclo de vida de programa social (`DRAFT`, `ACTIVE`, `SUSPENDED`, `CLOSED`) mantendo compatibilidade com `A` legado.

---

## 4. BATCHCON.NSN — Conciliação Bancária

### 4.1 Headers/trailers CNAB ignorados

- **Onde**: `BATCHCON.NSN:L108-L110`.
- **Contexto**: só processa registro tipo `3`, ignora headers e trailers.
- **Por que considerei mistério**: trailers poderiam validar total de lote; ignorá-los reduz controle financeiro.
- **Risco**: arquivo truncado ou adulterado passa sem conferência de total.
- **Boa prática**: conciliação bancária deve validar contagem, soma e hash/controle de arquivo.
- **Como resolver**: no moderno, parser CNAB valida lote completo; em equivalência, manter regra atual para comparar resultados.

### 4.2 Tolerância de R$ 0,01

- **Onde**: `BATCHCON.NSN:L146-L157`.
- **Contexto**: diferenças até um centavo são conciliadas como OK.
- **Por que considerei mistério**: tolerância financeira sem norma citada; provavelmente compensa truncamentos divergentes.
- **Risco**: divergências pequenas recorrentes viram perda acumulada.
- **Boa prática**: tolerância financeira deve ser política configurável com trilha de auditoria.
- **Como resolver**: parametrizar tolerância por convênio/banco; criar relatório de valores tolerados.

### 4.3 Código de retorno desconhecido não altera pagamento

- **Onde**: `BATCHCON.NSN:L183-L186`.
- **Contexto**: `NONE` registra mensagem, mas não coloca pagamento em estado de erro.
- **Por que considerei mistério**: erro fica no log de execução, não no dado transacional.
- **Risco**: pagamento permanece em estado anterior e pode ser reprocessado errado.
- **Boa prática**: códigos desconhecidos devem virar estado explícito `RECONCILIATION_ERROR`.
- **Como resolver**: criar requisito para fila de exceção; preservar códigos originais no evento de conciliação.

### 4.4 Banco Real comentado

- **Onde**: `BATCHCON.NSN:L195-L213`.
- **Contexto**: bloco de integração com Banco Real está comentado; comentário indica aquisição pelo Santander em 2007.
- **Por que considerei mistério**: layout morto de banco extinto, com posições diferentes do Banco do Brasil.
- **Risco**: pode explicar o EGG-003; pode haver dados históricos que ainda dependem desse layout.
- **Boa prática**: integrações descontinuadas viram documentação histórica, não código morto em produção.
- **Como resolver**: mover para ADR/histórico; confirmar se existem arquivos Banco Real em acervo; não reimplementar sem necessidade.

---

## 5. BATCHPGT.NSN — Geração Mensal de Pagamentos

### 5.1 Tabela regional com 27 posições, mas só 1-25 usadas

- **Onde**: `BATCHPGT.NSN:L240-L244`.
- **Contexto**: slots 26 e 27 são carregados, mas condição só aceita 1 a 25.
- **Por que considerei mistério**: provável refactor incompleto ou reserva não documentada.
- **Risco**: regiões 26/27 recebem fator neutro por fallback.
- **Boa prática**: tabela de fatores deve ser dado de referência, não array hardcoded.
- **Como resolver**: extrair tabela para entidade versionada; criar teste para códigos 1-27 e 99.

### 5.2 Fator familiar aceita 5+ dependentes

- **Onde**: `BATCHPGT.NSN:L247-L256`.
- **Contexto**: cálculo prevê 5 ou mais dependentes, apesar de doc limitar a 3.
- **Por que considerei mistério**: confirma que a regra real divergiu da documentação.
- **Risco**: modernização pode pagar menos para famílias históricas com 4+ dependentes.
- **Boa prática**: regra de cálculo deve seguir comportamento real até decisão formal contrária.
- **Como resolver**: teste parametrizado para 0,1,2,3,4,5,6 dependentes; PO decide limite futuro.

### 5.3 Produto de fatores chamado de Fator K?

- **Onde**: `BATCHPGT.NSN:L278-L280`.
- **Contexto**: fórmula multiplica região, família, renda, idade e reajuste.
- **Por que considerei mistério**: RN-013 fala em fórmula aditiva e Fator K não explicado; código é multiplicativo.
- **Risco**: maior risco fiscal do sistema: fórmula errada altera todo pagamento.
- **Boa prática**: primeiro criar golden master de cálculo, depois refatorar nomes.
- **Como resolver**: gerar massa de teste com combinações de região/dependentes/renda/idade; validar com usuários de negócio.

### 5.4 Décimo terceiro usa fórmula reduzida

- **Onde**: `BATCHPGT.NSN:L290-L296`.
- **Contexto**: em dezembro, `VLR-13 = VLR-BASE × FATOR-REG × FATOR-IDADE`, sem fator família/renda.
- **Por que considerei mistério**: fórmula diferente da mensal, sem doc.
- **Risco**: pagamento de dezembro pode divergir muito se moderno reutilizar cálculo mensal completo.
- **Boa prática**: regras sazonais devem ser caso de uso próprio, não `if month == 12` espalhado.
- **Como resolver**: EARS específico para dezembro; teste de equivalência para competência `YYYY12`.

### 5.5 Abono natalino de 15% para `TIPO='A'`

- **Onde**: `BATCHPGT.NSN:L297-L302`.
- **Contexto**: programas tipo A recebem abono de 15% em dezembro.
- **Por que considerei mistério**: nem o significado de `TIPO='A'` nem o percentual têm fonte documental.
- **Risco**: retirar abono sem perceber gera subpagamento; manter sem base legal gera risco fiscal.
- **Boa prática**: bônus/abonos devem ser parametrizados por norma e vigência.
- **Como resolver**: levantar programas reais com tipo A; criar tabela `benefit_bonus_policy` versionada.

### 5.6 Desconto inline de 3% conflita com CALCDSCT/RN-021

- **Onde**: `BATCHPGT.NSN:L313-L317`.
- **Contexto**: batch aplica 3% se bruto > 500; comentário diz que deveria chamar CALCDSCT, mas não há `CALLNAT`.
- **Por que considerei mistério**: comentário obsoleto ou lógica duplicada simplificada.
- **Risco**: descontos modernos podem ser muito maiores/menores que legado.
- **Boa prática**: não confiar no cabeçalho; confiar no fluxo executável.
- **Como resolver**: ADR decide motor único de descontos; teste compara BATCHPGT e CALCDSCT para mesmos cenários.

### 5.7 Status inicial `G` versus doc `P`

- **Onde**: `BATCHPGT.NSN:L332`.
- **Contexto**: pagamento nasce como `G` (gerado), enquanto doc fala em `P` pendente.
- **Por que considerei mistério**: máquina de estados de pagamento divergente entre código e documento.
- **Risco**: UI moderna pode mostrar status errado ou conciliação não encontrar pendências.
- **Boa prática**: modelar máquina de estados a partir de todos os consumidores, não de um único documento.
- **Como resolver**: diagrama `G -> P/D/E/C`; confirmar significado de `P` em RELPGT e BATCHCON.

### 5.8 Ordem por CPF como contrato downstream

- **Onde**: `BATCHPGT.NSN:L178-L186`.
- **Contexto**: comentário diz que sistemas downstream dependem da ordenação por CPF.
- **Por que considerei mistério**: doc fala em ordem por nome; código fala CPF e afirma dependência externa invisível.
- **Risco**: trocar ordenação quebra totalizadores, arquivos ou comparações downstream.
- **Boa prática**: ordem de arquivo batch é contrato de integração.
- **Como resolver**: ADR de contrato de saída; testes snapshot dos arquivos gerados; manter ordenação CPF até mapear consumidores.

---

## 6. BATCHREL.NSN — Relatório Consolidado

### 6.1 Agrupamento 21-27 e 99 em Centro-Oeste

- **Onde**: `BATCHREL.NSN:L104-L118`.
- **Contexto**: código regional é agrupado em cinco regiões; catch-all vai para Centro-Oeste.
- **Por que considerei mistério**: RN-005 fala 27 UFs + 99 reservado; agrupamento não está documentado e engole região 99.
- **Risco**: relatório gerencial mostra região errada.
- **Boa prática**: mapeamento geográfico deve ser tabela de referência auditável.
- **Como resolver**: criar tabela `region_group_mapping`; validar códigos reais com DBA/PO.

### 6.2 Relatório arredonda, batch trunca

- **Onde**: `BATCHREL.NSN:L121-L125`; contraste com `BATCHPGT.NSN:L282-L284`.
- **Contexto**: relatório soma valores arredondados; geração de pagamento trunca.
- **Por que considerei mistério**: comentário reconhece divergência, mas ela permaneceu.
- **Risco**: total do relatório não bate com soma real dos pagamentos.
- **Boa prática**: relatório financeiro deve somar valores persistidos, não recalcular arredondamento.
- **Como resolver**: no moderno, relatórios usam valores gravados; teste de equivalência documenta diferença histórica.

### 6.3 Status `C` de pagamento aparece, mas produtor não foi visto

- **Onde**: `BATCHREL.NSN:L137-L138`.
- **Contexto**: relatório decodifica `CANCELADO`.
- **Por que considerei mistério**: BATCHPGT/BATCHCON não criam status `C`.
- **Risco**: estado importante pode vir de programa fora do escopo.
- **Boa prática**: enum só fica completo depois de varredura global.
- **Como resolver**: buscar produtores de `STATUS-PGTO='C'`; incluir no dependency map comportamental.

### 6.4 Status desconhecido cai como GERADO

- **Onde**: `BATCHREL.NSN:L143-L144`.
- **Contexto**: cláusula `NONE` classifica qualquer status inesperado como gerado.
- **Por que considerei mistério**: mascara corrupção de dado.
- **Risco**: relatórios inflam pagamentos gerados e escondem anomalias.
- **Boa prática**: fail-fast ou bucket explícito `UNKNOWN` em relatórios críticos.
- **Como resolver**: requisito para listar status desconhecidos separadamente; migração identifica valores fora do domínio.

---

## 7. CALCBENF.NSN — Cálculo de Benefício

### 7.1 Tabela de 25 fatores regionais

- **Onde**: `CALCBENF.NSN:L93-L119`.
- **Contexto**: fatores por UF/região variam de 1.0000 a 1.4000.
- **Por que considerei mistério**: critério político/econômico não está documentado.
- **Risco**: alteração indevida muda distribuição regional de benefício.
- **Boa prática**: tabelas de fator devem ser dados versionados com vigência.
- **Como resolver**: parametrizar em tabela; migrar valores legados com versão inicial `legacy-2013`.

### 7.2 Fator familiar progressivo diverge da fórmula aditiva

- **Onde**: `CALCBENF.NSN:L187-L198`.
- **Contexto**: escala progressiva multiplicativa por número de dependentes.
- **Por que considerei mistério**: RN-013 fala em acréscimo aditivo.
- **Risco**: pagamentos calculados incorretamente.
- **Boa prática**: quando fórmula documentada diverge do código, código vira evidência, mas decisão legal fica com negócio.
- **Como resolver**: golden master com casos 0-6 dependentes; EARS cita fórmula real e marca source_legacy.

### 7.3 Faixas de renda hardcoded e defasadas

- **Onde**: `CALCBENF.NSN:L121-L131`.
- **Contexto**: 300/600/1000/1500/9999.99, última carga 2013.
- **Por que considerei mistério**: valor monetário sem indexação e sem fonte normativa.
- **Risco**: regra fica socialmente defasada; modernização pode perpetuar injustiça.
- **Boa prática**: faixas monetárias precisam de vigência e índice de atualização.
- **Como resolver**: tabela de faixas por período; PO decide se mantém histórico ou atualiza daqui para frente.

### 7.4 Fórmula principal multiplicativa

- **Onde**: `CALCBENF.NSN:L223-L226`.
- **Contexto**: `VLR-BASE × FATOR-REG × FATOR-FAM × FATOR-RND × FATOR-IDADE`.
- **Por que considerei mistério**: é a regra real mais importante e contradiz documentação simplificada.
- **Risco**: qualquer erro aqui afeta todo o core do sistema.
- **Boa prática**: motor de cálculo isolado, altamente testado, com casos de borda e rastreabilidade.
- **Como resolver**: implementar `BenefitCalculationService` com testes de equivalência antes de expor endpoint.

### 7.5 13º e abono natalino no cálculo

- **Onde**: `CALCBENF.NSN:L243-L260`.
- **Contexto**: dezembro calcula 13º reduzido e abono 15% para tipo A.
- **Por que considerei mistério**: mesma descoberta de BATCHPGT aparece também no cálculo isolado, confirmando regra real.
- **Risco**: duplicar ou omitir regra sazonal.
- **Boa prática**: centralizar regra de competência especial.
- **Como resolver**: criar policy `DecemberBenefitPolicy`; garantir que batch e cálculo online usem a mesma policy.

---

## 8. CALCCORR.NSN — Correção Monetária

### 8.1 Correção só se diferença positiva

- **Onde**: `CALCCORR.NSN:L141-L149`.
- **Contexto**: se IPCA acumulado gerar `DIFF <= 0`, não persiste correção.
- **Por que considerei mistério**: sistema nunca aplica deflação.
- **Risco**: pagamento corrigido sempre favorece aumento, nunca redução; pode ser regra protetiva ou erro.
- **Boa prática**: política de correção precisa explicitar tratamento de índices negativos.
- **Como resolver**: decisão jurídica/PO; teste para índice negativo.

### 8.2 Tabela IPCA estática 2010-2012

- **Onde**: `CALCCORR.NSN:L46-L82`.
- **Contexto**: comentário diz última carga 2014, mas só há anos 2010, 2011 e 2012.
- **Por que considerei mistério**: períodos fora da tabela não recebem correção e não geram erro.
- **Risco**: pagamentos fora da janela ficam sem atualização monetária.
- **Boa prática**: índices econômicos devem vir de tabela externa com cobertura e validação de lacunas.
- **Como resolver**: tabela `monetary_index`; validação se período não coberto; migração preserva comportamento legado para reprocessamento histórico.

### 8.3 Bloco Plano Verão comentado

- **Onde**: `CALCCORR.NSN:L84-L101`.
- **Contexto**: código morto preserva fatores Cruzado/Cruzeiro e comentário "NAO REMOVER (HISTORICO)".
- **Por que considerei mistério**: política econômica antiga mantida no fonte; possível demanda judicial histórica.
- **Risco**: apagar sem registrar perde conhecimento regulatório; reativar sem decisão gera cálculo errado.
- **Boa prática**: código morto histórico vira documentação/ADR, não lógica executável.
- **Como resolver**: registrar em ADR histórico; não migrar como execução ativa salvo requisito explícito.

### 8.4 Ano fora da tabela passa silenciosamente

- **Onde**: `CALCCORR.NSN:L162-L172`.
- **Contexto**: se ano não está em `#ANO-TAB`, índice acumulado fica 1.000000.
- **Por que considerei mistério**: ausência de dado econômico vira "sem correção" sem aviso.
- **Risco**: subcorreção massiva.
- **Boa prática**: ausência de referência externa crítica deve ser erro controlado.
- **Como resolver**: no moderno, lançar exceção de domínio ou registrar pendência operacional quando índice não existir.

---

## 9. CALCDSCT.NSN — Cálculo de Descontos

### 9.1 Alíquotas 3/5/7/9%

- **Onde**: `CALCDSCT.NSN:L43-L54`, `L163-L172`.
- **Contexto**: contribuição social progressiva por faixas.
- **Por que considerei mistério**: cabeçalho fala em novas alíquotas 2015, mas sem norma.
- **Risco**: desconto obrigatório calculado sem respaldo rastreável.
- **Boa prática**: tabela de alíquotas com vigência e fonte legal.
- **Como resolver**: parametrizar faixas; EARS inclui source_legacy e `[NEEDS CLARIFICATION: norma 2015]`.

### 9.2 Sindical 1% hardcoded

- **Onde**: `CALCDSCT.NSN:L131-L132`.
- **Contexto**: desconto tipo `S` aplica 1% fixo.
- **Por que considerei mistério**: desconto sindical não aparece no RN-022 e não é parametrizável.
- **Risco**: cobrança indevida ou regra desatualizada pós-reforma trabalhista.
- **Boa prática**: descontos sensíveis devem ser configuráveis, com consentimento/origem.
- **Como resolver**: PO/jurídico decide se existe; modelar como tipo de desconto com policy versionada.

### 9.3 Cap agregado versus prioridade RN-023

- **Onde**: `CALCDSCT.NSN:L131-L135`.
- **Contexto**: código fixa total no teto; documento fala em descartar por prioridade.
- **Por que considerei mistério**: regra muda quem recebe desconto total/parcial.
- **Risco**: contestação legal e divergência financeira.
- **Boa prática**: algoritmo de teto deve ser explícito e testado por ordem de prioridade.
- **Como resolver**: criar cenários com múltiplos descontos; PO escolhe preservar cap agregado ou corrigir para prioridade.

---

## 10. VALBENEF.NSN — Validação Cadastral

### 10.1 CPF `000...` aceito como exceção

- **Onde**: `VALBENEF.NSN` regra #3.
- **Contexto**: CPFs com todos os dígitos iguais seriam rejeitados, mas prefixo `000` escapa da rotina.
- **Por que considerei mistério**: backdoor de governo/teste sem documentação.
- **Risco**: cadastro sem identidade forte.
- **Boa prática**: exceção de documento deve ter motivo, escopo e auditoria.
- **Como resolver**: substituir número mágico por estado `documentUnavailable` + justificativa obrigatória.

### 10.2 Fevereiro sempre aceita 29 dias

- **Onde**: `VALBENEF.NSN` regra #5.
- **Contexto**: tabela de dias do mês fixa fevereiro = 29, comentário diz "considera bissexto".
- **Por que considerei mistério**: comentário promete uma coisa, código faz outra.
- **Risco**: aceita 29/02 em ano não bissexto.
- **Boa prática**: usar biblioteca de data, não tabela manual.
- **Como resolver**: no moderno, `LocalDate`/validação real; para migração, identificar datas inválidas já cadastradas.

### 10.3 Domínio de status diferente da documentação

- **Onde**: `VALBENEF.NSN` regra #8.
- **Contexto**: valida {A,S,C,I,D}; RN-002 fala em A/E.
- **Por que considerei mistério**: enum divergente e campo central.
- **Risco**: status `E` pode ser rejeitado por validação moderna se seguirmos código; ou `S/C/I/D` podem ser perdidos se seguirmos doc.
- **Boa prática**: inventariar valores reais antes de fechar enum.
- **Como resolver**: query de distribuição de status no banco legado; ADR de máquina de estados.

---

## 11. VALDOCS.NSN — Validação de Documentos

### 11.1 Prefixos especiais anulam erros anteriores

- **Onde**: `VALDOCS.NSN` regra #12.
- **Contexto**: prefixos {000,001,002,010,011,099,100,999} fazem `RESULTADO='V'` e zeram erros.
- **Por que considerei mistério**: bypass explícito de validação; provavelmente backdoor operacional.
- **Risco**: documentos inválidos entram como válidos.
- **Boa prática**: bypass de validação precisa de autorização, perfil, motivo e trilha de auditoria.
- **Como resolver**: criar fluxo de exceção documental; não migrar como validação automática invisível.

### 11.2 Título e CTPS coletados, mas não validados

- **Onde**: `VALDOCS.NSN` regra #13.
- **Contexto**: campos são lidos no input, mas não há `PERFORM` para validar.
- **Por que considerei mistério**: funcionalidade incompleta ou quebrada por ajuste de 2011.
- **Risco**: UI moderna promete validação que legado não fazia; ou mantém coleta inútil.
- **Boa prática**: campo coletado precisa ter propósito claro: validação, armazenamento ou remoção.
- **Como resolver**: decidir com PO se documentos complementares continuam; se sim, criar validação real e migração de qualidade de dados.

---

## 12. VALELEG.NSN — Elegibilidade

### 12.1 Região 99 dá elegibilidade automática

- **Onde**: `VALELEG.NSN:L102-L106`.
- **Contexto**: comentário `INTERNACIONAL/DIPLOMATICO`; alteração de 2013.
- **Por que considerei mistério**: RN-005 diz reservado para uso interno, mas não autoriza bypass de elegibilidade.
- **Risco**: beneficiários especiais pulam critérios comuns.
- **Boa prática**: exceções diplomáticas/internacionais devem ser regra formal com aprovação.
- **Como resolver**: requisito EARS opcional: "Where beneficiary is diplomatic..." com source_legacy e aprovação PO.

### 12.2 Renda 600 para assistencial sem dependentes

- **Onde**: `VALELEG.NSN:L163-L170`.
- **Contexto**: tipo A com renda > 600 e sem dependentes é inelegível.
- **Por que considerei mistério**: valor hardcoded, sem data-base.
- **Risco**: regra defasada por inflação.
- **Boa prática**: thresholds monetários precisam de vigência.
- **Como resolver**: parametrizar por programa social; manter valor legado para competências antigas.

### 12.3 `TIPO-PROG` desconhecido vira inelegível

- **Onde**: `VALELEG.NSN:L189-L193`.
- **Contexto**: DECIDE cobre A/P/T; `NONE` rejeita.
- **Por que considerei mistério**: CADPROG não valida TIPO, então valor inválido pode nascer e depois falhar aqui.
- **Risco**: programa cadastrado errado nunca concede benefício.
- **Boa prática**: validar domínio no cadastro, não só no consumo.
- **Como resolver**: enum validado em `ProgramService`; rotina de saneamento para tipos já existentes.

---

## 13. CONSBENF.NSN — Consulta de Beneficiário

### 13.1 Bug conhecido de máscara CPF não pode ser corrigido

- **Onde**: `CONSBENF.NSN:L175-L189`.
- **Contexto**: CPFs com zeros à esquerda mostram os três primeiros dígitos; comentário manda não corrigir sem auditoria.
- **Por que considerei mistério**: bug virou contrato operacional.
- **Risco**: corrigir quebra auditoria/reconciliação; manter expõe dado sensível incorretamente.
- **Boa prática**: bug compatível deve ser encapsulado e marcado como legado.
- **Como resolver**: ADR de máscara CPF; modo legado para relatórios históricos e máscara correta para novas telas.

### 13.2 Status `E` não é decodificado

- **Onde**: `CONSBENF.NSN:L107-L121`.
- **Contexto**: DECIDE cobre A/S/C/I/D, mas RN-011 fala em `E` exclusão lógica.
- **Por que considerei mistério**: beneficiário excluído pode aparecer como `DESCONHECIDO`.
- **Risco**: operador toma decisão errada.
- **Boa prática**: status desconhecido deve ser visível e rastreável.
- **Como resolver**: mapear status `E` na máquina moderna; relatório de dados com status não mapeado.

---

## 14. RELAUDIT.NSN — Relatório de Auditoria

### 14.1 Exclusões (`ACAO='EX'`) são ocultadas

- **Onde**: `RELAUDIT.NSN:L102-L108`.
- **Contexto**: relatório incrementa contador de filtrados e não exibe exclusões.
- **Por que considerei mistério**: auditoria ocultando exclusão contradiz o propósito da auditoria e RN-011.
- **Risco**: compliance grave; exclusões podem ter sido invisíveis por anos.
- **Boa prática**: trilha de auditoria é append-only e jamais oculta evento crítico sem filtro explícito.
- **Como resolver**: requisito moderno para relatório completo; se houver filtro de privacidade, ele precisa ser explícito e auditado.

---

## 15. RELPGT.NSN — Relatório Analítico de Pagamentos

### 15.1 `STATUS-PGTO='P'`: doc diz pendente, relatório diz pago

- **Onde**: `RELPGT.NSN:L133-L145`; doc 2012 seção de status.
- **Contexto**: mesmo código `P` tem semântica diferente.
- **Por que considerei mistério**: estado ambíguo bloqueia modelagem do domínio.
- **Risco**: pagamento pendente exibido como pago ou vice-versa.
- **Boa prática**: nunca migrar enum ambíguo sem tabela de transição.
- **Como resolver**: montar matriz por programa: quem cria, quem lê, quem exibe cada status; PO valida nomes modernos.

### 15.2 `D=DECIMO` e `T=TERCEIRO`

- **Onde**: `RELPGT.NSN:L121-L130`.
- **Contexto**: dois tipos parecem relacionados ao 13º.
- **Por que considerei mistério**: diferença sem documentação; pode ser primeira/segunda parcela ou evolução histórica.
- **Risco**: relatório moderno agrupa tipos indevidamente.
- **Boa prática**: códigos de tipo de pagamento devem ter dicionário explícito.
- **Como resolver**: consultar distribuição de `TIPO-PGTO` no legado; documentar enum moderno com aliases históricos.

---

## Boas Práticas Gerais para Resolver os 44 Achados

1. **Não corrigir durante a arqueologia.** Primeiro documentar, provar e classificar.
2. **Separar comportamento legado de regra futura.** O legado responde "o que acontece"; o PO responde "o que deve acontecer".
3. **Criar EARS para toda regra que será preservada.** Cada EARS deve ter `source_legacy:` com arquivo e linha.
4. **Usar testes de equivalência para cálculo financeiro.** Fórmula, rounding, desconto e dezembro precisam de golden master.
5. **Criar ADRs para decisões irreversíveis.** Auditoria, status, CPF zero, região 99, Fator K e rounding merecem ADR.
6. **Parametrizar regras voláteis.** Alíquotas, faixas de renda, fatores regionais e IPCA não devem virar constantes Java.
7. **Preservar bugs compatíveis em camada isolada.** Máscara CPF e truncamento podem ser mantidos em modo legado até decisão de correção.
8. **Falhar visivelmente em dados desconhecidos.** Status/tipo/código desconhecido deve aparecer como `UNKNOWN`, não cair em default silencioso.
9. **Auditoria explícita e append-only.** Exclusões e bypasses precisam ficar visíveis.
10. **Toda exceção precisa de dono.** CPF zero, prefixos especiais e região 99 só podem sobreviver se tiverem regra e responsabilidade.

## Como transformar isso em trabalho do Estágio 2

| Achado | Artefato recomendado |
| --- | --- |
| Fator K, fórmula multiplicativa, truncamento | Requisitos EARS + testes de equivalência |
| Status beneficiário/pagamento ambíguos | ADR de máquina de estados + enum moderno |
| CPF zero, prefixos especiais, região 99 | Decisão PO + requisito de exceção auditável |
| RELAUDIT ocultando EX | ADR de auditoria + requisito de compliance |
| Banco Real / Plano Verão | ADR histórico; não migrar como lógica ativa sem requisito |
| Tabelas hardcoded | Modelo de configuração versionada |
| BATCHPGT ordem por CPF | Contrato de integração + teste snapshot |

## Conclusão

Os 44 flags não significam que existem 44 bugs. Eles indicam **44 pontos onde a modernização não pode agir no automático**.

A melhor prática é tratar cada um como decisão rastreável:

1. **Preservar** quando for comportamento financeiro comprovado.
2. **Parametrizar** quando for regra volátil.
3. **Corrigir** quando for bug sem dependência conhecida.
4. **Isolar em modo legado** quando parecer bug, mas houver dependência externa.
5. **Escalar para PO/jurídico/auditoria** quando houver impacto legal, fraude ou compliance.
