<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Mapa de Dependências — SIFAP Legado

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S1](https://img.shields.io/badge/PREENCHA-Durante%20S1-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **dependency-map**

> **Estágio 1 · Passo 3 (`/map-dependencies`)**
>
> Mapeie quem chama quem e quem lê/escreve o quê: programas `.NSN` → programas
> (`CALLNAT`, `FETCH`) e programas → DDMs (`READ`, `FIND`, `STORE`, `UPDATE`, `DELETE`).
> **Cada aresta deve ser apoiada por um `arquivo:linha` real — nada de chute.**
> Este mapa alimenta as hipóteses de carving do [`discovery-report.md`](discovery-report.md).
>
> 📘 **Guia passo a passo:** [`GUIDE.md`](GUIDE.md).

**Time**: <!-- preencher -->
**Escopo**: 15 programas em `legado-sifap/natural-programs/*.NSN` e 4 DDMs em `legado-sifap/adabas-ddms/*.ddm`

---

## Diagrama Mermaid

```mermaid
flowchart TD
    %% preencher: nós = programas e DDMs; arestas = chamadas e acessos a dados
    %% exemplo de sintaxe:
    %% PROGRAMA1 -->|CALLNAT| PROGRAMA2
    %% PROGRAMA1 -->|READ| DDM1[(DDM1)]
```

## Arestas Programa → Programa

| # | De | Para | Tipo (`CALLNAT`/`FETCH`) | Evidência (`arquivo:linha`) |
| - | -- | ---- | ------------------------ | --------------------------- |
| 1 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## Arestas Programa → DDM

| # | Programa | DDM | Operação (`READ`/`FIND`/`STORE`/`UPDATE`/`DELETE`) | Evidência (`arquivo:linha`) |
| - | -------- | --- | -------------------------------------------------- | --------------------------- |
| 1 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## Observações

- **Programas mais conectados (hubs):** <!-- preencher -->
- **Programas isolados ou código morto:** <!-- preencher -->
- **Ordem de dependência do batch:** <!-- preencher -->

---

✅ **Critério de pronto:** todos os 15 programas aparecem no mapa, toda aresta cita `arquivo:linha`, hubs e código morto identificados.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="business-rules-catalog.md"><strong>Catálogo de Regras</strong></a><br/>
<sub>Passo 2.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="mysteries-found.md"><strong>Mistérios Encontrados</strong></a><br/>
<sub>Passo 4.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>
