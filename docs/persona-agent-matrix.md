<!-- markdownlint-disable MD013 MD033 MD041 -->

# Matriz Persona x Agente

![Tipo Referência](https://img.shields.io/badge/Tipo-Refer%C3%AAncia-171717?style=flat-square)
![Uso Quem faz o quê](https://img.shields.io/badge/Uso-Quem%20faz%20o%20qu%C3%AA-737373?style=flat-square)

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **Persona-Agent Matrix**

**Mapeamento de cada persona para cada agente de estágio** — mostra quem protagoniza, apoia ou observa em cada momento do dia.

| Campo | Valor |
|---|---|
| **Público-alvo** | Todo o time |
| **Quando consultar** | Ao início de cada estágio e ao montar os pares |
| **Resultado esperado** | Clareza sobre o nível de engajamento esperado de cada persona |

---

## Como ler esta matriz

1. Encontre a linha da sua persona.
2. Leia horizontalmente para ver seu nível de intensidade em cada estágio.
3. Para estágios em que você é **Protagonista** ou **Secundária**, leia as orientações detalhadas abaixo.
4. Abra o README do kit do agente do estágio atual para ver o fluxo completo.

---

## A Matriz

| # | Persona | @archaeologist | @architect | @builder | @evolution |
|---|---|---|---|---|---|
| 01 | Product Owner | Observadora | Secundária | Observadora | Secundária |
| 02 | Requirements Engineer | **Protagonista** | Secundária | Observadora | Observadora |
| 03 | Enterprise Architect | Secundária | Secundária | Observadora | Observadora |
| 04 | Software Architect | Observadora | **Protagonista** | Secundária | Observadora |
| 05 | Technical Lead | Observadora | Secundária | Secundária | **Protagonista** |
| 06 | Developer | Observadora | Observadora | **Protagonista** | Secundária |
| 07 | DBA | Secundária | Observadora | Secundária | Observadora |
| 08 | QA Engineer | Observadora | Observadora | Secundária | Secundária |
| 09 | DevOps Engineer | Observadora | Observadora | Secundária | Secundária |
| 10 | Tech Writer | Secundária | Observadora | Observadora | Secundária |

**Protagonista** — conduz o uso do agente; é responsável pelas entregas do estágio.
**Secundária** — contribui ativamente; trabalha em par com a pessoa protagonista.
**Observadora** — acompanha pelo chat; pronta para ajudar quando sua especialidade for necessária.

---

## Orientação por célula

### Estágio 1 — @archaeologist

| Persona | O que você faz |
|---|---|
| **Requirements Engineer (Protagonista)** | Conduz a exploração. Abre cada programa Natural, pede ao agente para ajudar a decodificá-lo e captura regras de negócio como requisitos em rascunho. Responsável pelo rascunho das regras. |
| Tech Writer (Secundária) | Constrói o glossário de domínio em tempo real. Cada novo termo — nome de variável, rótulo de campo, propósito de sub-rotina — entra no glossário com definição. |
| Enterprise Architect (Secundária) | Foca no panorama geral: quais sistemas externos o código legado chama? Quais entradas batch vêm de onde? Começa a rascunhar o contexto do sistema. |
| DBA (Secundária) | Foca nos DDMs (Data Definition Modules do Adabas). Documenta tipos de campo, descriptors, estruturas MU/PE e relações entre arquivos para compor o mapa de dados. |
| Product Owner (Observadora) | Escuta e valida. Quando o time propõe uma interpretação de regra de negócio, confirma ou questiona com base no entendimento de domínio. |
| Demais personas (Observadoras) | Acompanham o chat. Quando alguém pergunta sobre um padrão na sua área — por exemplo, Developer reconhece um cálculo — manifesta-se. |

### Estágio 2 — @architect

| Persona | O que você faz |
|---|---|
| **Software Architect (Protagonista)** | Lidera a definição de bounded contexts. Usa o mapa de dados e o call graph do Estágio 1 para identificar limites naturais. Desenha diagramas C4. Escreve os primeiros ADRs. |
| Requirements Engineer (Secundária) | Transforma as regras de negócio do Estágio 1 em requisitos EARS formais com IDs `REQ-NNN`. Cada requisito precisa de critérios de aceite. Trabalha com Software Architect para mapear requisitos a bounded contexts. |
| Enterprise Architect (Secundária) | Valida o diagrama de contexto do sistema. Garante que pontos de integração (feeds batch, APIs externas, autenticação) estejam capturados. Revisa ADRs quanto à consistência arquitetural. |
| Product Owner (Secundária) | Prioriza requisitos. Com tempo limitado, ajuda a decidir quais são obrigatórios versus desejáveis. |
| Technical Lead (Observadora) | Começa a pensar na ordem de implementação. Qual bounded context construir primeiro? Quais são as dependências? |
| Demais personas (Observadoras) | Revisam a especificação em formação. Sinalizam qualquer inconsistência da perspectiva de suas especialidades. |

### Estágio 3 — @builder

| Persona | O que você faz |
|---|---|
| **Developer (Protagonista)** | Escreve código. Usa o agente builder para gerar entidades JPA, serviços Spring, controllers REST e páginas Next.js. Todo trecho de código rastreia para um `REQ-NNN`. |
| DBA (Secundária) | Responsável pela camada de banco. Revisa mapeamentos de entidade, escreve migrations Flyway e valida se o schema PostgreSQL representa corretamente o modelo de dados do Estágio 2. |
| QA Engineer (Secundária) | Escreve testes junto com o Developer. Para cada serviço, produz pelo menos um teste de caminho feliz e um de caminho de erro. Monitora cobertura e sinaliza lacunas. |
| Technical Lead (Secundária) | Revisa o código à medida que é produzido. Verifica violações de padrão (sem `@Autowired` em campo, sem retornos `null`, sem `any` em TypeScript). Faz merge de pull requests. |
| Software Architect (Secundária) | Valida se a implementação corresponde ao design. Sinaliza cedo quando Developer se desvia dos limites dos bounded contexts. |
| Demais personas (Observadoras) | Disponíveis para perguntas. Developer pode precisar de esclarecimento de domínio que apenas Product Owner ou Requirements Engineer consegue fornecer. |

### Estágio 4 — @evolution

| Persona | O que você faz |
|---|---|
| **Technical Lead (Protagonista)** | Escreve GitHub Issues para o Copilot Agent executar. Revisa pull requests gerados por IA. Decide o que fazer merge e o que rejeitar. Responsável pela integração e prontidão para demo. |
| DevOps Engineer (Secundária) | Escreve o workflow do GitHub Actions e os módulos Terraform. Garante tags adequadas, gerenciamento de secrets e configuração de recursos. |
| QA Engineer (Secundária) | Valida se o pipeline de CI inclui todos os gates de qualidade: lint, build, test. Revisa resultados de testes de pull requests gerados por IA. |
| Developer (Secundária) | Revisa código gerado por IA quanto à corretude. Conhece a base de código e detecta erros lógicos que verificações automáticas podem não encontrar. |
| Tech Writer (Secundária) | Refina o README, documenta o roteiro de demo e garante que as notas de retrospectiva capturem os aprendizados do time. |
| Product Owner (Secundária) | Ajuda a priorizar o que precisa funcionar para a demo versus o que pode ser adiado. Prepara a narrativa para a apresentação. |
| Demais personas (Observadoras) | Contribuem com observações de retrospectiva: o que surpreendeu, o que fariam de forma diferente. |

---

## Sugestão de ordem de leitura

- [ ] Leia o `PERSONA.md` do seu papel em [`05-personas/`](../05-personas/) — entenda suas responsabilidades.
- [ ] Leia sua linha nesta matriz — entenda sua intensidade em cada estágio.
- [ ] Ao início de cada novo estágio, abra o README do kit do agente em [`06-agentes-de-estagio/`](../06-agentes-de-estagio/).
- [ ] Ative o agente do estágio atual no Copilot Chat e comece a trabalhar.

## Referências

- [Kits de agentes](../06-agentes-de-estagio/README.md)
- [Arquitetura dos agentes](4-agents-explained.md)
- [Persona kits consolidados](../05-personas/)

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [4 Agentes Explicados](4-agents-explained.md)<br/><sub>Por que são 4 agentes.</sub> | [Fluxo SDLC](sdlc-flow-guide.md)<br/><sub>Contratos entre pares.</sub> |

<sub>[Voltar ao índice do kit](../README.md)</sub>
