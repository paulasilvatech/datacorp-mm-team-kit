<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Decisões de Escopo — SIFAP 2.0

![ESTÁGIO 02 Spec](https://img.shields.io/badge/ESTÁGIO-02%20Spec-00A4EF?style=for-the-badge) ![TIPO Worksheet](https://img.shields.io/badge/TIPO-Worksheet-1A1A1A?style=for-the-badge) ![PREENCHA Durante S2](https://img.shields.io/badge/PREENCHA-Durante%20S2-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 2](README.md) → **Scope Decisions**

> **Para quem é isto?** Este é um **artefato preenchido pelo time** durante o Estágio 2 (Spec Moderna).
>
> **O que você terá ao final do estágio:**
>
> 1. Este documento preenchido para sua feature
> 2. Rastreabilidade `source_legacy:` para cada REQ-ID
> 3. Sign-off do Product Owner antes da passagem H2
>
> 📘 **Guia passo a passo:** [`GUIDE.md`](GUIDE.md).


> Para cada funcionalidade encontrada no Estágio 1, decida: **Migrar**, **Descartar** ou **Evoluir**.
>
> - **Migrar**: trazer para o SIFAP 2.0 como está (mesma lógica, nova tecnologia)
> - **Descartar**: não trazer — funcionalidade obsoleta ou desnecessária
> - **Evoluir**: trazer E melhorar (nova UX, novo fluxo, nova capacidade)

**Time**: SERPRO Curitiba — Workshop Preto 00
**Data**: 29/05/2026
**Edição**: Demo
**Par 1 (Product Owner) responsável**: Par Visão (PO + RE)

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

| #   | Funcionalidade            | Decisão     | Justificativa | Regra de Negócio (BR-XXX) | Prioridade |
| --- | ------------------------- | ----------- | ------------- | ------------------------- | ---------- |
| 1   | Cadastro de Beneficiários | **Migrar**  | Volume conhecido, regras maduras, fluxo síncrono — bom MVP de strangler-fig | BR-CBENF-001, MYS-001 (status 'S'), MYS-007 (CPF 0) | Alta |
| 2   | Cadastro de Dependentes   | **Evoluir** | Resolver tripla divergência de limite (3/5/10) com regra única decidida pelo PO | BR-CDEP-004, MYS-002, INC-001 | Alta |
| 3   | Cadastro de Programas Sociais | **Migrar** | Tabela de configuração; 47 programas ativos | BR-CPROG-*, MYS-003 (Fator-K) | Alta |
| 4   | Cálculo de Benefícios     | **Migrar**  | Core do sistema; maior valor e maior risco — exige testes de equivalência | BR-CBENF-009, MYS-003/004 | Alta |
| 5   | Cálculo de Descontos      | **Evoluir** | Consolidar cap de 30% + exceção judicial; corrigir cap agregado vs prioridade | BR-CDSCT-004/013, MYS-006 | Alta |
| 6   | Correção Monetária (IPCA) | **Evoluir** | Tabela hardcoded 2013 → tabela de configuração versionada | BR-CCORR-001, INC-002 | Média |
| 7   | Processamento Batch mensal | **Migrar** | Coração operacional; preservar ordem por CPF (contrato downstream) | BR-BPGT-*, MYS-005/009 | Alta |
| 8   | Validação de CPF          | **Evoluir** | Consolidar 4 implementações divergentes em 1 validator service | BR-VAL-*, dívida técnica §3.3 | Alta |
| 9   | Validação de Elegibilidade | **Migrar** | Preservar regras; documentar backdoor Região 99 como decisão explícita | BR-VELG-004, MYS-008 | Média |
| 10  | Geração CNAB 240          | **Migrar**  | Integração bancária — alto risco se quebrar | BR-BPGT-CNAB, EGG-003 (Banco Real descartado) | Alta |
| 11  | Conciliação Bancária (BATCHCON) | **Migrar** | Match triplo; padronizar arredondamento (INC-004) | BR-BCON-*, MYS-005, INC-004 | Alta |
| 12  | Auditoria (gravação)      | **Migrar**  | Pré-requisito de compliance para qualquer mudança | BR-AUD-*, RN-011 | Alta |
| 13  | Relatório de Auditoria (RELAUDIT) | **Evoluir** | Corrigir ocultação de `ACAO='EX'` (achado de compliance) | BR-RA-MISTERIO-01, MYS-010 | Alta |
| 14  | Relatórios analíticos (RELPGT) | **Evoluir** | Layout mainframe 132×66 → export PDF/CSV web | BR-RELPGT-*, dívida técnica §3.3 | Baixa |
| 15  | Consulta online (CONSBENF) | **Evoluir** | Corrigir bug de máscara de CPF conhecido | BR-CONS-*, bug Par 5 | Média |
| 16  | Bloco Plano Verão (1989-91) | **Descartar** | Código morto desde 1991 | EGG-001 | Baixa |
| 17  | Bloco Banco Real (356)    | **Descartar** | Integração extinta desde 2007 (manter nota em ADR) | EGG-003 | Baixa |
| 18  | Campos biométricos órfãos | **Descartar** | `HASH-DIGITAL` nunca foi preenchido | MYS extra (biometria) | Baixa |
| 19  | Backdoor VALDOCS          | **Descartar** | Bug de produção que pula dígito verificador | EGG-002 | Média |

---

## Funcionalidades Novas (não existem no legado)

> Cada uma vira REQ-ID com `source_legacy: [GREENFIELD] <justificativa>`.

| #   | Funcionalidade Nova | Justificativa | Prioridade | Complexidade |
| --- | ------------------- | ------------- | ---------- | ------------ |
| N1  | API REST versionada (`/api/v1/*`) | Legado só tem transações online mainframe; integração moderna exige REST | Alta | Média |
| N2  | Autenticação OAuth2/JWT + perfis | Legado usa perfil mainframe; Spring Security moderniza | Alta | Média |
| N3  | Tabelas de configuração versionadas (regiões, faixas, IPCA, Fator-K) | Hoje hardcoded sem versionamento; corrige INC-003 | Alta | Média |
| N4  | Auditoria com archive automático + particionamento | 25M registros sem purge; particionar por ano | Média | Alta |
| N5  | Dashboard de conciliação web | Substitui leitura de relatório 132×66 | Baixa | Média |

---

## Resumo de Escopo

| Decisão   | Quantidade | Percentual |
| --------- | ---------- | ---------- |
| Migrar    | 8          | 42%        |
| Descartar | 4          | 21%        |
| Evoluir   | 7          | 37%        |
| **Total** | 19         | 100%       |

## Riscos de Escopo

| Risco | Probabilidade | Impacto | Mitigação |
| ----- | ------------- | ------- | --------- |
| Fator-K (MYS-003) sem validação jurídica trava o cálculo | Alta | Alto | Entrevista jurídica antes do `/speckit.specify`; `[NEEDS CLARIFICATION]` no REQ |
| Tripla divergência de dependentes (MYS-002) sem decisão do PO gera EARS ambíguo | Alta | Alto | PO decide o valor único nesta planilha (decisão: **5**, ver ADR-002) |
| Correção de RELAUDIT (MYS-010) pode escalar para TCU | Média | Alto | Feature-flag + auditoria retroativa; comunicar compliance |
| Sistemas downstream não mapeados quebram na mudança de ordem batch (MYS-009) | Média | Alto | Preservar ordenação por CPF; escopo defensivo no EARS |
| 180M registros em PAGAMENTO impactam performance | Alta | Médio | Particionamento decidido no ADR-001 antes da implementação |

## Aprovação

- [x] Par 1 (Product Owner) aprovou as decisões de escopo
- [x] Par 2 (Enterprise Architect) validou a viabilidade técnica
- [x] Par 3 (Technical Lead) confirmou que cabe nas 3 horas do Estágio 3 (escopo demo: contextos Cadastro + Cálculo)
- [x] Time concordou com as prioridades

> **Decisão de escopo da demo (Estágio 3):** implementar **Bounded Context Cadastro** (beneficiário + dependente + validação CPF) como vertical slice completa (Java + Next.js + testes), com stubs para os demais contextos.

— Paula


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

