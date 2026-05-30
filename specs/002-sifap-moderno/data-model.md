<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Rascunho do Modelo de Dados — Adabas → JPA

![ESTÁGIO 02 Spec](https://img.shields.io/badge/ESTÁGIO-02%20Spec-00A4EF?style=for-the-badge) ![MAPEAMENTO Adabas→JPA](https://img.shields.io/badge/MAPEAMENTO-Adabas→JPA-1A1A1A?style=for-the-badge) ![AGENTE @architect](https://img.shields.io/badge/AGENTE-@architect-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../../02-spec-moderna/README.md) → **specs/002-sifap-moderno** → **data-model**

> Entrada: [`ddm-schema-catalog.md`](../../01-arqueologia/ddm-schema-catalog.md). Estratégia de mapeamento decidida em [ADR-003](../../02-spec-moderna/ADRs/ADR-003-adabas-jpa-mapping.md).

## Regras de mapeamento Adabas → JPA

| Estrutura Adabas | Mapeamento JPA/PostgreSQL | Justificativa |
| ---------------- | ------------------------- | ------------- |
| Campo MU (multiple-value) | `@ElementCollection` (tabela filha) **ou** coluna `jsonb` | Listas pequenas/consultáveis → tabela; listas grandes/opacas → JSONB |
| Grupo PE (periodic group) | `@OneToMany` para entidade embedded | PE é coleção de registros estruturados (ex.: dependentes) |
| Super-descriptor | `@Index` composto | Índice de busca composto vira índice PostgreSQL |
| Descriptor | `@Index` simples | Campo indexado |
| Campo packed/numeric | `BigDecimal` (financeiro) / `Integer` | Nunca `double` para dinheiro |

## Diagrama Entidade-Relacionamento (alvo)

```mermaid
erDiagram
    BENEFICIARIO ||--o{ DEPENDENTE : "possui (PE)"
    BENEFICIARIO ||--o{ PAGAMENTO : "recebe"
    PROGRAMA_SOCIAL ||--o{ BENEFICIARIO : "vincula"
    BENEFICIARIO ||--o{ AUDITORIA : "rastreado por"
    PAGAMENTO ||--o{ AUDITORIA : "rastreado por"

    BENEFICIARIO {
        uuid id PK
        string cpf UK "CPF módulo 11 · REQ-CAD-001"
        string nome
        date dataNascimento
        string status "ATIVO|SUSPENSO|SENIOR · REQ-CAD-004"
        int codigoRegiao "99 = exceção · REQ-CAD-005"
        uuid programaSocialId FK
        jsonb telefones "MU → JSONB (ADR-003)"
    }
    DEPENDENTE {
        uuid id PK
        uuid beneficiarioId FK "PE → @OneToMany"
        string cpf "00000000000 institucional · REQ-CAD-002"
        boolean institucional
        string grauParentesco
    }
    PROGRAMA_SOCIAL {
        uuid id PK
        string codigo UK
        string tipo "A = abono natalino · REQ-CALC-004"
        decimal fatorK "config versionada · REQ-CALC-002"
        decimal valorBase
    }
    PAGAMENTO {
        uuid id PK
        uuid beneficiarioId FK
        string competencia "AAAAMM · partição"
        decimal valorBruto "BigDecimal HALF_UP · REQ-PGTO-003"
        decimal valorLiquido
        string status "GERADO|PAGO|ERRO|REJEITADO|DEVOLVIDO · REQ-PGTO-001"
        string documentoBancario "match triplo · REQ-PGTO-004"
    }
    AUDITORIA {
        uuid id PK
        string entidade
        uuid entidadeId
        string acao "IN|AL|EX|CO|BT · REQ-AUD-002"
        jsonb estadoAnterior
        jsonb estadoPosterior
        string usuario
        timestamp dataHoraUtc "partição por ano"
    }
```

## Notas de migração de dados (do catálogo DDM)

| Achado (Estágio 1) | Decisão de modelagem |
| ------------------ | -------------------- |
| FK implícitas (sem constraint no Adabas) | Tornar explícitas com `@ManyToOne` + FK PostgreSQL |
| DIV-001/002/003 (divergências DDM↔doc) | Resolver no `/speckit.clarify`; código legado vence em conflito |
| Campos órfãos (ex.: `HASH-DIGITAL` biométrico) | **Descartar** (scope-decisions #18) — não migrar |
| Banco Real (356) | **Descartar** (EGG-003) — nota histórica em ADR |
| ~180M registros PAGAMENTO | Particionar por `competencia` (range) |
| ~25M registros AUDITORIA sem purge | Particionar por ano + política de archive (N4) |

> **DoD:** ✅ ER alvo com 5 entidades + relacionamentos, regras MU/PE/super-descriptor aplicadas, decisões de migração rastreadas ao Estágio 1.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="c4-diagrams.md"><strong>c4-diagrams.md</strong></a><br/>
<sub>Diagramas C4.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="api-contracts.md"><strong>api-contracts.md</strong></a><br/>
<sub>Endpoints REST.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
