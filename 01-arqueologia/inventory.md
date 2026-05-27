# Inventário Legado — Time `<preencher>`

> **Estágio 1 · Passo 1 (`/archaeology-kickoff`)**
> Gerado em: 2026-05-27
> Autor da varredura: `@archaeologist-agent` (orientação) + par responsável: `<preencher>`
>
> ⚠️ **Primeira passada.** Este inventário foi feito SEM abrir nenhum programa.
> Trabalha apenas sobre nomes de arquivo e estrutura de pastas. Será revisado
> conforme o time rodar `/extract-business-rules`, `/map-dependencies` e
> `/catalog-mysteries` durante o Estágio 1.

---

## Estrutura de Pastas

```
01-arqueologia/legado-sifap/
├── README.md
├── COMO-LER-NATURAL.md
├── natural-programs/      ← 15 .NSN + 1 README
├── adabas-ddms/           ← 4 .ddm  + 1 README
└── legacy-docs/           ← 3 .md + 3 .docx + 1 README (documentos históricos)
```

**Total de diretórios sob `legado-sifap/`:** 3 (mais a raiz).

---

## Contagem de Arquivos por Tipo

| Extensão | Contagem | Finalidade provável (conhecimento genérico Natural/Adabas) |
| --- | --- | --- |
| `.NSN`  | 15 | Programa-fonte Natural (Natural Source) |
| `.ddm`  | 4  | Data Definition Module — schema de um arquivo Adabas (FDT + view) |
| `.md`   | 7  | Documentação Markdown (4 READMEs + 3 docs históricos transcritos) |
| `.docx` | 3  | Documentos Word originais (manuais técnicos exportados) |

> **Nota:** o kit também tem 1 `README.md` na raiz de `legado-sifap/` e 1 `COMO-LER-NATURAL.md` (tutorial), que não fazem parte do código legado em si — são orientação do workshop.

---

## Padrões de Convenção de Nomes

Agrupamento por prefixo até a primeira mudança semântica do nome.
**Hipóteses são genéricas — o time confirma lendo os programas.**

| Prefixo  | Contagem | Arquivos                                | Hipótese                                           |
| -------- | -------- | --------------------------------------- | -------------------------------------------------- |
| `BATCH`  | 3        | BATCHCON, BATCHPGT, BATCHREL            | Programas batch (orquestradores noturnos)          |
| `CAD`    | 3        | CADBENEF, CADDEPEND, CADPROG            | Cadastros online (CRUD via MAP) — `CAD`=cadastro   |
| `CALC`   | 3        | CALCBENF, CALCCORR, CALCDSCT            | Rotinas de cálculo (alta densidade de regras)      |
| `VAL`    | 3        | VALBENEF, VALDOCS, VALELEG              | Validações — possíveis subprogramas folha          |
| `REL`    | 2        | RELAUDIT, RELPGT                        | Relatórios (`REL`=relatório)                       |
| `CONS`   | 1        | CONSBENF                                | Consulta online — **único prefixo solitário**      |

**Total verificável:** 3 + 3 + 3 + 3 + 2 + 1 = 15 ✓

DDMs não têm prefixo de família — usam o nome da entidade de domínio
(AUDITORIA, BENEFICIARIO, PAGAMENTO, PROGRAMA-SOCIAL).

---

## Itens Incomuns (Top 3)

### 1. `natural-programs/BATCHPGT.NSN` — maior programa

- **Tamanho:** 377 linhas / 10.866 bytes (quase 3× o menor)
- **Por que é incomum:** muito acima da mediana (≈ 230 linhas) — provável orquestrador
  principal de pagamento, com cadeias longas de `PERFORM`/`CALLNAT`.
- **Ação sugerida:** **NÃO** começar a leitura por aqui. Deixar para o fim,
  depois de já ter mapeado as dependências dos subprogramas que ele invoca.

### 2. `natural-programs/CONSBENF.NSN` — prefixo `CONS` solitário

- **Por que é incomum:** todos os outros prefixos aparecem em famílias de 2-3 arquivos.
  `CONS` aparece uma única vez.
- **Hipóteses a investigar:**
  - Família de consultas foi consolidada em um programa só
  - Renomeação histórica (antigos `CONS*` viraram `CAD*`?)
  - Convenção inconsistente entre desenvolvedores diferentes
- **Ação sugerida:** registrar como MYSTERY no `mysteries-found.md` e pedir confirmação
  ao revisar o programa.

### 3. `legacy-docs/` com pares `.docx` + `.md`

- **Arquivos:** ARQUITETURA-ORIGINAL-1997, MANUAL-TECNICO-SIFAP-2008, REGRAS-NEGOCIO-2012 — cada um existe nas duas extensões.
- **Por que é incomum:** documentação duplicada em formatos diferentes cria risco
  de divergência (qual é a fonte da verdade?).
- **Ação sugerida:** Tech Writer (Par 5) abre um `.docx` e o `.md` correspondente lado a lado e confirma se o `.md` é transcrição fiel. Se houver divergência, anotar em `mysteries-found.md`.

---

## Ordem de Leitura Proposta

> Heurística: **dados → folhas → tronco → raízes**.
> Esta é uma hipótese — vai mudar quando `/map-dependencies` rodar.

| Ordem | Grupo                      | Justificativa                                              |
| ----- | -------------------------- | ---------------------------------------------------------- |
| 1     | DDMs (4)                   | Vocabulário do domínio antes de qualquer programa          |
| 2     | `VAL-*` (3)                | Provável camada folha; pequenos; ensinam sintaxe ao time   |
| 3     | `CONS-*` + `CAD-*` (1 + 3) | Fluxos online de leitura/escrita (CRUD com MAP screens)    |
| 4     | `CALC-*` (3)               | Onde estão as regras de negócio mais densas                |
| 5     | `REL-*` (2)                | Relatórios consomem dados já compreendidos                 |
| 6     | `BATCH-*` (3)              | Orquestradores no topo da cadeia (`BATCHPGT` por último)   |

### Sugestão de divisão entre os 5 pares (3 programas cada)

Cada par leva **1 grupo coeso** para garantir contexto compartilhado:

| Par               | Programas atribuídos                       | Total |
| ----------------- | ------------------------------------------ | ----- |
| 1 · Visão         | CADBENEF, CADDEPEND, CADPROG               | 3     |
| 2 · Arquitetura   | BATCHCON, BATCHPGT, BATCHREL               | 3     |
| 3 · Implementação | CALCBENF, CALCCORR, CALCDSCT               | 3     |
| 4 · Qualidade     | VALBENEF, VALDOCS, VALELEG                 | 3     |
| 5 · Operações     | CONSBENF, RELAUDIT, RELPGT                 | 3     |

Os 4 DDMs são lidos **por todos os pares** no início (5-10 min) para alinhar vocabulário.

---

## Próximo Passo

A equipe agora deve invocar:

```
/extract-business-rules file=<programa-do-meu-par>.NSN
```

…para cada um dos 3 programas atribuídos. As regras extraídas vão para
[`business-rules-catalog.md`](business-rules-catalog.md).

E em paralelo:

```
/map-dependencies
```

…para descobrir o grafo real de `CALLNAT`/`PERFORM`/`INCLUDE` e revisar a ordem
de leitura proposta acima.
