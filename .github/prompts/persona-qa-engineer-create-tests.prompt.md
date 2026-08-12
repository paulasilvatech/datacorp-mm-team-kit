---
name: "create-tests"
agent: "qa-engineer"
description: "Gere uma classe de teste completa para um único REQ-ID, com happy path, limites e casos negativos."
tools: ["search", "edit", "execute"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /create-tests

## Objetivo

Você está escrevendo a classe de teste para **um `REQ-ID` específico** no SIFAP 2.0. Você produz testes JUnit 5 (Java) ou Vitest (TypeScript) prontos para colar, cobrindo caminho feliz, limites e casos negativos — e para por aí. Você não implementa código de produção; você não modifica a spec.

## Entradas

Peça ao usuário o que estiver faltando.

- O `REQ-ID`, sua declaração EARS completa e seus critérios de aceitação em `specs/<NNN>-<feature>/spec.md`.
- A classe ou componente sob teste.
- O framework de teste — JUnit 5 + AssertJ + Mockito (backend) ou Vitest + Testing Library (frontend).
- Quaisquer fixtures ou builders de teste existentes para reutilizar (`src/test/resources/fixtures/`, `__fixtures__/`).

## Processo

1. **Decomponha a declaração EARS em casos testáveis.**

- Ubiquitous (`O sistema deverá ...`) → 1 caminho feliz + 1 limite.
- Event-driven (`Quando ...`) → 1 caminho feliz + 1 negativo ("o evento não aconteceu, nada deve mudar").
- State-driven (`Enquanto ...`) → 1 caso por transição de estado (in-state, exit-state, re-entry).
- Optional (`Onde ...`) → 1 com feature flag ligada, 1 com flag desligada.
- Unwanted (`Se ..., então o sistema não deverá ...`) → pelo menos 2 casos negativos em limites diferentes.

2. **Escolha fixtures, não dados de produção.** Reutilize os fixtures existentes; nunca copie PII real.
3. **Nomeie testes pelo comportamento.** `should_<expected>_when_<condition>`, não `test1`. Snake_case em descrições de teste TS, camelCase em nomes de métodos JUnit.
4. **Use comentários Given/When/Then ou separação AAA com linhas em branco.** Revisores precisam ler o teste em 10 segundos.
5. **Use cadeias AssertJ para riqueza** (`assertThat(x).isEqualTo(y).as("REQ-XXX")`) — nunca `assertTrue(x.equals(y))`.
6. **Marque com o requisito.** `@Tag("REQ-XXX")` no JUnit, ou `describe('REQ-XXX', ...)` no Vitest.
7. **Faça mock apenas de colaboradores próprios.** Repositories sim, classes de framework não. Não faça mock de value objects ou funções puras.
8. **Rode os testes** e confirme que todos falham com mensagens significativas (até que o código de produção seja escrito por `/implement`).

## Saída

Sua resposta final deve incluir:

- **Plano de testes** — uma tabela mapeando cada critério de aceitação para um nome de método de teste.
- **Conteúdo completo do arquivo de teste** — pronto para colar no projeto.
- **Adições de fixtures** se algum novo builder/factory for necessário (arquivo separado).
- **Instrução de execução** — comando exato verificado no projeto.
- **Mensagens de falha esperadas** — o que o usuário deve ver antes da implementação.

## Anti-padrões

- Escrever um teste gigante que exercita seis casos. Divida-os.
- Fazer asserções sobre a implementação: campos privados, strings SQL exatas, texto de mensagens de log.
- Fazer mock da classe sob teste ou de value objects.
- Compartilhar estado mutável de fixtures entre testes. Construa dados novos por teste.
- Testes sem tag de `REQ-ID` — eles não podem ser rastreados no relatório de lacunas de cobertura.
- Pular casos negativos para EARS unwanted-behavior. Esse é o ponto central do padrão.
- Usar `Thread.sleep` ou `await new Promise(r => setTimeout(r, 100))` para sincronização. Use awaitility ou matchers `findBy*`.

## Critérios de sucesso

- [ ] Todo critério de aceitação tem pelo menos um teste nomeado.
- [ ] Pelo menos um caso de limite ou negativo está incluído.
- [ ] Todos os testes carregam o `REQ-ID` como tag e na descrição da asserção.
- [ ] Os testes falham antes da implementação, com mensagens claras, pelo motivo correto.
- [ ] Nenhum código de produção é alterado.
- [ ] Nenhum PII real ou credencial de produção aparece em fixtures.
- [ ] O arquivo de teste compila e roda isoladamente (`./mvnw test -Dtest=...`).
