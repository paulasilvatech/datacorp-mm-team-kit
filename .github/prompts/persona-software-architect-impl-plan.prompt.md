---
name: "impl-plan"
agent: "software-architect"
description: "Estruture o plan.md da feature com tarefas por fases e perfis de capacidade"
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /impl-plan

## Tarefa

Estruture `specs/<NNN>-<feature>/plan.md` para sequenciar tarefas em fases, marcar trabalho paralelizável, registrar o perfil de capacidade necessário por tarefa e definir critérios de saída.

## Passos

1. Leia `spec.md`, `plan.md` e `tasks.md` da feature.
2. Agrupe tarefas em fases com base na ordem de dependências (fundação → features → hardening).
3. Dentro de cada fase, marque tarefas como `[P]` paralelizáveis se tocarem arquivos disjuntos e não tiverem dependência de runtime.
4. Atribua um perfil de capacidade por tarefa: raciocínio aprofundado (arquitetural), implementação ou mecânico. A pessoa usuária define o contexto de execução ao executar a tarefa.
5. Defina uma Definição de Pronto por fase: testes passando, docs atualizadas, code review completo.

## Saída

Uma seção de `plan.md` com:

- Títulos de fase, cada um com objetivo, estimativa de duração e critérios de saída
- Tabela de tarefas por fase: `Task ID | Title | [P] | Perfil de capacidade | Est. Effort | Traces To (REQ-ID)`
- Seção de riscos globais com mitigações

## Gate de Qualidade

- [ ] Toda tarefa rastreia para pelo menos um REQ-ID
- [ ] Tarefas `[P]` realmente tocam arquivos independentes (verificado por grep)
- [ ] Critérios de saída de fase são mensuráveis
- [ ] Nenhuma tarefa é maior que 1 dia de esforço sem decomposição
