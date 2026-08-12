<!-- markdownlint-disable MD013 MD033 MD041 -->

# FAQ — Perguntas Frequentes

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **FAQ**

**Respostas diretas para as dúvidas mais comuns do workshop de modernização SIFAP.**

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time |
| **Como usar** | `Ctrl+F` na pergunta. Se não encontrar, consulte [troubleshooting.md](troubleshooting.md) |
| **Tempo estimado** | leitura seletiva |

---

## Sobre o workshop

<details>
<summary><strong>Não programo. Posso participar?</strong></summary>

Sim. As personas Product Owner, Tech Writer e parte do QA não exigem codificação. Leia [`07-conceitos/`](../07-conceitos/) primeiro para se familiarizar com os conceitos. Cada `PERSONA.md` contém uma seção "defaults de emergência".

</details>

<details>
<summary><strong>Quanto tempo dura?</strong></summary>

8 horas (10:00–18:00). Cronograma exato em [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §2.

</details>

<details>
<summary><strong>Quantas pessoas por time?</strong></summary>

5 pessoas. Cada uma assume 2 personas (1 par). Total: 10 personas cobertas.

</details>

<details>
<summary><strong>Posso escolher minhas 2 personas?</strong></summary>

Sim, mas combine com o time. Pares 1, 4 e 5 acomodam perfis não-técnicos. Pares 2 e 3 pedem experiência técnica.

</details>

<details>
<summary><strong>O que é o SIFAP?</strong></summary>

O SIFAP (Sistema de Fiscalização e Administração de Pagamentos) é um sistema de pagamentos governamentais com 29 anos de existência, escrito em Natural/Adabas. O workshop simula modernizá-lo para Java 21 + Next.js 15. Veja [`01-arqueologia/legado-sifap/README.md`](../01-arqueologia/legado-sifap/README.md).

</details>

---

## Sobre o Copilot

<details>
<summary><strong>Qual modelo do Copilot devo usar?</strong></summary>

Sonnet 4.6 para a maioria das tarefas. Haiku para tarefas mecânicas e repetitivas. Opus para decisões arquiteturais complexas. Veja [`09-cheat-sheets/model-routing.md`](../09-cheat-sheets/model-routing.md).

</details>

<details>
<summary><strong>Quando usar Ask, Plan ou Agent?</strong></summary>

- **Ask** — conversar e entender.
- **Plan** — planejar mudança em múltiplos arquivos.
- **Agent** — delegar uma Issue completa.

Referência: [`07-conceitos/04-3-modos-do-copilot.md`](../07-conceitos/04-3-modos-do-copilot.md).

</details>

<details>
<summary><strong>O Agent pode fazer merge sozinho?</strong></summary>

Não. O Agent abre um pull request. Você revisa com o mesmo cuidado que aplicaria a uma contribuição humana.

</details>

<details>
<summary><strong>Posso usar Cursor, Codeium ou outro assistente?</strong></summary>

Não. A stack é fixa: somente GitHub Copilot. Veja [`.github/copilot-instructions.md`](../.github/copilot-instructions.md).

</details>

---

## Sobre Spec-Kit e EARS

<details>
<summary><strong>Por que toda EARS precisa de `source_legacy:`?</strong></summary>

Para garantir que o time modernizou o sistema real, e não apenas o briefing. O CI rejeita pull requests sem esse campo. Veja [`01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md`](../01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md).

</details>

<details>
<summary><strong>E se a funcionalidade é nova, sem paralelo no legado?</strong></summary>

Use `source_legacy: "[GREENFIELD] <justificativa de 1 linha>"`. Exemplo: `"[GREENFIELD] OAuth2 não existia em terminal 3270."`.

</details>

<details>
<summary><strong>Posso pular `/speckit.clarify`?</strong></summary>

Não. Pular essa etapa significa que ambiguidades se tornam bugs no Estágio 3, quando o custo de correção é muito maior.

</details>

<details>
<summary><strong>O `/speckit.analyze` está apontando problemas. O que fazer?</strong></summary>

Resolva antes de avançar para a implementação. Cada apontamento corresponde a uma hora a menos de retrabalho posterior.

</details>

---

## Sobre Git e branches

<details>
<summary><strong>Posso commitar direto na `main`?</strong></summary>

Não. Sempre via pull request. Veja [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md) regra 1.

</details>

<details>
<summary><strong>Qual prefixo de branch usar?</strong></summary>

- `spec/<NNN>-<feature>` no Estágio 2
- `impl/<NNN>-<feature>` no Estágio 3
- `infra/<component>` para infraestrutura

Ambas as branches nascem de `develop`. Tabela completa em [`00-GIT-WORKFLOW.md`](../00-GIT-WORKFLOW.md).

</details>

<details>
<summary><strong>Como meu PR é aprovado?</strong></summary>

CI verde + 1 revisão do par receptor. O fluxo é: Par 1 → Par 2 → Par 3 → Par 4 → Par 5 → Par 1.

</details>

<details>
<summary><strong>Posso fazer `git push --force`?</strong></summary>

Somente na sua própria branch e apenas com `--force-with-lease`. Nunca em `develop` ou `main`.

</details>

---

## Sobre Terraform e Azure

<details>
<summary><strong>Posso rodar `terraform apply`?</strong></summary>

> [!CAUTION]
> Não. Somente `terraform plan` está autorizado no workshop. Executar `apply` cria recursos reais no Azure e gera custo.

</details>

<details>
<summary><strong>Onde guardo secrets?</strong></summary>

No Azure Key Vault. Nunca em `variables.tf` ou em arquivos `.env` commitados. Ao criar `infra/`, modele secrets via Key Vault e Managed Identity.

</details>

---

## Sobre estágios e passagens

<details>
<summary><strong>O que é "passagem H1, H2, H3"?</strong></summary>

São os momentos de transferência de artefatos entre pares ao final de cada estágio. Cada passagem é uma conversa síncrona de 5 minutos. Detalhes em [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §3.

</details>

<details>
<summary><strong>Posso adiantar o Estágio 2 enquanto o 1 ainda está em andamento?</strong></summary>

Não. Sem o Estágio 1 concluído, suas especificações EARS não terão `source_legacy:` e o CI rejeitará o pull request.

</details>

<details>
<summary><strong>Quem lidera cada estágio?</strong></summary>

Tabela em [`05-personas/OVERVIEW.md`](../05-personas/OVERVIEW.md). Resumo:

- Estágio 1 — todos os pares em paralelo
- Estágio 2 — Par 2
- Estágio 3 — Pares 3 e 4
- Estágio 4 — Par 5

</details>

---

## Sobre bloqueios

<details>
<summary><strong>Estou travado. O que faço?</strong></summary>

Regra dos 20 minutos ([`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §6):

| Tempo travado | Ação |
|---|---|
| 5 min | Tente resolver sozinho |
| 10 min | Peça ajuda ao seu par |
| 20 min | Leve ao time |
| 30 min | Solicite ajuda ao facilitador |

</details>

<details>
<summary><strong>Como peço ajuda de forma eficiente?</strong></summary>

Use 3 linhas: (1) Objetivo, (2) O que tentei, (3) Qual é o bloqueio. Exemplo em [`00-TEAM-FLOW.md`](../00-TEAM-FLOW.md) §6.

</details>

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Troubleshooting](troubleshooting.md)<br/><sub>Erros comuns e soluções.</sub> | [Kit PT-BR](../README.md)<br/><sub>Hub principal.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
