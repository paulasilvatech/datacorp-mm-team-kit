---
name: "routing-table"
agent: "tech-lead"
description: "Gere uma tabela de roteamento de tarefa por perfil de capacidade"
tools: ["search"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /routing-table

## Tarefa
Produza uma tabela de roteamento que mapeia tarefas do SDLC para o perfil de capacidade necessário e explica o trade-off custo/qualidade, sem fixar uma capacidade ou fornecedor.

## Passos
1. Leia `specs/<NNN>-<feature>/tasks.md` (ou o backlog) e categorize cada tarefa como: Descoberta, Design, Implementação, Refactor, Review, Mechanical.
2. Para cada categoria, recomende um perfil:
 - Descoberta / design ambíguo: raciocínio aprofundado.
 - Implementação / code review: implementação.
 - Edições mecânicas / renomes em massa / formatação: mecânico.
3. Para cada tarefa, estime o custo de tokens (ordem de grandeza aproximada) e justifique o perfil em uma frase.
4. Sinalize tarefas em que um perfil mais econômico é suficiente, sem comprometer a qualidade aceitável. A pessoa usuária decide o contexto de execução no momento da execução.

## Saída
Tabela Markdown: `Task ID | Category | Perfil de capacidade | Rationale | Est. Cost Tier`.

## Gate de Qualidade
- [ ] Toda tarefa tem perfil de capacidade e justificativa
- [ ] Pelo menos um candidato a perfil mecânico identificado (ou anotado como "none applicable")
- [ ] Níveis de custo são consistentes (a mesma categoria raramente usa níveis diferentes)
- [ ] A justificativa referencia o conteúdo da tarefa, não linguagem genérica
