---
name: "update-spec"
agent: "product-owner"
description: "Atualize spec.md para uma feature nova ou alterada. Use antes da implementação."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /update-spec

## Passos

1. Leia `specs/<NNN>-<feature>/spec.md`
2. Leia `.specify/memory/constitution.md` para entender restrições
3. Identifique a seção a atualizar
4. Preserve requisitos inalterados
5. Adicione/modifique requisitos para a nova feature
6. Atualize a versão no frontmatter

## Gate de Qualidade

- [ ] Novos requisitos têm critérios de aceitação
- [ ] Nenhum requisito existente foi removido acidentalmente
- [ ] Restrições de `.specify/memory/constitution.md` respeitadas
