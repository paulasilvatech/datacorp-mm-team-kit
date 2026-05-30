<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# ADR-003: Estratégia de mapeamento Adabas → JPA

![ESTÁGIO 02 ADR](https://img.shields.io/badge/ESTÁGIO-02%20ADR-00A4EF?style=for-the-badge) ![STATUS Aceita](https://img.shields.io/badge/STATUS-Aceita-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../README.md) → **ADRs** → **ADR-003**

## Status

Aceita

## Data

2026-05-29

## Contexto

O Adabas usa estruturas que não existem em bancos relacionais: campos MU (multiple-value), grupos PE (periodic groups) e super-descriptors. O Estágio 1 ([`ddm-schema-catalog.md`](../../01-arqueologia/ddm-schema-catalog.md)) catalogou esses elementos nos 4 DDMs (BENEFICIARIO, PAGAMENTO, PROGRAMA-SOCIAL, AUDITORIA). Precisamos de uma regra consistente de tradução para JPA/PostgreSQL 16 que preserve o comportamento e habilite consultas onde necessário, sem inflar o schema.

## Opções Consideradas

### Opção 1: Tudo em JSONB (MU e PE como colunas `jsonb`)

- **Prós:** migração rápida; schema enxuto; flexível.
- **Contras:** perde integridade referencial dos dependentes (PE); dificulta consultas/joins por dependente; índices limitados; viola normalização onde ela importa.

### Opção 2: Regra híbrida por tipo de estrutura

- **Prós:** PE com semântica de entidade (dependentes) vira `@OneToMany` (integridade + consulta); MU pequeno/consultável vira `@ElementCollection`; MU grande/opaco (ex.: telefones) vira `jsonb`; super-descriptor vira `@Index` composto. Equilíbrio entre fidelidade e simplicidade.
- **Contras:** exige decisão caso a caso (mais trabalho de modelagem no Estágio 3).

## Decisão

Adotar a **regra híbrida** (Opção 2):

| Estrutura Adabas | Mapeamento | Critério |
| ---------------- | ---------- | -------- |
| PE (periodic group) | `@OneToMany` + entidade embedded | quando os itens têm identidade/consulta (ex.: `DEPENDENTE`) |
| MU (multiple-value) | `@ElementCollection` | lista pequena, consultável |
| MU (multiple-value) | coluna `jsonb` | lista grande/opaca (ex.: telefones) |
| Super-descriptor | `@Index` composto | índice de busca composto |
| Campo financeiro packed | `BigDecimal` + `HALF_UP` | nunca `double` (alinhado a REQ-PGTO-003) |

FKs implícitas do Adabas tornam-se `@ManyToOne` explícitas com constraint no PostgreSQL. Tabelas de alto volume (PAGAMENTO ~180M, AUDITORIA ~25M) recebem particionamento (range por competência/ano).

## Consequências

### Positivas

- Integridade referencial real para dependentes e pagamentos.
- Consultas eficientes com índices apropriados; valores financeiros corretos.
- Caminho de migração de dados claro para o Estágio 3.

### Negativas

- Modelagem caso a caso aumenta o esforço inicial (mitigado pelo catálogo DDM pronto).
- Particionamento adiciona complexidade de DDL (mitigado por Flyway versionado).

## Requisitos Relacionados

- REQ-CAD-002/003 (DEPENDENTE como PE → `@OneToMany`)
- REQ-PGTO-003 (BigDecimal HALF_UP)
- REQ-AUD-001/003 (AUDITORIA append-only particionada)

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="ADR-002-limite-dependentes.md"><strong>ADR-002</strong></a><br/>
<sub>Limite de dependentes.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="../../03-implementacao/README.md"><strong>Estágio 3 — Implementação</strong></a><br/>
<sub>Construir Java + Next.js.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
