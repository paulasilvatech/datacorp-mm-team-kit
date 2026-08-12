---
name: "create-adr"
agent: "enterprise-architect"
description: "Escreva um Registro de Decisão de Arquitetura (ADR) capturando contexto, opções, decisão e consequências para uma escolha arquitetural do SIFAP 2.0."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /create-adr

## Objetivo

Você está escrevendo um **Registro de Decisão de Arquitetura** para o SIFAP 2.0 no formato usado em `specs/<NNN>-<feature>/ADRs/`. Um ADR é a resposta durável para "por que fizemos desse jeito?" Ele captura o contexto no momento da decisão, as opções consideradas, o caminho escolhido e as consequências. ADRs são imutáveis depois de aceitos — correções acontecem por meio de um *novo* ADR que substitui o anterior.

## Entradas

Peça ao usuário o que estiver faltando.

- O tópico da decisão em linguagem clara (por exemplo, "Como o SIFAP integrará com o wrapper legado de Adabas?").
- A pasta da feature onde o ADR fica (`specs/<NNN>-<feature>/ADRs/`).
- O próximo número de ADR — olhe os arquivos existentes para evitar colisões.
- Os `REQ-ID`s vinculados que a decisão afeta.
- Stakeholders que devem ser citados (architect, security, DevOps, product).
- Um rascunho da direção escolhida, mesmo que vago.

## Processo

1. **Escolha um título afiado.** Use um título guiado por verbo e com forma de decisão: "Integrar legado Adabas via adaptador REST" — não "Abordagem de integração" ou "Ideias sobre Adabas".
2. **Defina o status corretamente.**

- `Proposed` — decisão rascunhada, aguardando revisão.
- `Accepted` — aprovada pelo fórum de arquitetura, com data.
- `Superseded by NNNN` — substituída por outro ADR.
- `Rejected` — considerada e rejeitada (ainda registrada — evita rediscussão futura).

3. **Escreva o contexto com honestidade.** Quais forças estão em jogo agora? Restrições (Java 21, Postgres 16, somente Azure, regulatório)? Decisões existentes (ADRs anteriores)? Conhecidos e desconhecidos?
4. **Liste pelo menos três opções.** Inclua o status quo e uma opção "não fazer nada" se aplicável. Cada opção precisa de:

- Descrição em uma linha.
- Prós (máximo 3 bullets).
- Contras (máximo 3 bullets).
- Perfil de custo / risco em linguagem simples.

5. **Nomeie a decisão e a justificativa.** Um parágrafo para cada. Referencie a opção escolhida pelo nome.
6. **Capture consequências — positivas *e* negativas.** O que se torna possível? O que fica mais difícil? Quais novos riscos aparecem? Quais outras decisões agora ficam forçadas ou restringidas?
7. **Vincule para frente e para trás.** Cite os REQ-IDs, ADRs anteriores na mesma feature e itens inegociáveis de `.specify/memory/constitution.md` dos quais essa decisão depende.
8. **Registre a data e os signatários.** Data do fórum de arquitetura. Nomes dos aprovadores (technical lead, software architect, donos de persona afetados).

## Saída

O entregável é um único arquivo em `specs/<NNN>-<feature>/ADRs/<NNNN>-<title-slug>.md`:

```markdown
# ADR <NNNN> — <título da decisão>

- **Status**: Proposed
- **Data**: <YYYY-MM-DD>
- **Aprovadores**: <pessoas que participarão da decisão>
- **REQs vinculados**: REQ-XXX
- **ADRs vinculados**: <!-- preencher, se houver -->
- **Substitui**: <!-- preencher, se houver -->

## 1. Contexto
<!-- preencher com evidências, restrições e perguntas que a equipe forneceu -->

## 2. Opções consideradas

### Opção A — <nome>
- Prós: <!-- preencher -->
- Contras: <!-- preencher -->
- Custo/risco: <!-- preencher -->

### Opção B — <nome>
- Prós: <!-- preencher -->
- Contras: <!-- preencher -->
- Custo/risco: <!-- preencher -->

### Opção C — <nome, se aplicável>
- Prós: <!-- preencher -->
- Contras: <!-- preencher -->
- Custo/risco: <!-- preencher -->

## 3. Decisão
<!-- preencher somente após decisão explícita da equipe -->

## 4. Justificativa
<!-- preencher com a justificativa declarada pela equipe -->

## 5. Consequências
<!-- preencher com efeitos positivos, negativos e riscos confirmados -->

## 6. Validação
<!-- preencher com os critérios que a equipe acordar -->
```

## Antipadrões

- ADRs pré-cozidos que apresentam apenas a opção escolhida. Sempre liste opções rejeitadas — metade do valor está aí.
- "Escolhemos X porque é melhor." Não é justificativa; descreva as forças.
- Consequências ausentes. ADRs sem consequências enganam o você do futuro.
- Reescrever um ADR aceito. Crie um novo com status `Supersedes NNNN`.
- ADRs sem datas. Sem valor para arqueologia.
- Não vincular nada. ADRs que não citam REQ-IDs ou ADRs anteriores são isolados e pouco confiáveis.
- "Não fazer nada" nunca considerado. Às vezes a resposta certa é "depois".

## Critérios de sucesso

- [ ] Nome de arquivo segue `<NNNN>-<title-slug>.md`, número não colide.
- [ ] Status é um de `Proposed`, `Accepted`, `Superseded by NNNN`, `Rejected`.
- [ ] Data e aprovadores registrados.
- [ ] Pelo menos três opções, cada uma com prós, contras e custo/risco.
- [ ] Decisão nomeia explicitamente a opção escolhida.
- [ ] Consequências incluem positivas, negativas e riscos.
- [ ] `REQ-ID`s vinculados e ADRs anteriores citados.
- [ ] Critérios de validação incluídos para que possamos checar esta decisão depois.
