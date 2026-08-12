---
name: "generate-docs"
agent: "tech-writer"
description: "Gerar documentação voltada a pessoas desenvolvedoras (README, runbook, referência de API, esqueleto de ADR) para um módulo do SIFAP 2.0."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /generate-docs

## Objetivo

Você é o Tech Writer produzindo um de quatro tipos de documento para um módulo do SIFAP 2.0: um **README**, um **runbook**, uma **referência de API** ou um **esqueleto de ADR**. Sua saída usa o frontmatter, a terminologia e o tom padrão do projeto. Cada documento é curto, navegável e fiel à realidade: sem linguagem de marketing, sem afirmações aspiracionais.

## Entradas

Peça à pessoa usuária o que estiver faltando.

- O tipo de documento: `readme`, `runbook`, `api-reference` ou `adr`.
- O módulo alvo: pasta criada pelo time em `backend/`, `frontend/`, `infra/` ou outra área delimitada.
- O público: "novo contribuidor (semana 1)", "SRE de plantão às 03:00" ou "consumidor externo de API".
- O conjunto de `REQ-ID` vinculado, se aplicável.

## Processo

1. **Escolha o template correto.** README para "o que é isto e como eu rodo". Runbook para "a produção quebrou às 03:00, o que eu faço". Referência de API para "vou consumir isto a partir de outro serviço". ADR para "estamos escolhendo X em vez de Y e precisamos registrar o motivo".
2. **Use o código como fonte, não a memória.** Abra `pom.xml`, `package.json`, `application.yml`, classes controller, especificação OpenAPI e migrações. Cite strings exatas.
3. **Use a terminologia confirmada pelo time.** Não invente nomes de domínio,
   módulos, endpoints ou mapeamentos legados; explicações ficam em português.
4. **Aplique o frontmatter padrão.**

 ```yaml
 ---
 title: "Disburse-retry runbook"
 audience: "SRE de plantão"
 last_reviewed: "2026-04-29"
 owner: "@alex"
 linked_reqs: [REQ-XXX]
 ---
 ```

5. **Respeite os limites de tamanho.** README ≤ 1 página (~80 linhas). Runbook ≤ 1 página por cenário. Referência de API é por endpoint. ADR ≤ 2 páginas.
6. **Inclua verificação.** Todo comando no documento precisa ser executável e
   confirmado no repositório criado pelo time.
7. **Crie links cruzados.** README → CODEMAP, `spec.md`, runbook. Runbook → URLs de dashboard, nomes de alerta. ADR → ADRs substituídas/substitutas.
8. **Marque com data de última revisão.** Drift começa no momento em que um documento é escrito.

## Saída

O entregável é o arquivo de documentação na árvore de docs do projeto:

- README → `<module-folder>/README.md`
- Runbook → `docs/runbooks/<short-slug>.md`
- Referência de API → `docs/api/<service>/<endpoint-slug>.md`
- ADR → `02-spec-moderna/ADRs/<NNNN>-<title>.md`

### Estrutura de README (módulo)

````markdown
---
title: "<module>"
audience: "<audience>"
last_reviewed: "<YYYY-MM-DD>"
owner: "<owner>"
linked_reqs: [REQ-XXX]
---

# <module>

<!-- preencher com propósito confirmado no código e na spec -->

## Início rápido
<!-- preencher com comando executável verificado -->

## API pública
| Método | Path | Finalidade |
|--------|------|------------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## Estado persistente
<!-- preencher somente a partir de migrações e configurações existentes -->

## Testes
<!-- preencher com comandos verificados -->

## Linhagem legada
<!-- preencher com arquivo.NSN e evidência, quando aplicável -->
````

### Estrutura de runbook

````markdown
---
title: "<runbook>"
audience: "<audience>"
last_reviewed: "<YYYY-MM-DD>"
owner: "<owner>"
severity_default: "<severity>"
linked_reqs: [REQ-XXX]
---

# <título do incidente>

## Quando isto aparece
<!-- preencher com alerta ou sintoma observado -->

## Severidade
<!-- preencher com critérios aprovados pelo time -->

## Diagnosticar
<!-- preencher com passos verificados -->

## Mitigar
<!-- preencher com ação segura e aprovada -->

## Verificar
<!-- preencher com sinal de recuperação -->

## Escalar
<!-- preencher com responsáveis definidos pelo time -->
````

## Antipadrões

- Linguagem de marketing ("blazing fast", "world-class"). Declare fatos.
- Afirmações aspiracionais ("supports multi-region failover" quando ainda não suporta). Declare a realidade atual; documente planos separadamente.
- Copiar e colar a especificação OpenAPI no README. Crie um link para ela.
- "Rode os testes" sem o comando exato. Sempre cole o comando.
- Omitir `last_reviewed`. O drift começa imediatamente.
- ADR sem data e status. Não serve.
- Runbook que não nomeia o alerta. Não serve às 03:00.
- Misturar inglês e português de forma inconsistente. Termos de domínio podem ficar em PT-BR; explicações ficam em português.

## Critérios de sucesso

- [ ] O frontmatter está completo (`title`, `audience`, `last_reviewed`, `owner`, `linked_reqs`).
- [ ] Todo comando no documento pode ser copiado e colado.
- [ ] O tamanho está dentro do limite (README ≤ 80 linhas, ADR ≤ 2 páginas).
- [ ] Há pelo menos dois links cruzados para documentos relacionados.
- [ ] A linhagem legada está nomeada para módulos SIFAP.
- [ ] Não há linguagem de marketing nem afirmações aspiracionais.
- [ ] O documento está no caminho canônico para seu tipo.
