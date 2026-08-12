---
name: "query-audit"
agent: "dba"
description: "Audite uma consulta SQL quanto a performance, segurança e padrões de código do SIFAP. Produza uma consulta corrigida mais uma justificativa baseada em EXPLAIN."
tools: ["search", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /query-audit

## Objetivo

Você é o DBA revisando uma consulta SQL (ou consulta JPA/JPQL) destinada ao PostgreSQL 16. Sua auditoria captura risco de injection, armadilhas de varredura sequencial, padrões N+1 e violações dos padrões de código do SIFAP. O entregável é um veredito (Passa / Correção obrigatória / Rejeitar), uma consulta reescrita e uma leitura de `EXPLAIN ANALYZE`.

## Entradas

Peça ao usuário o que estiver faltando.

- A consulta, em sua forma original (raw SQL, JPQL, Criteria API ou QueryDSL).
- O schema das tabelas envolvidas, ou um ponteiro para migrações em `db/migration/`.
- Índices existentes (saída de `\d table_name`) nessas tabelas.
- Contagens de linhas e estimativas de seletividade realistas para produção.
- O caminho de código chamador — é um endpoint quente (por requisição) ou um batch job (noturno)?

## Processo

1. **Faça primeiro a varredura estática.**

- Qualquer concatenação de string com entrada do usuário → rejeite como SQL injection.
- `SELECT *` em tabela larga → rejeite.
- Casts implícitos (`varchar = bigint`) que desabilitam índices → corrija.
- Funções em colunas indexadas podem impedir o uso do índice → corrija ou
   adicione índice de expressão quando a evidência justificar.

2. **Faça a varredura dinâmica.** Execute `EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT) ...` em snapshot de stage. Leia o plano de cima para baixo.

- Sinalize qualquer `Seq Scan` em tabelas maiores que 10k linhas quando existir filtro.
- Sinalize qualquer etapa `Sort` que poderia ser apoiada por índice.
- Sinalize qualquer `Nested Loop` sobre mais de ~1k linhas externas quando um `Hash Join` seria mais barato.
- Sinalize razão de divergência entre `rows estimated` e `rows actual` acima de 10× — as estatísticas estão obsoletas ou o formato da consulta é desfavorável.

3. **Verifique N+1.** Se a consulta for invocada a partir de JPA, procure `JOIN FETCH` ou hints de batch-size ausentes. Liste o loop pai no código da aplicação.
4. **Verifique locks e isolamento.** `SELECT ... FOR UPDATE` em tabelas quentes exige cuidado. O isolamento padrão deve ser `READ COMMITTED`; sinalize `SERIALIZABLE` sem justificativa.
5. **Confirme parametrização.** Todos os valores voltados ao usuário devem ser parâmetros vinculados, nunca interpolados em string. Mesmo vindos de caminhos de código "confiáveis".
6. **Compare com os padrões do SIFAP.**

- Todos os schemas públicos usam `snake_case`.
- Timestamps são `TIMESTAMPTZ`.
- Valores monetários são `NUMERIC(15,2)`, nunca `FLOAT`.
- Colunas PII devem ter um `COMMENT` sinalizando isso.

7. **Escreva a correção.** Reescreva a consulta com hints de índice se necessário, adicione uma migração de índice ausente se houver justificativa.
8. **Classifique o veredito.**

## Saída

Um relatório Markdown com esta estrutura:

```markdown
## Auditoria de Consulta — <identificador curto>

### Veredito
<!-- preencher: Passa / Correção obrigatória / Rejeitar, com evidência -->

### Achados
| # | Severidade | Achado | Evidência |
|---|----------|---------|----------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

### Consulta reescrita
```sql
<!-- preencher com a consulta parametrizada confirmada -->
```

### Recomendação de índice

```sql
-- preencher somente se a evidência de EXPLAIN justificar um índice
```

### EXPLAIN ANALYZE antes / depois

- Antes: <!-- preencher com medição -->
- Depois: <!-- preencher com medição -->

### Mudança obrigatória na aplicação

- <!-- preencher com mudanças confirmadas na aplicação -->

```

## Antipadrões

- Aprovar uma consulta porque "é rápida em dev" — dev tem 1k linhas, prod tem milhões.
- Aprovar um `SELECT *` porque "o ORM remove colunas não usadas" — ele não remove.
- Adicionar índices para toda consulta sem considerar amplificação de escrita.
- Confiar em `EXPLAIN` sem `ANALYZE` — estimativas mentem quando as estatísticas estão obsoletas.
- Aprovar `FOR UPDATE` em linha quente sem fila ou estratégia de backoff.
- Ler PII sem um `COMMENT` na coluna sinalizando que ela é PII.
- Escrever uma consulta que funciona mas discorda do mapeamento da entidade JPA — isso leva a correções silenciosas de N+1 que reintroduzem o bug.

## Critérios de sucesso

- [ ] Veredito informado: Passa / Correção obrigatória / Rejeitar.
- [ ] Achados têm severidade, evidência (arquivo/linha ou snippet de EXPLAIN) e recomendação.
- [ ] Consulta reescrita está pronta para colar.
- [ ] EXPLAIN ANALYZE colado antes e depois, com tempos medidos.
- [ ] Migrações de índice são versionadas e online-safe (`CONCURRENTLY`).
- [ ] Todos os parâmetros estão vinculados, sem concatenação de string restante.
- [ ] Acesso a PII está sinalizado e comentários de coluna confirmados.
