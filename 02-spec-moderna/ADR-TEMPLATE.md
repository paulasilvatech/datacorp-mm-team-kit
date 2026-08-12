<!-- markdownlint-disable MD013 MD033 MD041 -->

# ADR-XXX: Título da Decisão

> **Trilha:** [Kit do Time](../README.md) › [Estágio 2](README.md) › **ADR Template**

> [!NOTE]
> Este arquivo é um template de apoio. Copie para `ADR-NNN-titulo.md` e preencha. Não edite o original.
> Use este template quando uma decisão arquitetural bloquear o `plan.md` da feature.

![Estágio 2](https://img.shields.io/badge/Est%C3%A1gio-2%20%C2%B7%20Especifica%C3%A7%C3%A3o-171717?style=flat-square) ![Tipo Template ADR](https://img.shields.io/badge/Tipo-Template%20ADR-737373?style=flat-square)

| Campo | Valor |
|---|---|
| **Data** | `YYYY-MM-DD` |
| **Status** | Proposta / Aceita / Rejeitada / Substituída por ADR-YYY |
| **Decisores** | Nomes dos membros do time envolvidos |
| **Feature relacionada** | `specs/<NNN>-<feature>/` |

---

## Conceito: ADR (Architecture Decision Record)

Um ADR é o registro formal de uma decisão arquitetural significativa. Ele documenta o contexto que levou à decisão, as alternativas avaliadas, a opção escolhida e as consequências esperadas.

**Por que importa:** decisões técnicas tomadas oralmente durante o workshop se perdem. Um ADR de duas páginas garante que qualquer revisor de PR entenda por que o sistema foi projetado de determinada forma — sem precisar perguntar à pessoa que tomou a decisão às 14h30 num dia corrido.

**Regra de ouro:** sempre liste o "caminho não tomado". Sem isso, o ADR vira descrição de implementação, não registro de decisão.

**Quando criar:** somente quando a decisão bloquear o `plan.md`. Se a decisão cabe em um comentário de commit, não precisa de ADR.

---

## Contexto

> Descreva o problema ou necessidade que motivou esta decisão.
> Inclua restrições, requisitos e informações relevantes.
> Seja específico: "precisamos de um banco de dados" não é suficiente.

<!-- preencher -->

---

## Opções Consideradas

### Opção 1: <!-- nome -->

| Aspecto | Avaliação |
|---|---|
| **Descrição** | Como funcionaria |
| **Vantagens** | Liste |
| **Desvantagens** | Liste |

### Opção 2: <!-- nome -->

| Aspecto | Avaliação |
|---|---|
| **Descrição** | Como funcionaria |
| **Vantagens** | Liste |
| **Desvantagens** | Liste |

### Opção 3: <!-- nome, opcional -->

| Aspecto | Avaliação |
|---|---|
| **Descrição** | Como funcionaria |
| **Vantagens** | Liste |
| **Desvantagens** | Liste |

---

## Decisão

**Decidimos** <!-- ação ou escolha escolhida -->.

---

## Justificativa

> Explique por que esta opção foi escolhida em detrimento das outras.
> Conecte com requisitos, restrições e contexto.

<!-- preencher -->

---

## Consequências

### Positivas

- <!-- consequência positiva 1 -->

### Negativas

- <!-- consequência negativa 1 — e como mitigar -->

### Riscos

- <!-- risco identificado e plano de contingência -->

---

## Referências

- <!-- link ou documento relevante -->
- Requisito EARS relacionado: `REQ-XXX`

<details>
<summary><strong>Exemplo preenchido — ADR-001: banco de dados para o SIFAP 2.0</strong></summary>

| Campo | Valor |
|---|---|
| **Data** | 2026-05-10 |
| **Status** | Aceita |
| **Decisores** | Par 2 (Enterprise Architect + Software Architect) |
| **Feature relacionada** | `specs/001-pagamento-beneficio/` |

**Contexto:** O SIFAP legado usa Adabas, um banco de dados navegacional. A modernização precisa de um banco relacional compatível com JPA/Hibernate e suportado pelo time de operações.

**Opções:**
- PostgreSQL 16: open source, suporte a JSONB, Testcontainers disponível.
- MySQL 8: amplo suporte, mas menor adoção em ambientes governamentais brasileiros.

**Decisão:** PostgreSQL 16.

**Justificativa:** Adoção consolidada em sistemas públicos, suporte nativo a tipos avançados (JSONB para campos variáveis do DDM), e integração com Testcontainers sem licença adicional.

**Consequências positivas:** Testcontainers simplifica testes de integração. **Negativas:** Requer familiaridade com PostgreSQL no time de DBA.

</details>

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [GUIDE do Estágio 2](GUIDE.md)<br/><sub>Passo a passo do estágio.</sub> | [GUIDE do Estágio 2](GUIDE.md)<br/><sub>Conduza a decisão com o time.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
