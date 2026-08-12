---
name: "write-ears-spec"
description: "Conduz a equipe a registrar requisitos EARS confirmados em spec.md, com rastreabilidade obrigatória."
argument-hint: "feature=NNN-feature-name rules=01-arqueologia/business-rules-catalog.md"
agent: "architect"
tools: ["search", "edit"]
---
# /write-ears-spec

## Objetivo

Transformar somente regras confirmadas do Estágio 1 em requisitos EARS formais
em `specs/<NNN>-<feature>/spec.md`. Perguntas abertas permanecem perguntas; o
prompt não preenche requisito, critério de aceite ou arquitetura por suposição.

## Pré-condições

- `01-arqueologia/business-rules-catalog.md` contém a evidência do recorte;
- a equipe identificou a pasta `specs/<NNN>-<feature>/`;
- cada fonte foi lida pela equipe antes da redação.

## Processo

1. Confirme com a equipe quais regras pertencem à feature fina. Registre
   adiamentos em `02-spec-moderna/scope-decisions.md`.
2. Para cada regra confirmada, valide a fonte `.NSN` ou `.ddm` e só então
   proponha uma EARS testável.
3. Atribua REQ-IDs únicos e inclua em cada um `source_legacy:` com caminho e,
   quando disponível, faixa de linhas. Para capacidade sem paralelo no legado,
   use `[GREENFIELD]` com justificativa fornecida pela equipe.
4. Registre critérios Given/When/Then somente para comportamentos que a
   evidência ou a decisão de escopo sustentem.
5. Para toda pergunta ainda não validada em
   `01-arqueologia/mysteries-found.md`, preserve pergunta, evidência
   `path:linha`, impacto, hipótese não confirmada, responsável e status em
   “Open Questions”. Não a converta em requisito, não proponha resposta nem
   altere seu status.
6. Mantenha uma matriz `REQ-ID | EARS Pattern | source_legacy | Source Rule |
   Source File` no `spec.md`.

## Restrições

- Não criar requisito sem `source_legacy:`.
- Não promover hipótese ou pergunta aberta a requisito.
- Não exigir quantidade de requisitos, C4, ADRs ou endpoints: reduza o
  recorte se o tempo do Estágio 2 acabar.
- Não escrever artefatos formais em `02-spec-moderna/`.

## Definição de Pronto

- [ ] `specs/<NNN>-<feature>/spec.md` contém somente os requisitos da feature.
- [ ] Todo requisito tem EARS, critério verificável e `source_legacy:` válido
      ou `[GREENFIELD]` justificado.
- [ ] Perguntas em aberto permanecem fora dos requisitos.
- [ ] A matriz de rastreabilidade liga cada REQ-ID à evidência lida.
