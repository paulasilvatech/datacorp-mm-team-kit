<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# Diagramas C4 — SIFAP 2.0

![ESTÁGIO 02 Spec](https://img.shields.io/badge/ESTÁGIO-02%20Spec-00A4EF?style=for-the-badge) ![MODELO C4](https://img.shields.io/badge/MODELO-C4%20L1--L3-1A1A1A?style=for-the-badge) ![AGENTE @architect](https://img.shields.io/badge/AGENTE-@architect-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../../02-spec-moderna/README.md) → **specs/002-sifap-moderno** → **c4-diagrams**

> Arquitetura-alvo: **Modular Monolith** (ver [ADR-001](../../02-spec-moderna/ADRs/ADR-001-modular-monolith.md)). Contextos definidos em [bounded-contexts.md](bounded-contexts.md).

## Nível 1 — System Context

```mermaid
flowchart TB
    OPER["👤 Operador SERPRO<br/><small>cadastra e consulta</small>"]
    GESTOR["👤 Gestor de Programa<br/><small>aprova ciclos, vê relatórios</small>"]
    AUDITOR["👤 Auditor TCU/CGU<br/><small>consulta trilha</small>"]

    SIFAP["🏛️ SIFAP 2.0<br/><small>Sistema de Fiscalização e<br/>Administração de Pagamentos</small>"]

    BANCO["🏦 Banco do Brasil<br/><small>CNAB 240 remessa/retorno</small>"]
    RECEITA["🆔 Receita Federal<br/><small>validação CPF</small>"]
    SIAFI["💰 SIAFI<br/><small>execução orçamentária</small>"]

    OPER --> SIFAP
    GESTOR --> SIFAP
    AUDITOR --> SIFAP
    SIFAP -->|"remessa CNAB"| BANCO
    BANCO -->|"retorno CNAB"| SIFAP
    SIFAP -->|"consulta CPF"| RECEITA
    SIFAP -->|"empenho"| SIAFI

    classDef person fill:#1e3a8a,stroke:#3b82f6,color:#e2e8f0
    classDef system fill:#7c2d12,stroke:#ea580c,color:#fed7aa
    classDef ext fill:#334155,stroke:#64748b,color:#e2e8f0
    class OPER,GESTOR,AUDITOR person
    class SIFAP system
    class BANCO,RECEITA,SIAFI ext
```

## Nível 2 — Containers

```mermaid
flowchart TB
    subgraph CLIENTE["Cliente"]
        WEB["🖥️ SPA Next.js 15<br/><small>App Router · TS strict · shadcn/ui</small>"]
    end

    subgraph BACKEND["Modular Monolith — Spring Boot 3.3 / Java 21"]
        API["🌐 API REST<br/><small>/api/v1/* · OAuth2/JWT</small>"]
        MOD["📦 Módulos de domínio<br/><small>cadastro · calculo · pagamento · auditoria</small>"]
        BATCH["⚙️ Scheduler Batch<br/><small>ciclo mensal · virtual threads</small>"]
    end

    DB[("🐘 PostgreSQL 16<br/><small>schema-per-module · particionamento</small>")]
    BANCO["🏦 Banco do Brasil<br/><small>SFTP CNAB 240</small>"]
    RECEITA["🆔 Receita Federal<br/><small>API CPF</small>"]

    WEB -->|"HTTPS/JSON"| API
    API --> MOD
    BATCH --> MOD
    MOD -->|"JPA/Hibernate"| DB
    MOD -->|"validação CPF"| RECEITA
    BATCH -->|"remessa/retorno"| BANCO

    classDef web fill:#0c4a6e,stroke:#0ea5e9,color:#e0f2fe
    classDef app fill:#7c2d12,stroke:#ea580c,color:#fed7aa
    classDef data fill:#1e3a8a,stroke:#3b82f6,color:#e2e8f0
    classDef ext fill:#334155,stroke:#64748b,color:#e2e8f0
    class WEB web
    class API,MOD,BATCH app
    class DB data
    class BANCO,RECEITA ext
```

> **Decisão-chave:** um único deployable (monolith). Módulos isolados por package + schema PostgreSQL, comunicando-se por interface/evento (ADR-001). Batch roda no mesmo processo usando virtual threads (Java 21).

## Nível 3 — Components (Contexto Cadastro — slice da demo)

```mermaid
flowchart TB
    subgraph CAD["Módulo Cadastro"]
        CTRL["BeneficiarioController<br/><small>@RestController · @Valid</small>"]
        SVC["BeneficiarioService<br/><small>@Transactional · regras</small>"]
        ELEG["ElegibilidadeService<br/><small>REQ-CAD-005</small>"]
        CPF["CpfValidator<br/><small>módulo 11 · REQ-CAD-001</small>"]
        REPO["BeneficiarioRepository<br/><small>Spring Data JPA</small>"]
        EVT["BeneficiarioEventPublisher<br/><small>→ Auditoria</small>"]
    end

    DB[("PostgreSQL<br/>schema cadastro")]
    AUD["Módulo Auditoria<br/><small>interface pública</small>"]

    CTRL --> SVC
    SVC --> CPF
    SVC --> ELEG
    SVC --> REPO
    SVC --> EVT
    REPO --> DB
    EVT -.->|"evento"| AUD

    classDef comp fill:#7c2d12,stroke:#ea580c,color:#fed7aa
    classDef data fill:#1e3a8a,stroke:#3b82f6,color:#e2e8f0
    classDef ext fill:#334155,stroke:#64748b,color:#e2e8f0
    class CTRL,SVC,ELEG,CPF,REPO,EVT comp
    class DB data
    class AUD ext
```

> `@Transactional` apenas no service (nunca no repository) — convenção do kit. Validação na fronteira (controller `@Valid`). Comunicação com Auditoria por evento (anti-corruption).

---

**DoD:** ✅ L1 (System Context), L2 (Containers) e L3 (Components do Cadastro) em Mermaid renderizável.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="SPECIFICATION.md"><strong>SPECIFICATION.md</strong></a><br/>
<sub>Requisitos EARS.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="data-model.md"><strong>data-model.md</strong></a><br/>
<sub>Modelo Adabas → JPA.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
