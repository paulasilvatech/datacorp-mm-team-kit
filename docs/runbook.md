<!-- markdownlint-disable MD013 MD033 MD041 -->

# Runbook

![Tipo Runbook](https://img.shields.io/badge/Tipo-Runbook-171717?style=flat-square)
![Dono DevOps](https://img.shields.io/badge/Dono-DevOps-737373?style=flat-square)

> **Trilha:** [Kit do Time](../README.md) › [Docs](README.md) › **Runbook**

**Guia operacional para executar, verificar e diagnosticar o ambiente do workshop.**

| Campo | Valor |
|---|---|
| **Público-alvo** | DevOps Engineer e todo o time |
| **Pré-requisitos** | Setup local concluído conforme [`00-SETUP.md`](../00-SETUP.md) |
| **Resultado esperado** | Ambiente local funcionando, CI legível, escalonamento correto |

---

## Verificações iniciais (primeira vez)

- [ ] **Verificar pré-requisitos** — execute cada linha e confirme que não há erro:

```bash
git --version
java -version
node --version
docker --version
specify version
```

> [!NOTE]
> O kit não traz um protótipo pré-pronto. Quando o time criar `backend/`, `frontend/` e, se necessário, `infra/`, registre aqui os comandos reais de execução.

Após criar o protótipo, documente:

| Serviço | URL / Comando |
|---|---|
| Backend health | — |
| Swagger UI | — |
| Frontend local | — |
| Credenciais de demonstração | — |

---

## Rotina diária

- [ ] **Verificar estado do repositório:**

```bash
git status
```

- [ ] **Executar testes do backend** (quando `backend/` existir):

```bash
cd backend && ./mvnw test
```

- [ ] **Executar testes do frontend** (quando `frontend/` existir):

```bash
cd frontend && npm test
```

---

## CI — Entender os fluxos

O CI é acionado automaticamente em push para `main`, `develop`, `spec/**` e `impl/**`.

| Arquivo de workflow | O que verifica | Quando executa |
|---|---|---|
| `ci.yml` | Backend `mvn verify`, frontend lint + test + typecheck, Terraform fmt + validate | Todo push e PR |
| `spec-quality.yml` | markdownlint e rastreabilidade de REQ-ID | Quando arquivos `.md` ou `specs/` mudam |

- [ ] **Ao encontrar falha no CI** — acesse a aba Actions no GitHub, abra a execução com falha e leia o log.
- [ ] **Corrigir localmente** — reproduza o erro com os comandos do protótipo criado pelo time antes de fazer novo push.

---

## Azure — Estágio 4

O Estágio 4 é quando a equipe aplica Terraform em uma assinatura sandbox fornecida pelos facilitadores.

> [!CAUTION]
> Cada equipe tem uma cota de assinatura única. Marque todos os recursos com `team=workshop-XX` ou o `apply` falhará.

```bash
cd infra
terraform init
terraform plan -var-file=envs/dev/terraform.tfvars
terraform apply -var-file=envs/dev/terraform.tfvars
```

---

## Problemas comuns

| Sintoma | Causa provável | Correção | Como confirmar |
|---|---|---|---|
| Ambiente local trava | Porta 5432, 8080 ou 3000 já em uso | `lsof -i :5432` e encerre o processo | Serviço sobe sem erro de porta |
| `mvn verify` falha em Testcontainers | Docker não está em execução | Inicie o Docker Desktop | Testes passam na próxima execução |
| `pnpm test` falha em snapshots | Componente alterado intencionalmente | `pnpm test -- -u` para atualizar os snapshots | Testes passam após atualização |
| `terraform apply` rejeitado | Tag `team=` ausente no recurso | Adicione a tag ao recurso com falha | `terraform plan` sem erros de validação |
| GitHub Actions não acessa Azure | Incompatibilidade na declaração de assunto OIDC | Execute `az ad sp create-for-rbac` novamente para a equipe | Workflow passa na próxima execução |

---

## Quando escalar para o facilitador

- [ ] Build com falha por mais de 20 minutos sem solução.
- [ ] Assinatura Azure aparentemente suspensa.
- [ ] Qualquer ação irreversível executada por engano (por exemplo, `terraform destroy`).

Use o formato de escalonamento de 3 linhas descrito em [`00-TEAM-FLOW.md §4`](../00-TEAM-FLOW.md).

---

### Continuar a leitura

| Anterior | Próximo |
|---|---|
| [FAQ](FAQ.md)<br/><sub>Perguntas frequentes.</sub> | [Troubleshooting](troubleshooting.md)<br/><sub>Erros comuns e soluções.</sub> |

<sub>[Voltar ao índice do kit](README.md)</sub>
