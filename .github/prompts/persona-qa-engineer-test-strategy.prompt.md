---
name: "test-strategy"
agent: "qa-engineer"
description: "Escreva uma estratégia de testes para uma feature do SIFAP 2.0: camadas da pirâmide, escolhas de framework, ambientes e critérios de saída."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /test-strategy

## Objetivo

Você é um QA lead escrevendo a estratégia de testes para uma feature do SIFAP 2.0. A estratégia diz ao time **o que testar, em qual camada, com qual ferramenta, contra qual ambiente e como sabemos que terminamos**. Ela é aprovada pelo Technical Lead depois de `/speckit.tasks` e antes de `/speckit.implement`, e fica em `specs/<NNN>-<feature>/TEST-STRATEGY.md`.

## Entradas

Peça ao usuário o que estiver faltando.

- A pasta da feature (`specs/<NNN>-<feature>/`) com `spec.md` e `plan.md` já aprovados.
- O perfil de risco definido pelo time.
- Restrições: orçamento de tempo, minutos de CI paralelo, ambientes disponíveis (`local`, `dev`, `stage`, `prod-shadow`).
- Quaisquer requisitos não funcionais com limites mensuráveis (latência p95, throughput, RPO/RTO).

## Processo

1. **Classifique cada `REQ-ID` por camada de teste.** Use a pirâmide de testes:

- **Unit** — funções puras, calculadoras e validadores.
- **Integration** — adapters: repositories, filas e serviços externos.
- **Contract** — testes consumer/provider de API (frontend ↔ backend, backend ↔ wrapper Adabas externo).
- **End-to-end** — apenas jornadas críticas de usuário definidas pelo time.
- **Non-functional** — performance, segurança, acessibilidade, observabilidade.

2. **Escolha ferramentas por camada.** JUnit 5 + AssertJ + Mockito (unit/integration backend), Testcontainers (integration), Pact (contract), Playwright (E2E), k6 (load), OWASP ZAP (security baseline), axe-core (a11y).
3. **Defina a estratégia de dados de teste.** Dados sintéticos para happy paths, snapshots legados anonimizados para casos de borda, seeds determinísticas para testes property-based. Nenhum PII de produção em qualquer ambiente.
4. **Mapeie testes para ambientes.** Unit/integration a cada push (CI). Contract em PR para `develop`. E2E noturno em `stage`. Performance semanal em `prod-shadow`.
5. **Defina critérios de saída.** Por camada: cobertura mínima de `REQ-IDs` (não de linhas), taxa máxima de flakiness, runtime p95 máximo.
6. **Identifique riscos e mitigações.** Dependências externas flaky, suítes de teste lentas, vazamento de dados, drift de ambiente.
7. **Escreva a estratégia como `TEST-STRATEGY.md`.**

## Saída

O entregável é um arquivo markdown com esta estrutura:

```markdown
# Test Strategy — <feature>

## 1. Scope
In scope: <!-- preencher com REQ-IDs -->
Out of scope: <!-- preencher -->

## 2. Risk profile
<!-- preencher com riscos e evidências confirmadas -->

## 3. Test pyramid

| Layer | Framework | Coverage target | Where it runs |
|--------------|--------------------------|---------------------------|---------------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## 4. Data strategy
<!-- preencher com dados, anonimização e restrições aprovadas -->

## 5. Environments
<!-- preencher com ambientes disponíveis -->

## 6. Exit criteria
<!-- preencher com critérios mensuráveis aprovados pelo time -->

## 7. Risks
<!-- preencher com riscos observados e mitigações -->

## 8. Schedule
<!-- preencher com a sequência de execução -->
```

## Anti-padrões

- Uma meta de 100% de cobertura de linhas sem meta de cobertura de requisitos. Linhas são fáceis; comportamentos não.
- Testes E2E para tudo. Eles são lentos, flaky e um lugar ruim para verificar lógica de ramificação.
- Pular a camada de contrato entre frontend e backend. Quebras em PR custarão mais do que isso economiza.
- Usar dados de produção em qualquer ambiente não produtivo. Risco LGPD / regulatório.
- Definir critérios de saída como "todos os testes passam" — isso é uma tautologia.
- Escolher ferramentas que o time ainda não usou no meio da sprint. A estratégia reflete a realidade.

## Critérios de sucesso

- [ ] Todo `REQ-ID` é mapeado para exatamente uma camada primária (com secundária opcional).
- [ ] Cada camada tem uma ferramenta nomeada, uma meta de cobertura e um orçamento de runtime.
- [ ] A estratégia de dados proíbe explicitamente PII de produção em não produção.
- [ ] Os critérios de saída são mensuráveis e delimitados no tempo.
- [ ] Os riscos têm owners nomeados e datas de mitigação.
- [ ] O documento é curto o suficiente (< 3 páginas) para que o time inteiro realmente leia.
