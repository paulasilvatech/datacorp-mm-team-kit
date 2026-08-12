<!-- markdownlint-disable MD013 MD033 MD041 -->

# Lições Aprendidas — Erros Comuns dos Times

![Tipo Referência](https://img.shields.io/badge/Tipo-Refer%C3%AAncia-171717?style=flat-square)
![Leitura 5 min](https://img.shields.io/badge/Leitura-5%20min-737373?style=flat-square)

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **Lições aprendidas**

**Registro dos 10 erros mais comuns observados em times anteriores**, com consequência e antídoto.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time, especialmente o Technical Lead |
| **Quando ler** | Antes do workshop começar |
| **Resultado esperado** | Reconhecer os padrões de falha e saber o antídoto antes de precisar dele |

---

## Os 10 erros mais comuns

### 1. "Não precisamos olhar o legado — o briefing já basta"

- **Consequência:** o time escreve EARS sem `source_legacy:`. O CI rejeita o pull request às 14:30. O time perde 1 hora refazendo o trabalho.
- **Antídoto:** Hard gate do Estágio 1 — o facilitador valida às 13:50. Veja [`01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md`](../01-arqueologia/LEGACY-EXPLORATION-CHECKLIST.md).

### 2. "Vou começar a codar enquanto outro escreve a spec"

- **Consequência:** o código não corresponde às EARS. Refatoração no final do dia. Demonstração incompleta.
- **Antídoto:** o Estágio 3 só começa após a passagem H2. O Technical Lead interrompe tentativas de adiantar.

### 3. Product Owner aprova tudo e nada vira não-escopo

- **Consequência:** o time tenta implementar 12 funcionalidades em 3 horas. Termina com nenhuma.
- **Antídoto:** o Product Owner recusa pelo menos 3 vezes ao dia. Regra de decisão: _"afeta o ciclo mensal de pagamentos? Sim → v1. Não → backlog."_

### 4. Cada pessoa usa o Copilot de forma diferente

- **Consequência:** respostas inconsistentes. O time debate com o assistente em vez de produzir artefatos.
- **Antídoto:** todo o time seleciona o mesmo agente de estágio (`@archaeologist`, `@architect` etc.) no Chat.

### 5. Pular `/speckit.clarify` para ganhar tempo

- **Consequência:** ambiguidades tornam-se bugs no Estágio 3. 30 minutos de perguntas agora evitam 2 horas de retrabalho depois.
- **Antídoto:** cada pergunta do `clarify` equivale a um bug evitado. Responda todas.

### 6. `git push --force` em `develop`

- **Consequência:** trabalho de 2 pessoas perdido sem possibilidade de recuperação simples.
- **Antídoto:** branch protection em `develop` (Passo 4 do `00-SETUP.md`). Nunca usar `--force` em branch compartilhada.

### 7. Editar uma migration antiga em vez de criar uma nova

- **Consequência:** Flyway detecta incompatibilidade de checksum e o banco para de subir.
- **Antídoto:** nunca edite um arquivo de migration já aplicado. Sempre crie `V<N+1>__descricao.sql`. Veja [`docs/troubleshooting.md`](troubleshooting.md).

### 8. Delegar ao Copilot Agent uma Issue vaga

- **Consequência:** o pull request gerado é inaproveitável. O trabalho é descartado.
- **Antídoto:** vincule a Issue à evidência e escreva critérios de aceite verificáveis antes de delegar. Issue bem escrita produz pull request utilizável.

### 9. Rodar `terraform apply` em vez de `plan`

- **Consequência:** recursos Azure criados e cobrados imediatamente. O workshop não autoriza `apply`.
- **Antídoto:** somente `terraform plan`. Veja [`04-evolucao/GUIDE.md`](../04-evolucao/GUIDE.md).

### 10. Não ensaiar a demonstração

- **Consequência:** o time gasta os 3 minutos da demonstração procurando a aba certa, o comando que falha ou o pull request perdido.
- **Antídoto:** o intervalo 16:50–17:00 é exclusivo para ensaio. Roteiro em [`demo-script.md`](demo-script.md).

---

## Os 5 reflexos que distinguem times bons de times excelentes

1. **Stand-up de 2 minutos** ao fim de cada estágio — todos sabem onde estão.
2. **Pull request com descrição sempre** — use o template do GitHub.
3. **Commits pequenos com REQ-ID** na mensagem de commit.
4. **Regra dos 20 minutos** — travou? Peça ajuda. Não sofra em silêncio.
5. **Confiar no processo** — não invente um fluxo diferente no meio do dia.

---

## A regra fundamental

> **Modernizar é arqueologia digital, não projeto greenfield.**
> Quem trata o SIFAP como sistema novo perde 29 anos de regras de negócio.
> Quem faz a arqueologia primeiro entrega um SIFAP 2.0 que realmente substitui o 1.0.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [Checklist do Líder](CHECKLIST-LIDER.md)<br/><sub>Verificações hora a hora do dia.</sub> | [Script da Demo](demo-script.md)<br/><sub>Roteiro dos minutos finais.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
