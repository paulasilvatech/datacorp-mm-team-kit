<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Checklist de Exploração do Legado

![ESTÁGIO 01 Arqueologia](https://img.shields.io/badge/ESTÁGIO-01%20Arqueologia-F25022?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S1](https://img.shields.io/badge/PREENCHA-Durante%20S1-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 1](README.md) → **LEGACY-EXPLORATION-CHECKLIST**

> **Para quem é isto?** Para o time inteiro antes de fechar o Estágio 1. **HARD GATE** — sem isto, o time não passa para o Estágio 2.
>
> **O que você terá ao final desta leitura:** matriz completa do que cada par precisa entregar.


> **HARD GATE ANTES DO ESTÁGIO 2.** Nenhum requisito EARS é aceito sem referência a um arquivo de programa Natural ou DDM. Requisitos greenfield (sem paralelo no legado) precisam ser marcados `[GREENFIELD]` e justificados por escrito na spec.
>
> Por quê? Na edição anterior do workshop, vários times pularam a exploração do legado e escreveram specs baseadas apenas no brief de modernização. O resultado foram specs que não preservavam as regras de negócio reais dos 29 anos do SIFAP. **Desta vez, o portão é obrigatório.**

---

## 1. A Regra Dura

```
Todo REQ-ID em `specs/<NNN>-<feature>/spec.md` PRECISA ter uma linha
`source_legacy:` que aponte para um dos seguintes:
 - um programa `.NSN` específico em `01-arqueologia/legado-sifap/natural-programs/` (idealmente com faixa de linhas)
 - um arquivo `.ddm` específico em `01-arqueologia/legado-sifap/adabas-ddms/`
 - `[GREENFIELD]` com justificativa de uma linha
```

O CI rejeita PRs para `develop` se algum REQ-ID estiver sem a linha `source_legacy:`.
Facilitadores verificam por amostragem na H2, às 15:00.

---

## 2. Os 15 Programas Natural — Quem Lê o Quê

Cada par fica com 3 programas. **Nenhum programa pode ficar sem leitor.**

| Par                              | Programas para ler                             | Por quê                                                                    |
| -------------------------------- | ---------------------------------------------- | -------------------------------------------------------------------------- |
| **1 · Visão** (PO + RE)          | `CADBENEF.NSN`, `CADDEPEND.NSN`, `CADPROG.NSN` | Lógica de cadastro = entidades centrais que viram sujeitos das EARS        |
| **2 · Arquitetura** (EA + SA)    | `BATCHPGT.NSN`, `BATCHREL.NSN`, `BATCHCON.NSN` | Fluxos batch revelam fronteiras de módulo (bounded contexts)               |
| **3 · Implementação** (TL + Dev) | `CALCBENF.NSN`, `CALCCORR.NSN`, `CALCDSCT.NSN` | Cálculos são onde o código moderno vai morar; vocês precisam reproduzi-los |
| **4 · Qualidade** (DBA + QA)     | `VALBENEF.NSN`, `VALDOCS.NSN`, `VALELEG.NSN`   | Validações viram testes; o DBA também mapeia campos dos DDMs               |
| **5 · Operações** (DevOps + TW)  | `CONSBENF.NSN`, `RELPGT.NSN`, `RELAUDIT.NSN`   | Caminhos de leitura alimentam o glossário e o runbook                      |

### Checklist por programa (marque em `01-arqueologia/business-rules-catalog.md`)

Para cada programa do seu par, registre notas de leitura suficientes para
confirmar que ele foi examinado:

- [ ] Nome do programa + autor + ano da última modificação
- [ ] Inputs (quais DDMs ele lê)
- [ ] Outputs (quais DDMs ele escreve)
- [ ] Outros programas que ele chama (cadeia de CALLNAT)
- [ ] Evidência de uma regra candidata ao recorte, quando o programa a contiver,
      em `business-rules-catalog.md` com `Programa Fonte` e faixa de linhas

Uma linha sem `Programa Fonte` não pode fundamentar uma EARS.

---

## 3. Os 4 DDMs — Mapeamento de Campos

O Par 4 (DBA + QA) lidera. Todos os outros pares contribuem com revisão.

| DDM                   | Dono  | Artefato-alvo em PostgreSQL |
| --------------------- | ----- | --------------------------- |
| `BENEFICIARIO.ddm`    | Par 4 | <!-- definir a partir da evidência --> |
| `PAGAMENTO.ddm`       | Par 4 | <!-- definir a partir da evidência --> |
| `PROGRAMA-SOCIAL.ddm` | Par 4 | <!-- definir a partir da evidência --> |
| `AUDITORIA.ddm`       | Par 4 | <!-- definir a partir da evidência --> |

Consulte os DDMs necessários para a feature escolhida. O mapeamento completo
para PostgreSQL pertence ao plano e à implementação; não é pré-requisito para
iniciar a spec.

---

## 4. Registro de Perguntas em Aberto

Use [`mysteries-checklist.md`](mysteries-checklist.md) para registrar perguntas em
aberto sem antecipar respostas. O catálogo é um registro de incertezas, não um
gabarito ou uma fonte de regras.

Registre em `mysteries-found.md` apenas as perguntas que afetarem o recorte. Cada
registro deve ter:

- Pergunta aberta
- Evidência (`path:linha`)
- Impacto
- Hipótese explicitamente não confirmada
- Pessoa ou área responsável
- Status

Uma pergunta só pode ser encerrada ou usada como base de regra/requisito após validação
humana explícita apoiada pela evidência registrada.

---

## 5. Verificação Antes de Abrir o Estágio 2

Por volta de 13h50 um facilitador vai checar o trabalho do seu par contra esta matriz. Não dá para passar para o Estágio 2 com linha vermelha.

| Verificação | Critério do portão |
| --- | --- |
| Leitura atribuída | Cada par confirmou a leitura dos três programas que recebeu. |
| Catálogo de regras | Cada regra candidata ao recorte tem `Programa Fonte` não vazio. |
| Recorte | O relatório de descoberta identifica uma feature pequena e o que foi adiado. |
| Perguntas abertas | Incertezas relevantes foram registradas sem virar requisitos. |

---

## 6. Formato obrigatório no Estágio 2

Escreva EARS somente em `specs/<NNN>-<feature>/spec.md`, usando o Spec-Kit.
Cada REQ-ID precisa de padrão EARS, critérios Given/When/Then e
`source_legacy:`. Não preencha requisito algum até a equipe confirmar a fonte
ou a justificativa greenfield.

---

## Navegação

| Anterior                        | Início                    | Próximo                        |
| ------------------------------- | ------------------------- | ------------------------------ |
| [Estágio 1 — README](README.md) | [Kit PT-BR](../README.md) | [GUIDE do Estágio 1](GUIDE.md) |

— Paula


---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="GUIDE.md"><strong>GUIDE do Estágio 1</strong></a><br/>
<sub>Passo a passo do estágio.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="templates/"><strong>Templates</strong></a><br/>
<sub>Templates a preencher.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>
