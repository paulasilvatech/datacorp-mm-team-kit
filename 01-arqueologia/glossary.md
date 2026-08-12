<!-- markdownlint-disable MD013 MD033 MD041 -->

# Glossário do SIFAP Legado

> **Trilha:** [Kit do Time](../README.md) › [Estágio 1](README.md) › **Glossário**

**Artefato preenchido pelo time durante o Estágio 1.** Tabela com todos os termos, abreviações e siglas encontrados no código Natural/Adabas — base da linguagem ubíqua para o Estágio 2.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todos os pares — cada par contribui com os termos dos seus programas |
| **Pré-requisitos** | Abertura dos arquivos `.NSN` e `.ddm` atribuídos |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | 30 ou mais termos com programa-fonte e status CONFIRMADO/HIPÓTESE |

> [!NOTE]
> Guia passo a passo: [`GUIDE.md`](GUIDE.md).

---

## Por que o glossário importa

Sistemas legados têm vocabulário próprio que raramente está documentado em lugar acessível — ele está no nome das variáveis, nas abreviações de campo e nos comentários do código. Se o time do Estágio 2 não souber o que `DSCT`, `BENF`, `PE` ou `CTC` significam, escreverá uma especificação sobre o que supõe que esses termos signifiquem.

O glossário é o que transforma abreviações de 3 a 6 caracteres em linguagem ubíqua compartilhada por todo o time — e é a base para os nomes de entidades e atributos no modelo de domínio do Estágio 3.

**Erro comum:** marcar um termo como CONFIRMADO sem ter a evidência literal no código ou na documentação histórica. Se você inferiu o significado pelo contexto, marque como HIPÓTESE e indique o responsável pela validação.

---

## Como preencher

| Coluna | O que registrar |
|---|---|
| **Termo** | A abreviação ou sigla exatamente como aparece no código. |
| **Expansão** | O significado completo do termo. |
| **Programa** | Arquivo `.NSN` ou `.ddm` onde o termo foi encontrado. |
| **Contexto** | Breve explicação de como e onde o termo é usado. |
| **Status** | `CONFIRMADO` — evidência literal no código ou documentação. `HIPÓTESE` — inferido pelo contexto; aguarda validação. |

### Dica de extração com Copilot Chat

Antes de usar o prompt abaixo, cole o conteúdo de 2 a 3 arquivos `.NSN` no chat:

> "Liste todas as abreviações e siglas usadas neste código Natural. Para cada uma, sugira a expansão e marque com 'CONFIRMADO' ou 'HIPÓTESE'."

Compare a sugestão do Copilot com o que você observou diretamente no código. Se bater, registre como CONFIRMADO; caso contrário, registre como HIPÓTESE.

---

## Termos encontrados

| # | Termo | Expansão | Programa | Contexto | Status |
|---|---|---|---|---|---|
| 1 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |
| 2 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |
| 3 | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

> [!NOTE]
> Organize por domínio (cadastro, cálculo, batch, validação) se ajudar a navegação. Adicione linhas à vontade — a meta é 30 ou mais termos.

---

## Critério de pronto

- [ ] 30 ou mais termos registrados.
- [ ] Cada termo tem programa-fonte.
- [ ] Status CONFIRMADO ou HIPÓTESE atribuído a cada termo.
- [ ] Hipóteses marcadas para validação com facilitador.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [GUIDE do Estágio 1](GUIDE.md)<br/><sub>Roteiro passo a passo.</sub> | [Relatório de Descoberta](discovery-report.md)<br/><sub>Consolidação final do estágio.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
