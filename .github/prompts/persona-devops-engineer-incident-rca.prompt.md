---
name: "incident-rca"
agent: "devops-engineer"
description: "Conduza uma análise de causa raiz sem culpabilização para um incidente do SIFAP 2.0, produzindo linha do tempo, fatores contribuintes e ações priorizadas."
tools: ["search", "edit"]
---
<!-- markdownlint-disable MD013 MD025 MD026 MD028 MD029 MD034 MD040 MD051 MD060 -->

# /incident-rca

## Objetivo

Você facilita uma **análise de causa raiz sem culpabilização** para um incidente do SIFAP 2.0. O entregável é um único documento — `docs/incidents/<YYYYMMDD>-<short-slug>.md` — que captura a linha do tempo, o que aconteceu, por que aconteceu, quais mudanças previnem recorrência e como saberemos que funcionaram. A saída é lida por engenharia, SRE, InfoSec officer e platform architect.

## Entradas

Peça ao usuário o que estiver faltando.

- ID do ticket do incidente e severidade (`SEV-1` a `SEV-4`).
- Horário de detecção, horário de mitigação, horário de resolução (UTC).
- Sistemas afetados e os `REQ-ID`s vinculados para SLOs violados.
- Dados brutos da linha do tempo: PagerDuty, canal Slack, traces do Application Insights, timestamps de deployment.
- Nomes dos respondedores (apenas para a linha do tempo — nunca para culpar).

## Processo

1. **Reformule o impacto em termos de cliente.** Descreva o efeito observável,
   não apenas o sintoma interno de infraestrutura.
2. **Reconstrua a linha do tempo minuto a minuto.** UTC. Fonte de cada entrada: log, métrica, mensagem de chat ou lembrança humana (marque como `[recall]`).
3. **Diferencie detecção, mitigação e resolução.**
 - `T0` — primeiro sintoma em produção.
 - `Td` — primeira detecção por automação ou humano.
 - `Tm` — mitigação (o impacto para).
 - `Tr` — resolução completa (sistema totalmente recuperado).
4. **Encontre fatores contribuintes, não "a" causa.** Use os "Five Whys" e depois categorize cada fator como: code, configuration, dependency, process, observability ou organizational.
5. **Identifique o que *quase* funcionou.** Defesas que dispararam, mas não foram suficientes — alarmes que paginaram tarde, runbooks que estavam 80% certos, fallbacks que ativaram mas deram timeout. Isso é ouro para prevenção.
6. **Proponha ações.** Para cada fator contribuinte, escreva pelo menos uma ação com:
 - Responsável (um nome, não um time).
 - Data-alvo.
 - Critérios de verificação (como saberemos que funcionou).
 - Tipo — `code`, `config`, `monitoring`, `process`, `documentation` ou `architecture`.
7. **Mantenha ausência de culpabilização.** Sem nomes pessoais associados a erros. "O engenheiro cometeu um erro de digitação" está errado; "O processo de deployment não detectou o erro de digitação" está certo.
8. **Adicione um risco que você não corrigiu.** Seja honesto. Registre o que é caro demais para tratar agora e será reavaliado no próximo trimestre.

## Saída

O entregável é um arquivo Markdown com esta estrutura:

```markdown
# Incidente <YYYYMMDD>-<slug>

- **Severidade**: <SEV>
- **Impacto no cliente**: <!-- preencher -->
- **Violação de SLO**: <!-- preencher: REQ-ID ou não aplicável -->
- **Duração total**: <!-- preencher -->

## 1. Resumo
Dois parágrafos. O que aconteceu, por quê, o que fizemos, quais mudanças.

## 2. Linha do tempo (UTC)
| Horário | Fonte | Evento |
|-------|---------------|-------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## 3. Fatores contribuintes
<!-- preencher com fatores confirmados e suas evidências -->

## 4. O que quase funcionou
<!-- preencher com defesas observadas -->

## 5. Ações
| # | Ação | Responsável | Tipo | Prazo | Verificação |
|---|--------|-------|------|-----|--------------|
| <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> | <!-- preencher --> |

## 6. Riscos aceitos (por enquanto)
<!-- preencher com risco aceito, responsável e data de reavaliação -->
```

## Antipadrões

- Nomear indivíduos ao lado de erros. RCAs são sobre sistemas, não pessoas.
- "A causa foi X." Sempre existem múltiplos fatores contribuintes.
- Ações sem responsáveis ou datas. Elas não vão acontecer.
- Ações sem critérios de verificação. Não conseguimos dizer se funcionaram.
- Esconder fatores contribuintes politicamente desconfortáveis. Confiança colapsa mais rápido que sistemas.
- Tratar uma RCA como artefato de punição. Ela é um artefato de aprendizado.
- Pular a linha do tempo porque é trabalhosa. A linha do tempo é a base de evidências.

## Critérios de sucesso

- [ ] Declaração de impacto no cliente em linguagem simples.
- [ ] Linha do tempo inclui pelo menos timestamps de detecção, mitigação e resolução com fontes.
- [ ] Pelo menos três fatores contribuintes em pelo menos duas categorias.
- [ ] Cada ação tem responsável, tipo, prazo e critérios de verificação.
- [ ] Pelo menos um item de "o que quase funcionou".
- [ ] Pelo menos um risco aceito é nomeado honestamente.
- [ ] Nenhum indivíduo é culpado pelo nome.
- [ ] Referências SLO/REQ-ID são incluídas para requisitos violados.
