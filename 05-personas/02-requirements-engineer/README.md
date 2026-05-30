<!-- markdownlint-disable MD012 MD013 MD022 MD025 MD026 MD028 MD029 MD031 MD033 MD034 MD038 MD040 MD051 MD060 -->

# Requirements Engineer — Kit Copilot

![PERSONA Requirements Engineer](https://img.shields.io/badge/PERSONA-Requirements%20Engineer-F25022?style=for-the-badge) ![MARIO 📖 Toad](https://img.shields.io/badge/MARIO-📖%20Toad-1A1A1A?style=for-the-badge) ![PAR Par 1 · Visão](https://img.shields.io/badge/PAR-Par%201%20·%20Visão-737373?style=for-the-badge)

> 🗺 **Você está aqui:** [Kit PT-BR](../../README.md) → [Personas](../OVERVIEW.md) → **Requirements Engineer**

> **Para quem é isto?** Para a pessoa que vai vestir esta persona durante o workshop.
>
> **O que você terá ao final desta leitura:**
>
> 1. Lista de arquivos do kit (agente, prompts, skills, MCP)
> 2. Como instalar no `.github/` do repo do time
> 3. Boas práticas específicas desta persona
>
> 📘 **Antes de mais nada:** abra o `PERSONA.md` desta pasta para ver missão, atributos e prompts prontos.


<!-- markdownlint-disable MD013 MD022 MD031 MD032 MD060 -->

> Notação EARS, detecção de drift de especificação e análise de contradições.

Leia primeiro: [PERSONA.md](PERSONA.md).

## Fase do SDLC
Requisitos, Especificação

## Conteúdo do kit

| Arquivo | Tipo | Propósito |
|------|------|---------|
| `PERSONA.md` | Persona | Responsabilidades, passagens, prompts e rubrica do Requirements Engineer |
| `.github/agents/requirements-engineer.agent.md` | Agent | Análise de requisitos |
| `.github/prompts/spec-sync.prompt.md` | Prompt | `/spec-sync` |
| `.github/prompts/contradiction-check.prompt.md` | Prompt | `/contradiction-check` |
| `.github/prompts/ears-convert.prompt.md` | Prompt | `/ears-convert` |
| `.github/instructions/requirements.instructions.md` | Instructions | Convenções de documentação de requisitos |

## Uso no workshop

Os artefatos deste kit já estão consolidados na `.github/` da raiz do repositório:

- Agents ativos: `.github/agents/`
- Prompts ativos: `.github/prompts/persona-*.prompt.md`
- Skills ativas: `.github/skills/`
- Instructions ativas: `.github/instructions/` (quando existirem)

Use esta pasta como referência da persona e fonte de manutenção. Não copie `.github/*` manualmente por cima da raiz sem orientação do facilitador.

Se este kit tiver `mcp.json` e o facilitador pedir MCP local, copie apenas esse arquivo para `.vscode/mcp.json`.

## Boas práticas
- Use padrões EARS exclusivamente; requisitos vagos precisam ser quantificados.
- Todo `REQ-ID` deve ser único, imutável e rastreável a pelo menos um teste e uma task.
- Faça uma passada de contradição antes de aceitar novas specs.
- Remova ou quantifique termos ambíguos como “adequado”, “razoável” e “amigável”.

## Referências
- [EARS Notation - Alistair Mavin](https://alistairmavin.com/ears/)
- [IEEE 29148 - Requirements Engineering](https://www.iso.org/standard/72089.html)
- [ISO/IEC 25010 - Quality Model](https://iso25000.com/index.php/en/iso-25000-standards/iso-25010)
- [Writing Good Requirements - INCOSE](https://www.incose.org/)

---

## Navegação

| Anterior | Início |
|--------|------|
| [Persona Kits](../README.md) | [Kit PT-BR](../../README.md) |

---

### Continuar a leitura

<table width="100%">
<tr>
<td width="50%" valign="top" align="left">
<sub><strong>← ANTERIOR</strong></sub><br/>
<a href="../OVERVIEW.md"><strong>OVERVIEW</strong></a><br/>
<sub>Tabela das 10 personas.</sub>
</td>
<td width="50%" valign="top" align="right">
<sub><strong>PRÓXIMO →</strong></sub><br/>
<a href="PERSONA.md"><strong>PERSONA.md</strong></a><br/>
<sub>Ficha desta persona.</sub>
</td>
</tr>
</table>

<sub>↑ <a href="../README.md">Voltar ao Kit PT-BR</a></sub>

