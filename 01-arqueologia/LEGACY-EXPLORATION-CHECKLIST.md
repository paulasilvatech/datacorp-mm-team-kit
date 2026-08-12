<!-- markdownlint-disable MD013 MD033 MD041 -->

# Checklist de Exploração do Legado

> **Trilha:** [Kit do Time](../README.md) › [Estágio 1](README.md) › **Checklist de Exploração**

**Portão obrigatório antes do Estágio 2.** Este checklist garante que cada par leu os programas atribuídos e que as regras candidatas têm rastreabilidade ao código legado.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todos os pares — preencher durante o Estágio 1 |
| **Pré-requisitos** | Acesso ao diretório `legado-sifap/natural-programs/` e `adabas-ddms/` |
| **Tempo estimado** | Preenchido ao longo de 90 min |
| **Estágio** | Estágio 1 — Arqueologia |
| **Resultado esperado** | Matriz completa de leitura por par e critérios de conclusão verificados |

> [!IMPORTANT]
> **Portão obrigatório antes do Estágio 2.** Nenhum requisito EARS é aceito sem referência a um arquivo de programa Natural ou DDM. Requisitos greenfield (sem paralelo no legado) precisam ser marcados `[GREENFIELD]` e justificados por escrito na spec.

> [!WARNING]
> Na edição anterior do workshop, vários times pularam a exploração do legado e escreveram specs baseadas apenas no brief de modernização. O resultado foram especificações que não preservavam as regras de negócio reais dos 29 anos do SIFAP. Este portão é obrigatório.

---

## 1. A regra de rastreabilidade

Todo `REQ-ID` em `specs/<NNN>-<feature>/spec.md` precisa ter uma linha `source_legacy:` que aponte para um dos seguintes:

- um programa `.NSN` específico em `01-arqueologia/legado-sifap/natural-programs/` (preferencialmente com faixa de linhas);
- um arquivo `.ddm` específico em `01-arqueologia/legado-sifap/adabas-ddms/`;
- `[GREENFIELD]` com justificativa de uma linha.

O CI rejeita PRs para `develop` se algum `REQ-ID` estiver sem a linha `source_legacy:`. Facilitadores verificam por amostragem na passagem de bastão H2, às 15:00.

---

## 2. Os 15 programas Natural — quem lê o quê

Cada par fica com 3 programas. Nenhum programa pode ficar sem leitor.

| Par | Programas para ler | Mistérios | Por que |
|---|---|---|---|
| **1 · Visão** (PO + RE) | `CADBENEF.NSP`, `CADDEPEND.NSP`, `CADPROG.NSP` | `SIFAP-M-01` … `M-04` | Lógica de cadastro — entidades centrais que viram sujeitos das EARS. |
| **2 · Arquitetura** (EA + SA) | `BATCHPGT.NSP`, `BATCHREL.NSP`, `BATCHCON.NSP` | `SIFAP-M-05` … `M-08` | Fluxos batch revelam fronteiras de módulo (bounded contexts). |
| **3 · Implementação** (TL + Dev) | `CALCBENF.NSN`, `CALCCORR.NSP`, `CALCDSCT.NSP`\* | `SIFAP-M-09` … `M-12` | Cálculos são onde o código moderno vai morar; a equipe precisa reproduzi-los. |
| **4 · Qualidade** (DBA + QA) | `VALBENEF.NSN`, `VALDOCS.NSP`, `VALELEG.NSN` | `SIFAP-M-13` … `M-16` | Validações viram testes; o DBA também mapeia campos dos DDMs. |
| **5 · Operações** (DevOps + TW) | `CONSBENF.NSP`, `RELPGT.NSP`, `RELAUDIT.NSP` | `SIFAP-M-17` … `M-20` | Caminhos de leitura alimentam o glossário e o runbook. |

\* `CALCDSCT.NSP` é **leitura de apoio** para o Par 3: nenhum mistério canônico vive nele. Ainda assim vale a pergunta de por que ele existe e quem o chama.

