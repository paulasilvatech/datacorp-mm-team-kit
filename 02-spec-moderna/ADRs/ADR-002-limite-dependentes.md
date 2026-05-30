<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# ADR-002: Limite único de dependentes (resolução da tripla divergência)

![ESTÁGIO 02 ADR](https://img.shields.io/badge/ESTÁGIO-02%20ADR-00A4EF?style=for-the-badge) ![STATUS Aceita](https://img.shields.io/badge/STATUS-Aceita-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../README.md) → **ADRs** → **ADR-002**

## Status

Aceita

## Data

2026-05-29

## Contexto

O Estágio 1 encontrou uma divergência tripla no limite de dependentes (MYS-002 / INC-001): o código `CADDEPEND.NSN#L66-L69` impõe **5**, a documentação de regras 2012 menciona **3**, e uma rotina de relatório usa **10** como teto de array. Sem uma decisão única, o requisito REQ-CAD-003 fica ambíguo e o EARS não pode ser escrito de forma testável. Esta é uma decisão de produto (PO), não puramente técnica.

## Opções Consideradas

### Opção 1: Seguir a documentação (limite = 3)

- **Prós:** alinhado ao texto normativo de 2012.
- **Contras:** quebraria beneficiários reais com 4-5 dependentes ativos hoje em produção (o código aceita 5); migração causaria rejeições em massa.

### Opção 2: Seguir o código de produção (limite = 5)

- **Prós:** comportamento real observado em 29 anos; nenhum beneficiário existente é invalidado; o "10" era apenas dimensionamento de array, não regra de negócio.
- **Contras:** diverge do texto de 2012 — exige nota de conformidade e validação com a área de programa social.

## Decisão

Adotar **limite = 5 dependentes ativos** (Opção 2), refletindo o comportamento real de produção. O valor `3` da documentação é tratado como desatualizado; o `10` é descartado como artefato de array. A regra fica em **tabela de configuração** (não hardcoded) para permitir ajuste futuro sem deploy (alinhado a INC-003).

`[NEEDS CLARIFICATION]`: confirmar com a área de programa social se há base legal para 3 vs 5 antes de produção — registrar no `/speckit.clarify`.

## Consequências

### Positivas

- REQ-CAD-003 fica testável e não invalida a base existente.
- Configurável → ajuste sem código.

### Negativas

- Divergência formal com o texto de 2012 precisa de aprovação documentada (risco de compliance — baixo, mitigado por nota).

## Requisitos Relacionados

- REQ-CAD-003 (limite de dependentes)
- REQ-CALC-002, REQ-PGTO-003 (mesma estratégia de configuração versionada)

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="ADR-001-modular-monolith.md"><strong>ADR-001</strong></a><br/>
<sub>Modular Monolith.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="ADR-003-adabas-jpa-mapping.md"><strong>ADR-003</strong></a><br/>
<sub>Mapeamento Adabas → JPA.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
