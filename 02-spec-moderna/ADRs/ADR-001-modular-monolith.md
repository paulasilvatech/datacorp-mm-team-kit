<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# ADR-001: Arquitetura-alvo Modular Monolith

![ESTÁGIO 02 ADR](https://img.shields.io/badge/ESTÁGIO-02%20ADR-00A4EF?style=for-the-badge) ![STATUS Aceita](https://img.shields.io/badge/STATUS-Aceita-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../README.md) → **ADRs** → **ADR-001**

## Status

Aceita

## Data

2026-05-29

## Contexto

O SIFAP legado é um monólito Natural/Adabas de 29 anos, com 15 programas fortemente acoplados via dados compartilhados no Adabas (FKs implícitas, sem fronteiras). A modernização precisa de fronteiras claras (4 bounded contexts — ver [bounded-contexts.md](../../specs/002-sifap-moderno/bounded-contexts.md)) sem introduzir a complexidade operacional de sistemas distribuídos. O time é pequeno, o prazo é curto, e o ciclo mensal de pagamento exige consistência transacional forte entre Cadastro → Cálculo → Pagamento.

## Opções Consideradas

### Opção 1: Microservices (um serviço por contexto)

- **Prós:** deploy independente; escala granular; isolamento de falhas.
- **Contras:** consistência transacional do ciclo mensal exigiria sagas/compensação (alto risco em sistema financeiro); overhead de rede entre Cadastro/Cálculo/Pagamento; complexidade operacional (service mesh, observabilidade distribuída) incompatível com o time e o prazo; sem ganho real — o sistema tem um único dono e um único ritmo de release.

### Opção 2: Modular Monolith (um deployable, módulos isolados por package + schema)

- **Prós:** transação ACID nativa no ciclo mensal (`@Transactional` cruza módulos no mesmo processo); fronteiras explícitas por package + schema PostgreSQL; comunicação por interface/evento permite extrair microservice depois se necessário (Strangler-friendly); deploy e observabilidade simples.
- **Contras:** escala apenas vertical/horizontal do monólito inteiro; disciplina de fronteira depende de convenção + revisão (risco de acoplamento acidental).

## Decisão

Adotar **Modular Monolith** (Opção 2): projeto Maven multi-module Spring Boot 3.3 / Java 21, um deployable, com módulos `cadastro`, `calculo`, `pagamento`, `auditoria`, cada um com seu schema PostgreSQL e interface pública. Comunicação cross-module **somente** por interface ou domain event (anti-corruption layer). Batch mensal roda no mesmo processo usando virtual threads.

A fronteira modular preserva a opção futura de extrair um contexto como microservice (padrão Strangler Fig) sem reescrever o domínio.

## Consequências

### Positivas

- Consistência transacional forte no ciclo mensal sem sagas.
- Fronteiras testáveis e refatoráveis; caminho de evolução para microservices preservado.
- Operação e CI/CD simples — um artefato, um pipeline.

### Negativas

- Disciplina de isolamento depende de revisão de PR (mitigado por ArchUnit verificando que módulos não acessam repositórios uns dos outros).
- Escala do batch limitada ao processo (mitigado por virtual threads + particionamento de dados).

## Requisitos Relacionados

- REQ-PGTO-001, REQ-PGTO-002 (ciclo mensal transacional)
- REQ-AUD-003 (auditoria por evento cross-module)
- Todos os contextos de [bounded-contexts.md](../../specs/002-sifap-moderno/bounded-contexts.md)

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="../../specs/002-sifap-moderno/api-contracts.md"><strong>api-contracts.md</strong></a><br/>
<sub>Contratos REST.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="ADR-002-limite-dependentes.md"><strong>ADR-002</strong></a><br/>
<sub>Limite de dependentes.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
