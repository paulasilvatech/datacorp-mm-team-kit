<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Decisões de Escopo — SIFAP 2.0

![ESTÁGIO 02 Spec](https://img.shields.io/badge/ESTÁGIO-02%20Spec-00A4EF?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S2](https://img.shields.io/badge/PREENCHA-Durante%20S2-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 2](README.md) → **Scope Decisions**

> **Para quem é isto?** Este é um **artefato preenchido pelo time** durante o Estágio 2 (Spec Moderna).
>
> **O que você terá ao final do estágio:**
>
> 1. Decisão Migrar/Descartar/Evoluir para cada funcionalidade do legado
> 2. Lista de funcionalidades novas com justificativa `[GREENFIELD]`
> 3. Sign-off do Product Owner antes da passagem H2
>
> 📘 **Guia passo a passo:** [`GUIDE.md`](GUIDE.md).


> Para cada funcionalidade encontrada no Estágio 1, decida: **Migrar**, **Descartar** ou **Evoluir**.
>
> - **Migrar**: trazer para o SIFAP 2.0 como está (mesma lógica, nova tecnologia)
> - **Descartar**: não trazer — funcionalidade obsoleta ou desnecessária
> - **Evoluir**: trazer E melhorar (nova UX, novo fluxo, nova capacidade)

**Time**: <!-- preencher -->
**Data**: <!-- preencher: YYYY-MM-DD -->
**Edição**: <!-- preencher -->
**Par 1 (Product Owner) responsável**: <!-- preencher -->

## Por que isso importa

O escopo é o que protege o time de chegar às 17h00 com 12 features pela metade. Se o Par 1 não cortar, o Estágio 3 não fecha. **Decisão difícil é tomada aqui, não no Estágio 3.**

## Como decidir

Pergunte de cada funcionalidade:

1. **Afeta o ciclo mensal de pagamento?** Sim → Migrar. Não → considere descartar.
2. **Tem uso documentado nos últimos 12 meses?** Não → descartar.
3. **Faz parte de um relatório regulatório obrigatório (TCU, CGU, BB)?** Sim → Migrar como está.
4. **Tem uma versão moderna mais barata de implementar?** Sim → Evoluir.

---

## Decisões por Funcionalidade

> Liste aqui as funcionalidades que o time identificou no Estágio 1 (fonte: `01-arqueologia/discovery-report.md` e `business-rules-catalog.md`).

| #   | Funcionalidade            | Decisão     | Justificativa | Regra de Negócio (BR-XXX) | Prioridade |
| --- | ------------------------- | ----------- | ------------- | ------------------------- | ---------- |
| 1   | <!-- preencher --> | <!-- Migrar / Descartar / Evoluir --> | <!-- preencher --> | <!-- preencher --> | <!-- Alta / Média / Baixa --> |
| 2   | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |
| 3   | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

---

## Funcionalidades Novas (não existem no legado)

> Cada uma vira REQ-ID com `source_legacy: [GREENFIELD] <justificativa>`.

| #   | Funcionalidade Nova | Justificativa | Prioridade | Complexidade |
| --- | ------------------- | ------------- | ---------- | ------------ |
| N1  | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

---

## Resumo de Escopo

| Decisão   | Quantidade | Percentual |
| --------- | ---------- | ---------- |
| Migrar    | <!-- preencher --> | <!-- preencher --> |
| Descartar | <!-- preencher --> | <!-- preencher --> |
| Evoluir   | <!-- preencher --> | <!-- preencher --> |
| **Total** | <!-- preencher --> | 100% |

## Riscos de Escopo

| Risco | Probabilidade | Impacto | Mitigação |
| ----- | ------------- | ------- | --------- |
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## Aprovação

- [ ] Par 1 (Product Owner) aprovou as decisões de escopo
- [ ] Par 2 (Enterprise Architect) validou a viabilidade técnica
- [ ] Par 3 (Technical Lead) confirmou que o escopo cabe nas horas do Estágio 3
- [ ] Time concordou com as prioridades

> 💡 **Dica de escopo:** para caber no dia, escolha 1–2 bounded contexts para implementar como vertical slice completa (backend + frontend + testes) e deixe os demais como stubs. Registre a escolha aqui.

---

✅ **Critério de pronto:** toda funcionalidade do Estágio 1 tem decisão + justificativa, funcionalidades novas justificadas como `[GREENFIELD]`, resumo fecha 100%, 4 aprovações marcadas.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="GUIDE.md"><strong>GUIDE do Estágio 2</strong></a><br/>
<sub>Passo a passo do estágio.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="ADR-TEMPLATE.md"><strong>ADR-TEMPLATE</strong></a><br/>
<sub>Template de ADR.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>
