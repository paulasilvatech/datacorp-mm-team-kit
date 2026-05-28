# Fragmento — Par 4 (Qualidade): VALBENEF + VALDOCS + VALELEG

> Estágio 1 · Extração de regras de negócio em programas de validação (subprogramas CALLNAT)
> Pacote: VALBENEF.NSN, VALDOCS.NSN, VALELEG.NSN
> Cross-ref: `legacy-docs/REGRAS-NEGOCIO-2012.md` (rascunho incompleto, 2012)

---

## Regras de VALBENEF.NSN

> Validação cadastral de beneficiário (ARQ 150). Subprograma chamado antes de gravação.
> Contrato (LOCAL): CPF, NOME, DT-NASCIMENTO, SEXO, UF, CEP, STATUS → RESULTADO ('V'/'I') + MSG-ERRO(10).

| #  | Declaração | EARS | Fonte | Classificação | Notas |
|----|------------|------|-------|---------------|-------|
| 1  | Se o CPF não passar na validação módulo-11 (DV1 e DV2), o sistema deve rejeitar com erro "CPF INVALIDO - DIGITO VERIFICADOR" | Unwanted | VALBENEF.NSN `PERFORM VALIDA-CPF-COMPLETO` + subrotina (linhas ~170-225) | **Confirmada** — RN-001 cita "CPF válido (validação por dígito verificador - subprograma VALCPF)" | Algoritmo: peso 10→2 para DV1, peso 11→2 para DV2; resto < 2 ⇒ DV=0 |
| 2  | Se o CPF tiver todos os 11 dígitos iguais, o sistema deve rejeitar | Unwanted | VALBENEF.NSN linhas ~155-165 (loop #TODOS-IGUAIS) | **Inferida** | Não há doc; padrão clássico anti-CPF-de-teste |
| 3  | Se o CPF tiver todos os dígitos iguais MAS começar com "000", o sistema deve aceitar como válido (exceção governo/teste) | Unwanted (override) | VALBENEF.NSN linhas ~163-168 `IF #DIG(1)=0 AND #DIG(2)=0 AND #DIG(3)=0 ... ESCAPE ROUTINE` | **Mistério** | Sem doc. Aparente backdoor de teste do governo; quem autoriza? quem usa? |
| 4  | Se a data de nascimento tiver ano fora de [1900, ano-atual], mês fora de [1,12] ou dia fora de [1, dias-do-mês], o sistema deve rejeitar com "DATA NASCIMENTO INVALIDA" | Unwanted | VALBENEF.NSN `DEFINE SUBROUTINE VALIDA-DATA` (linhas ~230-249) | **Confirmada** parcialmente — RN-006 exige DT-NASC obrigatória | Fevereiro fixo em 29 dias (`#DIAS-MES(2)=29`); aceita 29/02 em ano não-bissexto |
| 5  | O cálculo de dias do mês de fevereiro sempre admite 29 dias, sem verificar bissexto | State-driven (bug latente) | VALBENEF.NSN linha `MOVE 29 TO #DIAS-MES(2)` + comentário `/* CONSIDERA BISSEXTO */` | **Mistério** | Comentário promete bissexto mas código não calcula; doc não menciona |
| 6  | Se o nome estiver em branco OU não contiver pelo menos um espaço a partir da posição 2, o sistema deve rejeitar com "NOME INVALIDO - DEVE TER NOME E SOBRENOME" | Unwanted | VALBENEF.NSN `DEFINE SUBROUTINE VALIDA-NOME` (linhas ~252-268) | **Inferida** | Doc não detalha; alteração de 30/11/2010 (José Ferreira) |
| 7  | Se a UF for informada (≠ branco) e não constar da tabela de 27 UFs brasileiras, o sistema deve rejeitar com "UF INVALIDA" | Unwanted | VALBENEF.NSN linhas ~131-148 (loop FOR contra `#UF-TAB`) | **Inferida** | Tabela hardcoded; UF em branco é aceita (campo opcional) |
| 8  | Se o STATUS não for um de {A, S, C, I, D}, o sistema deve rejeitar com "STATUS INVALIDO" | Unwanted | VALBENEF.NSN linhas ~150-156 | **Confirmada** parcialmente — RN-002 menciona estado 'A' (ativo) e 'E' (excluído); aqui falta 'E' e sobra D/I/C/S | Divergência com RN-002: doc fala em 'E' (excluído), código aceita 'D' (desligado?) e 'C' (cancelado?). Precisa investigar |

---

## Regras de VALDOCS.NSN

> Validação de documentos (CPF, RG e doc complementar) — ARQ 150. Subprograma.
> Contrato (LOCAL): CPF, RG, TITULO, CTPS → RESULTADO ('V'/'I') + MSG(5) + DOC-ESP-OK.

| #  | Declaração | EARS | Fonte | Classificação | Notas |
|----|------------|------|-------|---------------|-------|
| 9  | Se o CPF for zero, o sistema deve rejeitar com "CPF INVALIDO" | Unwanted | VALDOCS.NSN `DEFINE SUBROUTINE VALIDA-CPF-DOC` linhas ~110-114 | **Inferida** | Campo obrigatório implícito |
| 10 | Se o CPF não passar na validação módulo-11, o sistema deve rejeitar com "CPF INVALIDO" | Unwanted | VALDOCS.NSN linhas ~115-148 | **Confirmada** — RN-001 (igual à regra #1 mas em outro subprograma — código duplicado) | Lógica de DV idêntica a VALBENEF mas sem checagem de "todos iguais" e sem exceção "000" |
| 11 | Se o RG for branco ou tiver menos de 5 caracteres significativos, o sistema deve rejeitar com "RG INVALIDO OU FORMATO INCORRETO" | Unwanted | VALDOCS.NSN `DEFINE SUBROUTINE VALIDA-RG` (linhas ~155-170) | **Inferida** | Alteração 22/09/2003 (Ana Lucia) "INC VALID RG"; doc não cobre |
| 12 | Se o prefixo do CPF (3 primeiros dígitos) constar da tabela de prefixos especiais {000, 001, 002, 010, 011, 099, 100, 999}, o sistema deve marcar DOC-ESP-OK, **anular qualquer erro anterior** (RESULTADO='V', QTD-ERROS=0) e considerar o documento válido | Optional-feature (override) | VALDOCS.NSN `DEFINE SUBROUTINE CHECK-DOC-ESPECIAL` linhas ~175-189 | **Mistério** | Sobrescreve resultado anterior! Nenhuma doc menciona esses prefixos. Quem cadastrou? Para que? Backdoor crítico |
| 13 | TITULO eleitor e CTPS são lidos via INPUT mas **nunca validados** no fluxo principal | State-driven (gap) | VALDOCS.NSN INPUT linhas ~60-65; nenhum PERFORM correspondente | **Mistério** | Campos coletados sem uso. Resto de funcionalidade incompleta? Alteração 07/06/2011 "AJUSTE CHECK ESPEC" pode ter quebrado |

---

## Regras de VALELEG.NSN

> Validação de elegibilidade beneficiário × programa social (ARQ 150 + ARQ 155). Subprograma.
> Contrato (LOCAL): #CPF, #COD-PROG → #ELEGIVEL (L) + #MOTIVO(10).
> Lê BENEFICIARIO via FIND CPF e PROGRAMA-SOCIAL via FIND COD-PROGRAMA.

| #  | Declaração | EARS | Fonte | Classificação | Notas |
|----|------------|------|-------|---------------|-------|
| 14 | Se o beneficiário (CPF) não existir no ARQ 150, o sistema deve abortar com "BENEFICIARIO NAO ENCONTRADO" | Unwanted | VALELEG.NSN linhas ~74-77 | **Inferida** | Pré-condição de integridade |
| 15 | Se o programa (COD-PROG) não existir no ARQ 155, o sistema deve abortar com "PROGRAMA NAO ENCONTRADO" | Unwanted | VALELEG.NSN linhas ~89-92 | **Inferida** | Pré-condição de integridade |
| 16 | Se o programa estiver com STATUS-PROG ≠ 'A' (não ativo), o sistema deve abortar com "PROGRAMA INATIVO" | Unwanted | VALELEG.NSN linhas ~94-97 | **Inferida** | Doc não detalha ciclo de vida do programa |
| 17 | Se o COD-REGIAO do beneficiário = 99, o sistema deve considerá-lo automaticamente elegível e encerrar a validação ("REGIAO ESPECIAL") | Optional-feature (bypass) | VALELEG.NSN linhas ~102-106 | **Confirmada** parcialmente — RN-005: "valor 99 é reservado para uso interno" + comentário inline "INTERNACIONAL/DIPLOMATICO" | RN-005 NÃO autoriza bypass de elegibilidade. Comentário do código vai além da doc. Alteração 05/04/2013 "INC REGIAO 99" — backdoor adicionada 14 anos após criação |
| 18 | Se o STATUS do beneficiário = 'S', o sistema deve marcar inelegível com motivo "BENEFICIARIO SUSPENSO" | Unwanted | VALELEG.NSN linhas ~110-114 | **Inferida** | Status mapping |
| 19 | Se o STATUS do beneficiário ∈ {C, D}, o sistema deve marcar inelegível com motivo "BENEFICIARIO CANCELADO/DESLIGADO" | Unwanted | VALELEG.NSN linhas ~115-119 | **Inferida** | C e D tratados como equivalentes — diverge de RN-002 |
| 20 | Se o STATUS do beneficiário = 'I', o sistema deve marcar inelegível com motivo "BENEFICIARIO INATIVO" | Unwanted | VALELEG.NSN linhas ~120-125 | **Inferida** | — |
| 21 | Se PROGRAMA.IDADE-MIN > 0 e idade do beneficiário < IDADE-MIN, o sistema deve marcar inelegível com "IDADE INFERIOR AO MINIMO DO PROGRAMA" | Unwanted | VALELEG.NSN linhas ~133-138 | **Confirmada** parcialmente — RN-006 menciona corte de 16 anos para inclusão | Idade calculada como (ano-atual − ano-nascimento), ignora mês/dia (off-by-one possível) |
| 22 | Se PROGRAMA.IDADE-MAX > 0 e idade do beneficiário > IDADE-MAX, o sistema deve marcar inelegível com "IDADE SUPERIOR AO MAXIMO DO PROGRAMA" | Unwanted | VALELEG.NSN linhas ~139-145 | **Inferida** | Alteração 11/10/2009 "AJUSTE FAIXA ETARIA" |
| 23 | Se PROGRAMA.RENDA-MAX > 0 e renda familiar do beneficiário > RENDA-MAX, o sistema deve marcar inelegível com "RENDA FAMILIAR ACIMA DO TETO DO PROGRAMA" | Unwanted | VALELEG.NSN linhas ~150-156 | **Inferida** | — |
| 24 | Se TIPO-PROG = 'A' (Assistencial) e RENDA > 600,00 e NUM-DEPENDENTES < 1, o sistema deve marcar inelegível com "PROG ASSISTENCIAL: RENDA > 600 SEM DEPENDENTES" | Unwanted (composta) | VALELEG.NSN `DECIDE` VALUE 'A' linhas ~163-170 | **Mistério** | Constante 600,00 hardcoded — quando atualizada pela última vez? Doc nada cita |
| 25 | Se TIPO-PROG = 'A' e DOCUMENTOS-OK do beneficiário ≠ 'S', o sistema deve marcar inelegível com "DOCUMENTACAO INCOMPLETA" | Unwanted | VALELEG.NSN linhas ~171-175 | **Inferida** | Flag 'DOCUMENTOS-OK' presumida vir de VALDOCS, mas integração não está explícita |
| 26 | Se TIPO-PROG = 'P' (Previdenciário) e idade < 60, o sistema deve marcar inelegível com "PROG PREVIDENCIARIO: IDADE < 60" | Unwanted | VALELEG.NSN VALUE 'P' linhas ~177-181 | **Inferida** | 60 hardcoded — não diferencia gênero (regra previdenciária real diverge) |
| 27 | Se TIPO-PROG = 'T' (Trabalho) e idade ∉ [16,65], o sistema deve marcar inelegível com "PROG TRABALHO: IDADE FORA DA FAIXA 16-65" | Unwanted | VALELEG.NSN VALUE 'T' linhas ~183-187 | **Inferida** | Faixa hardcoded |
| 28 | Se TIPO-PROG não for 'A', 'P' nem 'T', o sistema deve marcar inelegível com "TIPO PROGRAMA DESCONHECIDO" | Unwanted (fail-safe) | VALELEG.NSN `NONE` clause linhas ~189-193 | **Mistério** | Doc não define dicionário de TIPO-PROG. Quais outros valores podem existir em produção? |
| 29 | Se o 1º caractere de COD-ELEGIBILIDADE do programa = 'R' e NIS do beneficiário = 0, o sistema deve marcar inelegível com "NIS NAO CADASTRADO" | Unwanted | VALELEG.NSN `VERIF-ELEG-ESPECIFICA` linhas ~210-215 | **Confirmada** parcialmente — RN-001 cita NIS/NIT ativo via VALNISN | Aqui o código apenas checa NIS≠0, não chama VALNISN — divergência |
| 30 | Se o 2º caractere de COD-ELEGIBILIDADE do programa = 'D' e NUM-DEPENDENTES = 0, o sistema deve marcar inelegível com "PROGRAMA REQUER DEPENDENTES" | Unwanted | VALELEG.NSN linhas ~217-222 | **Inferida** | Doc não define formato/significado de COD-ELEGIBILIDADE (campo A5) — caracteres 3,4,5 nunca usados |

---

## Resumo Par 4

| Classificação | Contagem |
|---------------|----------|
| **Confirmada** (total ou parcial pela doc) | 7 (regras #1, #4, #8, #10, #17, #21, #29) |
| **Inferida** (sem cobertura na doc, óbvia pelo código) | 17 |
| **Mistério** (precisam investigação) | 6 (regras #3, #5, #12, #13, #17 sobreposição, #24, #28) |
| **Total** | **30** |

### Mistérios prioritários para o catálogo

1. **CPF "000" (regra #3)** — backdoor de governo/teste em VALBENEF; sem doc.
2. **Bug latente do bissexto (regra #5)** — comentário diz "considera bissexto", código fixa 29 dias.
3. **Prefixos especiais de CPF (regra #12)** — tabela hardcoded `{000,001,002,010,011,099,100,999}` que **anula** erros prévios em VALDOCS. Crítico.
4. **TITULO + CTPS coletados mas não validados (regra #13)** — funcionalidade incompleta em VALDOCS.
5. **Região 99 = elegibilidade automática (regra #17)** — alteração de 2013 vai além do que RN-005 autoriza ("uso interno").
6. **Constante R$ 600,00 hardcoded (regra #24)** — sem data de revisão; provavelmente defasada.
7. **TIPO-PROG sem dicionário (regra #28)** — DECIDE só cobre A/P/T; qual o universo real?

### Divergências doc × código (para passagem ao Estágio 2)

- **STATUS do beneficiário:** RN-002 fala em 'A'/'E'; VALBENEF aceita {A,S,C,I,D}; VALELEG trata 'C' e 'D' juntos. Três visões diferentes.
- **Validação NIS:** RN-001 manda chamar VALNISN; VALELEG só checa NIS≠0. VALNISN nunca é referenciado nestes 3 programas.
- **Código duplicado:** lógica de DV do CPF replicada em VALBENEF e VALDOCS. Diverge na exceção "000".

### Observações para Par 4 (Qualidade)

- Subprogramas são **rule-dense** como esperado: 30 regras em ~600 linhas combinadas.
- Forte oportunidade para testes parametrizados (CPF DV, faixa etária, status mapping).
- Mistérios #3, #12 e #17 são **gates de segurança** — não migrar para o novo sistema sem decisão explícita do PO.
