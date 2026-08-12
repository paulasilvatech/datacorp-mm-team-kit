<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# specs/

![PASTA specs](https://img.shields.io/badge/PASTA-specs-00A4EF?style=for-the-badge) ![ENGINE Spec-Kit](https://img.shields.io/badge/ENGINE-Spec-Kit-1A1A1A?style=for-the-badge)



> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → **Specs**

> **Para quem é isto?** Quem está no Estágio 2 e vai criar uma estrutura de spec usando Spec-Kit.
>
> **O que você terá ao final desta leitura:**
>
> 1. Padrão de pastas `specs/NNN-feature-name/`
> 2. Arquivos obrigatórios em cada feature (spec.md, plan.md, tasks.md)
> 3. Como o CI valida rastreabilidade

Esta pasta guarda os artefatos do **GitHub Spec-Kit**. Pense nela como o diário técnico de cada funcionalidade: primeiro o time explica o que quer construir, depois planeja como construir, depois quebra em tarefas e só então implementa.

## Modelo mental

Cada funcionalidade tem uma pasta própria:

```text
specs/
└── NNN-feature-name/
    ├── spec.md
    ├── plan.md
    └── tasks.md
```

O número (`NNN`) dá ordem. O nome (`feature-name`) explica o escopo. Evite nomes genéricos como `sistema` ou `backend`.

## Passo a passo

1. **Escolha uma descoberta do Estágio 1.**
2. **Crie a pasta da funcionalidade.** Use o padrão `NNN-nome-curto`.
3. **Execute `/speckit.specify`.** A spec deve ter user stories, EARS, critérios de aceitação e `source_legacy:`.
4. **Execute `/speckit.clarify`.** Resolva dúvidas antes de discutir arquitetura.
5. **Execute `/speckit.plan`.** Gere plano técnico, riscos, dados e contratos.
6. **Execute `/speckit.tasks`.** Quebre o plano em tarefas pequenas, testáveis e rastreáveis.
7. **Execute `/speckit.analyze`.** Corrija inconsistências antes de codar.
8. **Execute `/speckit.implement`.** Só implemente depois que spec, plan e tasks estiverem coerentes.

## Fluxo Spec-Kit

| Comando | Artefato | O que conferir |
| --- | --- | --- |
| `/speckit.constitution` | `.specify/memory/constitution.md` | Regras inegociáveis do projeto |
| `/speckit.specify` | `spec.md` | REQ-IDs, EARS, acceptance e `source_legacy:` |
| `/speckit.clarify` | Perguntas resolvidas na spec | Ambiguidades fechadas |
| `/speckit.plan` | `plan.md` e apoios gerados pelo Spec-Kit quando necessários | Arquitetura, dados, riscos e contratos |
| `/speckit.tasks` | `tasks.md` | Ordem de execução, testes e dependências |
| `/speckit.analyze` | Relatório de lacunas | Inconsistências resolvidas |
| `/speckit.implement` | Código em `backend/` e `frontend/` | Implementação segue a spec |

## Convenção de branches

- Uma branch por spec: `spec/<NNN>-<feature-name>` criada a partir de `develop`.
- Depois do merge da spec, branches de implementação
  `impl/<NNN>-<feature-name>` são criadas a partir de `develop`, nunca da
  branch da spec.
- O fluxo de integração é `spec/<NNN>-<feature>` → `develop` → `main`; não
  existe branch `stage`.
- Commits devem mencionar REQ-IDs quando implementarem comportamento: `Implements REQ-XXX`.

## Primeira funcionalidade

Crie a primeira pasta somente depois de o time escolher uma funcionalidade no Estágio 2. O nome deve refletir a decisão do time e não antecipar uma solução.

## Definição de Pronto da pasta `specs/`

- [ ] Cada funcionalidade tem pasta `NNN-nome-curto`.
- [ ] Todo requisito legado tem `source_legacy:` apontando para `.NSN` ou `.ddm`.
- [ ] Todo requisito greenfield tem justificativa `[GREENFIELD]`.
- [ ] `tasks.md` inclui testes antes de implementação para regra de negócio.

## Relação com `02-spec-moderna/`

`02-spec-moderna/` não contém uma segunda spec. Use-o para registrar decisões de
recorte e apoio ao Estágio 2. Requisitos EARS, plano técnico e tarefas da
feature ficam em `specs/<NNN>-<feature>/spec.md`, `plan.md` e `tasks.md`.

## Referências

- [Cartão de referência do Spec-Kit](../09-cheat-sheets/spec-kit-workflow.md)
- [Spec-Kit oficial](https://github.com/github/spec-kit)
- [Spec-Driven Development](https://github.com/github/spec-kit/blob/main/spec-driven.md)
---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="../09-cheat-sheets/spec-kit-workflow.md"><strong>Spec-Kit em 1 página</strong></a><br/>
<sub>Sequência specify → clarify → plan → tasks → analyze.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="../02-spec-moderna/GUIDE.md"><strong>Estágio 2 — Spec Moderna</strong></a><br/>
<sub>Crie a spec a partir da descoberta do time.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>

— Paula
