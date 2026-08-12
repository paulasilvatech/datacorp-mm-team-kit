<!-- markdownlint-disable MD013 MD033 MD041 -->

# Catálogo de Regras de Negócio — SIFAP Legado

> **Trilha:** [Kit do Time](../README.md) › [Estágio 1](README.md) › **Catálogo de Regras de Negócio**

**Artefato preenchido pelo time durante o Estágio 1.** Cada par extrai as regras dos programas `.NSN` atribuídos e registra aqui com rastreabilidade obrigatória ao programa-fonte.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todos os pares — cada par preenche a seção do seu programa |
| **Pré-requisitos** | Leitura dos programas `.NSN` atribuídos |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | Catálogo com `Programa Fonte` preenchido em cada regra candidata |

> [!NOTE]
> Cada regra cita o programa-fonte com faixa de linhas (`arquivo.NSN:Lstart-Lend`) e é classificada como **Confirmada** (cruza com a documentação histórica em `legado-sifap/legacy-docs/`), **Inferida** (somente do código) ou **Mistério** (pergunta em aberto — registre também em [`mysteries-found.md`](mysteries-found.md) com evidência `path:linha`, hipótese não confirmada, responsável e status).

> [!IMPORTANT]
> Guia passo a passo: [`GUIDE.md`](GUIDE.md).

**Time**: <!-- preencher -->

---

## Regras de `<preencher: PROGRAMA.NSN>`

| # | Declaração da Regra | Candidata EARS | Fonte | Classificação | Observações |
|---|---|---|---|---|---|
| 1 | <!-- preencher --> | <!-- preencher: padrão EARS --> | <!-- preencher: arquivo:linha --> | <!-- preencher: Confirmada/Inferida/Mistério --> | <!-- preencher --> |

> [!NOTE]
> Duplique a seção acima para cada programa `.NSN` lido pelo seu par.

---

## Resumo geral

| Métrica | Valor |
|---|---:|
| Programas Natural lidos | <!-- preencher --> |
| DDMs cruzados | <!-- preencher --> |
| Regras Confirmadas | <!-- preencher --> |
| Regras Inferidas | <!-- preencher --> |
| Mistérios | <!-- preencher --> |

---

## Critério de pronto

- [ ] Todo bloco condicional dos programas atribuídos foi examinado.
- [ ] Cada regra cita `arquivo:linha`.
- [ ] Toda pergunta em aberto está registrada em `mysteries-found.md` sem conclusão.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Inventário](inventory.md)<br/><sub>Passo 1 — varredura de arquivos.</sub> | [Mapa de Dependências](dependency-map.md)<br/><sub>Passo 3 — grafo de chamadas e acessos.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
