---
name: "update-codemap"
agent: "tech-writer"
description: "Gerar ou atualizar CODEMAP.md — um índice navegável da base de código do SIFAP 2.0 mostrando módulos, proprietários e pontos de entrada."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /update-codemap

## Objetivo

Você produz ou atualiza `docs/CODEMAP.md`, um guia de navegação de uma página que uma nova pessoa do time consegue ler em 10 minutos e usar para encontrar qualquer módulo, seu proprietário, seus pontos de entrada e seus testes. O codemap **não** é documentação gerada automaticamente; ele é curado. Ele complementa `plan.md` (arquitetura) e a spec (requisitos).

## Entradas

Peça à pessoa usuária o que estiver faltando.

- O caminho raiz do repositório (este workspace).
- Se deve atualizar no lugar (`update`) ou reconstruir (`rebuild`).
- A tabela de proprietários das personas, quando criada pelo time.
- Uma versão anterior de `CODEMAP.md`, se existir.

## Processo

1. **Liste as pastas de serviço de nível superior.** Serviços backend em `backend/src/main/java/br/gov/sifap/<service>/`, rotas frontend em `frontend/app/<route>/`, infra em `infra/modules/<name>/` ou no layout criado pelo time.
2. **Para cada módulo, capture cinco fatos.**
 - Propósito (uma frase).
 - Pontos de entrada públicos (endpoints REST, rotas de página, comandos CLI, entradas de IaC).
 - Estado persistente (tabelas, filas, blob containers).
 - Faixas de `REQ-ID` vinculadas.
 - Persona proprietária.
3. **Encontre testes.** Para cada módulo, encontre o diretório de testes correspondente e crie um link para ele.
4. **Encontre o mapeamento legado.** Quando um módulo corresponder a um programa
   Natural de `01-arqueologia/legado-sifap/natural-programs/`, cite o arquivo e a
   evidência confirmados pelo time. Isso explicita a linhagem da modernização.
5. **Encontre dependências não óbvias.** Imports entre módulos, bibliotecas compartilhadas (`commons-*`) e serviços externos do Azure. Destaque qualquer módulo que dependa de mais de três outros, pois isso é um cheiro de design.
6. **Ordene módulos por valor visível à pessoa usuária.** Caminhos críticos de uso
   primeiro, módulos de suporte depois, infraestrutura por último.
7. **Renderize como um único arquivo markdown navegável.** Mantenha abaixo de 200 linhas. Se passar disso, divida sub-codemaps por área de serviço e crie links para eles.

## Saída

O entregável é `docs/CODEMAP.md` (ou subarquivos), com esta estrutura:

```markdown
# Mapa do Código do SIFAP 2.0

> Última atualização: <YYYY-MM-DD>. Donos: <referência criada pelo time>.

## 1. Guia de leitura
- Caminhos críticos: <!-- preencher a partir do código -->
- Veja `plan.md` para o racional arquitetural; veja `spec.md` para requisitos.

## 2. Serviços de backend

### <módulo> — <propósito confirmado>
- **Path**: `<path criado pelo time>`
- **Testes**: `<path de testes>`
- **Pontos de entrada**: <!-- preencher -->
- **Estado**: <!-- preencher a partir do schema e da configuração -->
- **REQ-IDs**: <!-- preencher -->
- **Dono**: <!-- preencher -->
- **Linhagem legada**: <!-- preencher com fonte e evidência, quando aplicável -->
- **Dependências entre módulos**: <!-- preencher -->

## 3. Rotas de frontend

### <rota> — <propósito confirmado>
- **Path**: `<path criado pelo time>`
- **Testes**: `<path de testes>`
- **REQ-IDs**: <!-- preencher -->
- **Dono**: <!-- preencher -->
- **Consome API de**: <!-- preencher -->

## 4. Módulos de infraestrutura

### <módulo>
- **Path**: `<path criado pelo time>`
- **REQ-IDs**: <!-- preencher -->
- **Dono**: <!-- preencher -->

## 5. Bibliotecas transversais
- <!-- preencher somente com bibliotecas existentes -->

## 6. Pontos de atenção observados
- <!-- preencher somente com achados observados -->

## 7. Como atualizar este arquivo
Rode `/update-codemap` após adicionar ou renomear qualquer módulo. Não gere automaticamente; faça curadoria.
```

## Antipadrões

- Gerar a partir de `find . -type d`: isso é uma listagem de diretórios, não um mapa.
- Incluir todos os arquivos. O codemap nomeia módulos, não linhas.
- Listar endpoints como `*`. Seja específico.
- Esquecer a coluna de linhagem legada para SIFAP. Modernização sem linhagem fica invisível.
- Usar times como proprietários. A pessoa de plantão é a proprietária.
- Pular a seção "Smells observados". O codemap também é uma verificação de saúde.
- Deixar o arquivo sofrer drift por mais de 30 dias. Codemap desatualizado é pior que nenhum codemap.

## Critérios de sucesso

- [ ] Todo serviço backend, rota frontend e módulo IaC está listado.
- [ ] Cada entrada tem Finalidade, Path, Testes, Pontos de entrada, Estado, REQ-IDs, Owner.
- [ ] A linhagem legada está nomeada para qualquer módulo que mapeie para um programa Natural.
- [ ] Dependências entre módulos estão declaradas; módulos com > 3 dependências estão sinalizados.
- [ ] O arquivo permanece abaixo de 200 linhas (ou é dividido com subarquivos vinculados).
- [ ] A data de última atualização está definida como hoje.
- [ ] Os nomes das personas proprietárias correspondem a `pt-br/05-personas/`.
