---
name: "design-modular-monolith"
description: "Registra no plan.md somente o design do Modular Monolith necessário para a feature selecionada."
argument-hint: "feature=NNN-feature-name"
agent: "architect"
tools: ["search", "edit"]
---
# /design-modular-monolith

## Objetivo

Registrar em `specs/<NNN>-<feature>/plan.md` apenas as decisões de design que
desbloqueiam a primeira implementação. O prompt não cria uma arquitetura
genérica, endpoints, contratos ou diagramas sem evidência na feature.

## Pré-condições

- `specs/<NNN>-<feature>/spec.md` existe e cada REQ-ID tem `source_legacy:`;
- a equipe confirmou o recorte no Estágio 2;
- a pergunta de design a resolver foi declarada.

## Processo

1. Leia `spec.md`, `plan.md` e as decisões de escopo em `02-spec-moderna/`.
2. Peça evidência para qualquer fronteira, integração ou contrato não descrito
   pela feature. Registre a dúvida; não complete lacunas por suposição.
3. Descreva no `plan.md` a menor estrutura de módulos, dados e comunicação que
   a primeira tarefa requer.
4. Crie um diagrama Mermaid ou um contrato somente quando ele resolver uma
   dúvida concreta de implementação. Referencie-o a partir do `plan.md`.
5. Relacione o design às REQ-IDs existentes e a decisões de apoio relevantes.

## Restrições

- Não sugerir microservices; a meta é um Modular Monolith.
- Não escrever código de implementação.
- Não preencher requisitos, endpoints, schemas ou decisões que a equipe não
  confirmou.
- Não usar `02-spec-moderna/` como localização de `spec.md`, `plan.md` ou
  `tasks.md`.

## Definição de Pronto

- [ ] `plan.md` descreve somente o design necessário para a feature fina.
- [ ] Cada decisão tem evidência ou uma dúvida aberta explícita.
- [ ] Qualquer artefato auxiliar está ligado ao `plan.md`.
- [ ] O plano deixa os Pares 3 e 4 iniciar a primeira tarefa sem criar escopo
      adicional.
