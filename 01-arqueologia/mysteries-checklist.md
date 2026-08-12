<!-- markdownlint-disable MD013 MD033 MD041 -->

# Checklist de Perguntas em Aberto — Estágio 1

> **Trilha:** [Kit do Time](../README.md) › [Estágio 1](README.md) › **Checklist de Perguntas em Aberto**

**Rastreabilidade de incertezas antes do Estágio 2.** Garante que cada pergunta em aberto está registrada com evidência, hipótese marcada como não confirmada e responsável identificado.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todos os pares — preencher durante o Estágio 1 |
| **Pré-requisitos** | Leitura dos programas atribuídos |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | Lista de perguntas sem conclusão, com rastreabilidade e responsável |

> [!IMPORTANT]
> **Portão de rastreabilidade.** Uma pergunta permanece aberta até receber validação humana explícita baseada em evidência. Ela não deve ser transformada em resposta, regra ou requisito sem essa validação.

---

## O denominador é 20

O SIFAP esconde **20 mistérios canônicos** — regras de negócio, contradições e decisões que nunca foram documentadas e só existem dentro do código. São **4 por par**, na escada **2 Óbvia + 1 Média + 1 Difícil**.

| Regra | Valor |
|---|---|
| Total de mistérios canônicos na turma | **20** (`SIFAP-M-01` … `SIFAP-M-20`) |
| Por par | **4** |
| Par completo | 4 de 4 |
| Turma completa | **≥16 de 20**, e nenhum par abaixo de 2 |

> [!NOTE]
> **Por que um número fixo.** Sem denominador, cada par relatava uma quantidade diferente lendo exatamente o mesmo material — variação de mais de 30 itens, dependendo de granularidade de agregação e de quantos artefatos a pessoa abriu. O denominador **não muda**: achados fora da lista entram como **bônus** e são reconhecidos no debrief, mas não substituem um canônico faltante, e facilitadores não criam IDs canônicos durante o workshop.

Oito dos vinte são de **duas pontas**: só contam com as duas evidências (código **e** DDM, ou código **e** documento de legado). Comparar fontes não é opcional.

### Onde procurar — por par

Os rótulos indicam a **área** do mistério, nunca o achado.

| Par | Domínio | IDs | Programas |
|---|---|---|---|
| 1 | Cadastros | `M-01` … `M-04` | `CADBENEF`, `CADDEPEND`, `CADPROG` |
| 2 | Batch | `M-05` … `M-08` | `BATCHPGT`, `BATCHREL`, `BATCHCON` |
| 3 | Cálculo | `M-09` … `M-12` | `CALCBENF`, `CALCCORR`, `CALCDSCT`\* |
| 4 | Validação | `M-13` … `M-16` | `VALBENEF`, `VALDOCS`, `VALELEG` |
| 5 | Consulta e relatórios | `M-17` … `M-20` | `CONSBENF`, `RELPGT`, `RELAUDIT` |

\* `CALCDSCT.NSN` é leitura de apoio para o Par 3 — nenhum canônico vive nele. Vale a pergunta de por que ele existe.

> [!TIP]
> **Se travar por mais de 40 minutos, peça uma dica ao facilitador.** Dica não tira ponto; ficar travado tira você do exercício.

---

## Para cada pergunta em aberto

- [ ] A pergunta foi registrada sem resposta ou conclusão.
- [ ] A evidência contém `path:linha`.
- [ ] O impacto foi registrado.
- [ ] A hipótese está marcada explicitamente como **não confirmada**.
- [ ] Uma pessoa ou área responsável foi indicada.
- [ ] O status foi registrado.

---

## Estrutura de registro

| Pergunta aberta | Evidência (`path:linha`) | Impacto | Hipótese (não confirmada) | Pessoa/área responsável | Status |
|---|---|---|---|---|---|
| <!-- preencher --> | <!-- preencher: path:linha --> | <!-- preencher --> | <!-- preencher: não confirmada --> | <!-- preencher --> | <!-- preencher: aberta / aguardando validação humana / encerrada após validação humana --> |

---

## Placar do par

Preencha os IDs do seu par (por exemplo, Par 2 preenche `M-05` a `M-08`).

| ID canônico | Encontrado | Registrado em `mysteries-found.md` |
|---|---|---|
| `SIFAP-M-__` | [ ] | [ ] |
| `SIFAP-M-__` | [ ] | [ ] |
| `SIFAP-M-__` | [ ] | [ ] |
| `SIFAP-M-__` | [ ] | [ ] |

**Achados adicionais (bônus):** <!-- liste aqui; não alteram o denominador -->

---

## Métodos que encontram mistério

Nenhuma destas dicas entrega um achado — todas são técnicas de leitura de código legado reaproveitáveis.

1. **Leia os comentários antes do código.** Em código de 29 anos, o comentário é o único lugar onde alguém tentou explicar *por quê*. Comentário com nome e data é ouro.
2. **Leia o cabeçalho do programa.** As linhas `* ALTERADO: dd/mm/aaaa - NOME - motivo` contam a história do sistema em ordem cronológica.
3. **Compare código com documentação.** Quando `legacy-docs/` e o código discordam, você achou alguma coisa.
4. **Compare código com o DDM.** Tipo, tamanho e domínio de valores precisam bater entre o programa e `adabas-ddms/` — e nem sempre batem.
5. **Procure números literais.** Todo número solto num cálculo é uma pergunta: de onde veio, quem decidiu, o que quebra se mudar?
6. **Pergunte "quem grava este campo?".** Escolha um campo do DDM e procure todos os programas que escrevem nele. Às vezes a resposta é: nenhum.
7. **Leia o código comentado.** Blocos desativados dizem o que o sistema já fez — e por que parou.
8. **Desconfie de `ESCAPE`, `IF` sem `ELSE` e atribuição sem condição.** Saídas antecipadas e regras que sempre valem escondem decisões que ninguém registrou.
9. **Cruze os três programas do par.** Vários mistérios só aparecem comparando dois arquivos.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [GUIDE do Estágio 1](GUIDE.md)<br/><sub>Roteiro passo a passo.</sub> | [Registro de perguntas em aberto](mysteries-found.md)<br/><sub>Registro detalhado com evidência e responsável.</sub> |

<sub>[Voltar ao índice do kit](README.md)</sub>
