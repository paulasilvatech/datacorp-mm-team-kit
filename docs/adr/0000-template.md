<!-- markdownlint-disable MD013 MD024 MD028 MD033 MD041 -->

# ADR-NNNN: Título curto e decisivo

> **Trilha:** [Kit do Time](../../README.md) › [Docs](../README.md) › [ADRs](README.md) › **Template**

> [!NOTE]
> Este é o gabarito de ADR. Copie este arquivo para `NNNN-seu-titulo.md`, substituindo `NNNN` pelo próximo número sequencial (por exemplo, `0007`). Substitua cada bloco de instrução pelo conteúdo real da decisão.

| Campo | Valor |
|---|---|
| **Status** | proposto \| aceito \| descontinuado \| substituído |
| **Data** | YYYY-MM-DD |
| **Autores** | Persona — Nome |
| **Substitui** | ADR-NNNN \| N/A |

---

## Contexto

> [!NOTE]
> Descreva o problema que motiva esta decisão. Referencie o objetivo de negócio, a restrição legada ou a necessidade de stakeholder. Seja específico. Cite REQ-IDs ou programas em `01-arqueologia/legado-sifap/` quando relevante.

_Preencha aqui._

---

## Decisão

> [!NOTE]
> Declare a mudança proposta em voz ativa. Use um ou dois parágrafos. Exemplos: "Vamos adotar …", "Não vamos migrar …".

_Preencha aqui._

---

## Alternativas consideradas

> [!NOTE]
> Liste pelo menos 2 alternativas. Para cada uma, explique por que foi rejeitada.

| Alternativa | Por que foi rejeitada |
|---|---|
| Opção A | — |
| Opção B | — |

---

## Consequências

> [!NOTE]
> O que fica mais fácil? O que fica mais difícil? Há novos riscos?

- **Mais fácil:** —
- **Mais difícil:** —
- **Riscos:** —
- **Mitigações:** —

---

## Relacionado

- REQ-IDs: —
- ADRs: —
- Arquivos-fonte do legado: —

---

## Referências

> [!NOTE]
> Cite documentos, RFCs ou pesquisas que embasaram a decisão.

---

<details>
<summary><strong>Exemplo preenchido — ADR-0001: Adotar Flyway para migrations de banco</strong></summary>

| Campo | Valor |
|---|---|
| **Status** | aceito |
| **Data** | 2026-05-12 |
| **Autores** | DBA — Carla Souza |
| **Substitui** | N/A |

### Contexto

O SIFAP legado usa Adabas (banco não relacional). A modernização adota PostgreSQL 16. Precisamos de uma estratégia controlada de evolução de schema que permita rastrear mudanças, reverter em caso de erro e integrar ao CI. O programa `SIFAP-PAGTO.NSN` (linhas 45–78) revela que o ciclo de pagamentos mensal exige pelo menos 3 transformações de schema ao longo do tempo.

### Decisão

Vamos adotar Flyway como ferramenta de migrations. Cada alteração de schema será representada por um arquivo `V<N>__descricao.sql` versionado no repositório. O CI executará `mvn flyway:migrate` em cada pull request para `develop`.

### Alternativas consideradas

| Alternativa | Por que foi rejeitada |
|---|---|
| Liquibase | Formato XML mais verboso, curva de aprendizado maior para o time neste workshop |
| Migrations manuais | Sem rastreabilidade, sem reversão automatizada, sem integração com CI |

### Consequências

- Mais fácil: rastreabilidade completa de mudanças de schema; CI valida antes do merge.
- Mais difícil: arquivos de migration são imutáveis após merge; toda correção exige novo arquivo.
- Riscos: edição acidental de migration já aplicada quebra o Flyway.
- Mitigações: branch protection em `develop` + regra documentada em `troubleshooting.md`.

</details>

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [ADRs — Índice](README.md)<br/><sub>Índice de decisões registradas.</sub> | [Spec Moderna](../../02-spec-moderna/GUIDE.md)<br/><sub>Onde ADRs são produzidos.</sub> |

<sub>[Voltar ao índice do kit](../../README.md)</sub>
