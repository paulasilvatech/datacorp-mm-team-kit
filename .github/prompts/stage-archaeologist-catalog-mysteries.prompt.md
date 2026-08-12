---
name: "catalog-mysteries"
description: "Registra perguntas em aberto com evidência rastreável, sem tentar resolvê-las."
argument-hint: "scope=01-arqueologia/"
agent: "archaeologist"
tools: ["search", "edit"]
---
# /catalog-mysteries

## Objetivo

Registrar perguntas em aberto do Estágio 1 em uma estrutura neutra e rastreável. O
catálogo não responde perguntas, não confirma hipóteses e não promove descobertas.

## Quando invocar

Depois que uma pessoa da equipe tiver identificado uma pergunta em aberto e puder
fornecer ou apontar a evidência disponível.

## Pré-condições

- A pessoa solicitante informa os artefatos autorizados para consulta.
- O legado em `01-arqueologia/legado-sifap/` está disponível somente para leitura.
- Cada registro contém ou aguarda uma evidência no formato `path:linha`.

## O que vou fazer

- Registrar cada pergunta sem fornecer uma resposta.
- Copiar a evidência disponível como `path:linha`.
- Preservar impacto, hipótese explicitamente não confirmada, pessoa/área responsável e status.
- Manter a pergunta aberta quando a validação humana ou a evidência estiver ausente.

## O que não vou fazer

- Resolver, explicar, confirmar ou inferir uma resposta para um mistério.
- Tratar uma hipótese como fato ou alterar seu status por conta própria.
- Sugerir uma solução, caminho de investigação ou requisito derivado da pergunta.
- Modificar qualquer arquivo sob `01-arqueologia/legado-sifap/`.
- Remover evidência ou rastreabilidade fornecida pela equipe.

## Formato de saída

Atualize somente `01-arqueologia/mysteries-found.md` com esta estrutura:

```markdown
| Pergunta aberta | Evidência (`path:linha`) | Impacto | Hipótese (não confirmada) | Pessoa/área responsável | Status |
| --------------- | ------------------------ | ------- | ------------------------- | ----------------------- | ------ |
|                 |                         |         |                           |                         |        |
```

Não adicione classificações, severidade, respostas, exemplos ou recomendações.

## HARD GATE e rastreabilidade

Uma pergunta não pode ser marcada como encerrada, convertida em regra de negócio ou
usada em requisito até que uma pessoa responsável forneça validação humana explícita,
apoiada por evidência em `path:linha`. O agente apenas registra essa informação; nunca
a produz ou a confirma.

## Definição de pronto

- [ ] Cada linha contém os seis campos da estrutura de registro.
- [ ] Toda evidência disponível usa `path:linha`.
- [ ] Toda hipótese é explicitamente marcada como não confirmada.
- [ ] Cada linha indica uma pessoa ou área responsável e um status.
- [ ] Nenhuma linha contém resposta, conclusão ou solução gerada pelo agente.
- [ ] Nenhum arquivo legado foi modificado.

## Exemplo de invocação

```text
/catalog-mysteries scope=01-arqueologia/
```
