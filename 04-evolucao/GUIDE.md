<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Estágio 4 — Evolução com Agentes (40 min)

> 🗺 **Você está aqui:** [Kit PT-BR](../README.md) → [Estágio 4](README.md) → **GUIDE**

> ⏰ Horário oficial: **16:10–16:50** em
> [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md). O Par 5 lidera e o Par 3 co-lidera a
> revisão técnica.

## Objetivo

Experimentar uma única delegação pequena e deixar uma evidência honesta do
resultado. O estágio não promete que um Agent abrirá PR, que Terraform será
criado, nem que haverá merge antes da demo.

## Roteiro cronometrado

| Horário | Atividade | Resultado |
| --- | --- | --- |
| 16:10–16:15 | Receba a H3, confirme o build conhecido e escolha uma pendência pequena. | Um recorte seguro para delegar ou registrar no backlog. |
| 16:15–16:25 | Escreva **uma** Issue com contexto, REQ-IDs, caminho da feature, critérios verificáveis, fora de escopo e forma de teste. | Issue criada ou rascunho pronto para criação. |
| 16:25–16:35 | Delegue ao Copilot Agent, se disponível, e acompanhe somente o estado inicial. | Delegação registrada; sem esperar uma implementação completa. |
| 16:35–16:45 | Se houver PR, faça revisão humana; caso contrário, registre o estado e prepare a revisão para depois do workshop. | Comentários de revisão ou próximo passo explícito. |
| 16:45–16:50 | Atualize o relatório de experiência e informe o time para a demo. | Relato factual do que funcionou, falhou ou ficou pendente. |

Use [`../.github/prompts/stage-evolution-write-github-issue.prompt.md`](../.github/prompts/stage-evolution-write-github-issue.prompt.md)
como checklist de elaboração. Não peça que o Agent invente requisitos,
arquitetura, fontes legadas ou critérios de aceite ausentes.

## Limites de escopo

- A Issue referencia `specs/<NNN>-<feature>/spec.md`, `plan.md` e `tasks.md`
  quando a pendência vier de uma feature especificada.
- Toda branch `impl/<NNN>-<feature>` parte de `develop` e abre PR para
  `develop`; não há branch `stage`.
- Revise qualquer PR de Agent como um PR humano. Não faça merge automático.
- CI/CD e Terraform são opcionais neste intervalo: valide ou documente o que já
  existe; não crie infraestrutura apenas para cumprir uma meta.
- Nunca execute `terraform apply` no workshop.

## Revisão rápida de PR

Quando houver um PR, confirme antes de aprovar:

- o escopo continua limitado à Issue e aos REQ-IDs;
- os requisitos e `source_legacy:` referenciados já existem no `spec.md`;
- testes, validação de entrada e documentação foram tratados quando aplicáveis;
- não há segredo, dependência sem decisão ou alteração fora de escopo;
- o PR aponta para `develop` e recebeu revisão de um par.

## Definição de Pronto

- [ ] Uma Issue pequena foi criada ou deixou um rascunho revisável.
- [ ] O resultado da delegação (PR, execução em andamento, falha ou indisponível)
      foi registrado sem promessas.
- [ ] Um PR disponível recebeu revisão humana; sem PR, há um próximo passo
      registrado.
- [ ] O relatório de experiência foi atualizado.
- [ ] A situação de CI/IaC foi comunicada para a demo, sem `terraform apply`.

Use o [template de relatório](templates/agent-experience-report.template.md) e
o README do agente [@evolution](../06-agentes-de-estagio/04-evolution/README.md)
para os papéis do time.
