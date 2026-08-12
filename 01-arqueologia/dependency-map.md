<!-- markdownlint-disable MD013 MD033 MD041 -->

# Mapa de Dependências — SIFAP Legado

> **Trilha:** [Kit do Time](../README.md) › [Estágio 1](README.md) › **Mapa de Dependências**

**Artefato preenchido pelo time durante o Estágio 1 — Passo 3.** Registra as dependências entre programas Natural e DDMs Adabas que sustentam o recorte escolhido.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todos os pares, com liderança do Par 2 (Arquitetura) |
| **Pré-requisitos** | Catálogo de regras com fontes identificadas |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | Diagrama Mermaid e tabelas de arestas com evidência `arquivo:linha` |

> [!IMPORTANT]
> Mapeie somente as dependências que explicam o recorte escolhido: programas `.NSN` chamando outros programas (`CALLNAT`, `FETCH`) e programas acessando DDMs (`READ`, `FIND`, `STORE`, `UPDATE`, `DELETE`). Cada aresta deve ter suporte em `arquivo:linha` — nenhuma inferência sem evidência. Este mapa alimenta as hipóteses de carving do [`discovery-report.md`](discovery-report.md).

> [!NOTE]
> Guia passo a passo: [`GUIDE.md`](GUIDE.md).

**Time**: <!-- preencher -->
**Escopo**: programas e DDMs que sustentam a feature escolhida

---

## Diagrama Mermaid

```mermaid
%%{init: {'theme':'neutral','themeVariables':{'fontFamily':'ui-sans-serif, system-ui, sans-serif','primaryColor':'#F5F5F5','primaryTextColor':'#171717','primaryBorderColor':'#171717','lineColor':'#525252','secondaryColor':'#FFFFFF','tertiaryColor':'#FAFAFA','background':'#FFFFFF'}}}%%
flowchart TD
    classDef step fill:#F5F5F5,stroke:#171717,color:#171717
    classDef alt fill:#FFFFFF,stroke:#525252,color:#171717
    classDef muted fill:#FAFAFA,stroke:#A3A3A3,color:#404040
    classDef result fill:#FFFFFF,stroke:#171717,color:#171717,stroke-width:2px

    %% preencher: nós = programas e DDMs; arestas = chamadas e acessos a dados
    %% exemplo de sintaxe:
    %% PROGRAMA1 -->|"CALLNAT"| PROGRAMA2
    %% PROGRAMA1 -->|"READ"| DDM1[("DDM1")]
```

---

## Arestas Programa → Programa

| # | De | Para | Tipo (`CALLNAT`/`FETCH`) | Evidência (`arquivo:linha`) |
|---|---|---|---|---|
| 1 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

---

## Arestas Programa → DDM

| # | Programa | DDM | Operação (`READ`/`FIND`/`STORE`/`UPDATE`/`DELETE`) | Evidência (`arquivo:linha`) |
|---|---|---|---|---|
| 1 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

---

## Observações

- **Programas mais conectados (hubs):** <!-- preencher -->
- **Programas isolados ou código morto:** <!-- preencher -->
- **Ordem de dependência do batch:** <!-- preencher -->

---

## Critério de pronto

- [ ] Toda aresta relevante ao recorte cita `arquivo:linha`.
- [ ] Diagrama Mermaid gerado com cabeçalho `%%{init:...}%%` e paleta neutra.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Catálogo de Regras](business-rules-catalog.md)<br/><sub>Passo 2 — extração de regras.</sub> | [Perguntas em Aberto](mysteries-found.md)<br/><sub>Passo 4 — registro de incertezas.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