> [!IMPORTANT]
> **São 20 mistérios canônicos, 4 por par** — este é o único alvo numérico do Estágio 1. Os IDs e as áreas estão em [`mysteries-checklist.md`](mysteries-checklist.md); o registro vai em [`mysteries-found.md`](mysteries-found.md). Achados fora da lista contam como bônus e **não** alteram o denominador.

### Checklist por programa

Para cada programa do seu par, registre notas de leitura suficientes para confirmar que ele foi examinado:

- [ ] **Identificar o programa.** Anotar nome, autor e ano da última modificação.
- [ ] **Mapear inputs.** Quais DDMs ele lê.
- [ ] **Mapear outputs.** Quais DDMs ele escreve.
- [ ] **Registrar chamadas.** Outros programas chamados via `CALLNAT`.
- [ ] **Catalogar regra candidata.** Quando o programa contiver regra relevante ao recorte, registrar em `business-rules-catalog.md` com `Programa Fonte` e faixa de linhas.

> [!WARNING]
> Uma linha sem `Programa Fonte` não pode fundamentar uma EARS.

---

## 3. Os 4 DDMs — mapeamento de campos

O Par 4 (DBA + QA) lidera. Todos os outros pares contribuem com revisão.

| DDM | Dono | Artefato-alvo em PostgreSQL |
|---|---|---|
| `BENEFICIARIO.ddm` | Par 4 | <!-- definir a partir da evidência --> |
| `PAGAMENTO.ddm` | Par 4 | <!-- definir a partir da evidência --> |
| `PROGRAMA-SOCIAL.ddm` | Par 4 | <!-- definir a partir da evidência --> |
| `AUDITORIA.ddm` | Par 4 | <!-- definir a partir da evidência --> |

Consulte os DDMs necessários para a feature escolhida. O mapeamento completo para PostgreSQL pertence ao plano e à implementação; não é pré-requisito para iniciar a spec.

---

## 4. Registro de perguntas em aberto

Use [`mysteries-checklist.md`](mysteries-checklist.md) para registrar perguntas em aberto sem antecipar respostas. O registro é um catálogo de incertezas, não um gabarito nem uma fonte de regras.

Registre em `mysteries-found.md` apenas as perguntas que afetarem o recorte. Cada registro deve ter:

| Campo | Descrição |
|---|---|
| Pergunta aberta | Texto da dúvida sem conclusão |
| Evidência | `path:linha` |
| Impacto | Efeito sobre o recorte |
| Hipótese | Marcada explicitamente como não confirmada |
| Responsável | Pessoa ou área que pode validar |
| Status | `aberta` / `aguardando validação humana` / `encerrada após validação humana` |

Uma pergunta só pode ser encerrada ou usada como base de regra após validação humana explícita apoiada pela evidência registrada.

---

## 5. Verificação antes de abrir o Estágio 2

Por volta de 13h50 um facilitador verifica o trabalho do par contra esta matriz. Linha vermelha impede a passagem para o Estágio 2.

| Verificação | Critério do portão |
|---|---|
| Leitura atribuída | Cada par confirmou a leitura dos três programas que recebeu. |
| Catálogo de regras | Cada regra candidata ao recorte tem `Programa Fonte` não vazio. |
| Recorte | O relatório de descoberta identifica uma feature pequena e o que foi adiado. |
| Perguntas abertas | Incertezas relevantes foram registradas sem virar requisitos. |

---

## 6. Formato obrigatório no Estágio 2

Escreva EARS somente em `specs/<NNN>-<feature>/spec.md`, usando o Spec-Kit. Cada `REQ-ID` precisa de padrão EARS, critérios Given/When/Then e `source_legacy:`. Não preencha requisito algum até a equipe confirmar a fonte ou a justificativa greenfield.

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [GUIDE do Estágio 1](GUIDE.md)<br/><sub>Roteiro cronometrado.</sub> | [Templates](templates/)<br/><sub>Gabaritos preenchíveis para os artefatos do estágio.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
