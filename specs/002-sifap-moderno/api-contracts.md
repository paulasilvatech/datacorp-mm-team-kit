<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Esboço de Contratos de API — SIFAP 2.0

![ESTÁGIO 02 Spec](https://img.shields.io/badge/ESTÁGIO-02%20Spec-00A4EF?style=for-the-badge) ![PADRÃO REST /api/v1](https://img.shields.io/badge/PADRÃO-REST%20%2Fapi%2Fv1-1A1A1A?style=for-the-badge) ![AGENTE @architect](https://img.shields.io/badge/AGENTE-@architect-7FBA00?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Estágio 2](../../02-spec-moderna/README.md) → **specs/002-sifap-moderno** → **api-contracts**

> Convenções do kit: path `/api/v1/{resource}`, verbos HTTP corretos, status codes apropriados, annotations OpenAPI obrigatórias, OAuth2/JWT (REQ-SEC-001).

## Visão geral dos endpoints

| Método | Path | Propósito | REQ-ID | Status sucesso |
| ------ | ---- | --------- | ------ | -------------- |
| POST   | `/api/v1/beneficiarios` | Cadastrar beneficiário (valida CPF) | REQ-CAD-001 | 201 Created |
| GET    | `/api/v1/beneficiarios/{id}` | Consultar beneficiário | REQ-CAD-004 | 200 OK |
| POST   | `/api/v1/beneficiarios/{id}/dependentes` | Adicionar dependente (limite 5) | REQ-CAD-002/003 | 201 Created |
| POST   | `/api/v1/ciclos-pagamento` | Gerar ciclo mensal (batch) | REQ-PGTO-001 | 202 Accepted |
| POST   | `/api/v1/conciliacoes` | Processar retorno bancário | REQ-PGTO-004 | 200 OK |
| GET    | `/api/v1/auditoria` | Relatório de auditoria (inclui EX) | REQ-AUD-002 | 200 OK |
| POST   | `/api/v1/auth/login` | Autenticar e emitir JWT | REQ-SEC-001 | 200 OK |

## Detalhamento dos contratos (mínimo de 3)

### POST `/api/v1/beneficiarios` — REQ-CAD-001

```http
POST /api/v1/beneficiarios
Authorization: Bearer <jwt>
Content-Type: application/json

{
  "cpf": "529.982.247-25",
  "nome": "Maria Aparecida Souza",
  "dataNascimento": "1958-03-12",
  "codigoRegiao": 41,
  "programaSocialId": "b3f1..."
}
```

| Resposta | Quando |
| -------- | ------ |
| `201 Created` + `Location: /api/v1/beneficiarios/{id}` | CPF válido e único |
| `400 Bad Request` | CPF inválido (módulo 11) ou payload inválido |
| `409 Conflict` | CPF já cadastrado |
| `401 Unauthorized` | sem JWT válido |

### POST `/api/v1/beneficiarios/{id}/dependentes` — REQ-CAD-002/003

```http
POST /api/v1/beneficiarios/{id}/dependentes
Authorization: Bearer <jwt>
Content-Type: application/json

{
  "cpf": "00000000000",
  "institucional": true,
  "grauParentesco": "NETO",
  "nome": "João Pedro Souza"
}
```

| Resposta | Quando |
| -------- | ------ |
| `201 Created` | dependente válido, ≤ 5 ativos |
| `400 Bad Request` | CPF `00000000000` sem `institucional=true` |
| `409 Conflict` | 6º dependente ativo (limite REQ-CAD-003) |

### GET `/api/v1/auditoria` — REQ-AUD-002

```http
GET /api/v1/auditoria?entidade=BENEFICIARIO&de=2026-01-01&ate=2026-01-31&acao=EX
Authorization: Bearer <jwt>
```

| Resposta | Quando |
| -------- | ------ |
| `200 OK` + lista paginada (inclui `acao=EX`) | consulta válida |
| `403 Forbidden` | perfil sem permissão de auditoria |

```json
{
  "page": 0, "size": 50, "total": 312,
  "items": [
    {
      "id": "a1b2...",
      "entidade": "BENEFICIARIO",
      "entidadeId": "b3f1...",
      "acao": "EX",
      "usuario": "operador.curitiba",
      "dataHoraUtc": "2026-01-15T13:42:08Z",
      "estadoAnterior": { "status": "ATIVO" },
      "estadoPosterior": null
    }
  ]
}
```

## Convenções transversais

- **Erros:** RFC 7807 (`application/problem+json`) com `type`, `title`, `status`, `detail`.
- **Paginação:** `?page=&size=` (default `size=50`), resposta com `total`.
- **Idempotência:** `POST /ciclos-pagamento` aceita header `Idempotency-Key` (evita ciclo duplicado).
- **OpenAPI:** todos os endpoints anotados com `@Operation` + `@ApiResponse` (springdoc).
- **Segurança:** CORS explícito (sem `*` em produção); JWT em todos exceto `/health` e `/auth/login`.

> **DoD:** ✅ 7 endpoints `/api/v1/*` (meta ≥3), 3 detalhados com payloads, status codes corretos, rastreados a REQ-IDs.

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="data-model.md"><strong>data-model.md</strong></a><br/>
<sub>Modelo Adabas → JPA.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="../../02-spec-moderna/ADRs/ADR-001-modular-monolith.md"><strong>ADR-001</strong></a><br/>
<sub>Decisão Modular Monolith.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../../README.md">Voltar ao Kit PT-BR</a></sub>
