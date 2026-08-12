<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Estágio 1 — Arqueologia Digital (90 min)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **GUIDE**

> ⏰ O horário oficial é **11:00–12:00 + 13:30–14:00** em
> [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md). Este guia não adiciona tempo a essa agenda.

## Objetivo

Ler os programas Natural atribuídos, registrar evidências rastreáveis e escolher
um recorte pequeno que possa virar uma feature. Não é objetivo explicar todo o
SIFAP, completar documentação enciclopédica ou resolver mistérios.

> [!IMPORTANT]
> **HARD GATE.** Antes de escrever EARS no Estágio 2, o par precisa ter lido os
> programas Natural atribuídos e ter evidência para cada comportamento escolhido.
> Todo requisito formal posterior precisa de `source_legacy:` válido ou de
> `[GREENFIELD]` com justificativa. O gate não é uma meta de quantidade.

## Roteiro cronometrado

| Horário | Atividade | Resultado mínimo |
| --- | --- | --- |
| 11:00–11:10 | Abra os três programas atribuídos ao par e combine quem lê cada um. | Cobertura dos programas e nomes dos leitores. |
| 11:10–11:40 | Faça leitura orientada: entradas, saídas, chamadas e decisões de domínio. | Notas com caminho e faixa de linhas. |
| 11:40–12:00 | Registre regras candidatas e dúvidas, sem inferir comportamento ausente. | Evidências no catálogo e pendências explícitas. |
| 13:30–13:45 | Consolide somente as evidências que sustentam o recorte do protótipo. | Catálogo e relatório de descoberta atualizados. |
| 13:45–13:55 | O PO prioriza **uma feature fina**; o time descarta ou adia o restante. | Decisão de escopo para o Estágio 2. |
| 13:55–14:00 | Faça a Passagem H1 com o Par 2. | Fontes, escopo e dúvidas transferidos ao vivo. |

## Quem lê o quê

Cada par lê os três programas abaixo. A leitura pode ser focalizada nas decisões
de domínio; não tente traduzir cada instrução Natural durante esta etapa.

| Par | Programas |
| --- | --- |
| 1 · Visão | `CADBENEF.NSN`, `CADDEPEND.NSN`, `CADPROG.NSN` |
| 2 · Arquitetura | `BATCHPGT.NSN`, `BATCHREL.NSN`, `BATCHCON.NSN` |
| 3 · Implementação | `CALCBENF.NSN`, `CALCCORR.NSN`, `CALCDSCT.NSN` |
| 4 · Qualidade | `VALBENEF.NSN`, `VALDOCS.NSN`, `VALELEG.NSN` |
| 5 · Operações | `CONSBENF.NSN`, `RELPGT.NSN`, `RELAUDIT.NSN` |

O Par 4 também consulta os DDMs necessários para a feature selecionada. Mapear
todos os campos ou propor o schema completo não é obrigatório neste estágio.

## O que registrar

Use os [templates](templates/) como apoio. Para cada regra candidata ao recorte,
registre no mínimo:

- uma descrição curta do comportamento observado;
- o caminho do `.NSN` ou `.ddm` e, quando possível, a faixa de linhas;
- a dúvida que ainda impede uma conclusão, sem transformá-la em requisito;
- o impacto da regra na feature priorizada.

`business-rules-catalog.md` é a entrada para a spec formal; use o
[template do catálogo](templates/business-rules-catalog.template.md) caso o
arquivo ainda não exista. O glossário, mapa de dependências e registro de
mistérios podem ser enriquecidos se ajudarem o recorte, mas não bloqueiam a
passagem por metas numéricas.

## Passagem H1

Em cinco minutos, o Par 1 entrega ao Par 2:

1. a feature fina escolhida e o que ficou fora do escopo;
2. as regras que podem virar requisitos, com os caminhos legados;
3. dúvidas abertas que **não** devem virar EARS;
4. referências a DDMs e dependências somente quando afetarem a feature.

O Par 2 confirma que recebeu evidência suficiente para iniciar
`specs/<NNN>-<feature>/spec.md`. Se não recebeu, o time reduz o recorte; não
inventa uma fonte.

## Definição de Pronto

- [ ] Os três programas atribuídos a cada par foram lidos.
- [ ] O comportamento selecionado tem evidência em `.NSN` ou `.ddm`, ou foi
      explicitamente separado como proposta greenfield.
- [ ] O catálogo identifica a fonte de cada regra candidata.
- [ ] O relatório de descoberta registra o recorte e as dúvidas relevantes.
- [ ] A Passagem H1 ocorreu antes de 14:00.

Consulte o [checklist de exploração](LEGACY-EXPLORATION-CHECKLIST.md) para a
verificação do hard gate e o guia do próximo estágio em
[`../02-spec-moderna/GUIDE.md`](../02-spec-moderna/GUIDE.md).
