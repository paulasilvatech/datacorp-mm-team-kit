---
description: "Use when implementing or reviewing Next.js 15 App Router, TypeScript, Tailwind CSS, shadcn/ui, and server components under frontend/."
applyTo: "frontend/app/**,frontend/components/**,frontend/src/app/**,frontend/src/components/**,frontend/**/*.ts,frontend/**/*.tsx"
---

# Especificação de Frontend — Next.js 15 + TypeScript

Este arquivo é ativado quando você trabalha em TypeScript, TSX, `app/` ou `components/` dentro de `frontend/`. Ele reforça as convenções de frontend para o sistema modernizado.

## Resumo da Stack

| Camada | Tecnologia | Versão |
|-------|-----------|---------|
| Framework | Next.js (App Router) | 15 |
| Linguagem | TypeScript (strict mode) | 5+ |
| Estilo | Tailwind CSS | 3.4+ |
| Componentes | shadcn/ui | Latest |
| Estado (client) | React `useState` e Context quando necessário | Nativo |
| Dados no servidor | Server Components e Server Actions | Nativo |
| Testes | Vitest + Testing Library | Latest |

## Padrões do App Router

### Server Components (Padrão)

Todo componente é um Server Component, salvo marcação explícita em contrário. Server Components:

- Rodam no servidor, nunca enviam JS para o client
- Podem usar `await` diretamente em fetches de dados
- Não podem usar hooks, event handlers ou APIs do browser

```tsx
// app/<resource>/page.tsx — Server Component (default)
export default async function ResourcePage() {
  const response = await fetch('/api/v1/<resource>');
  if (!response.ok) throw new Error('Resource loading failed');
  const resources = await response.json();
  return <ResourceList resources={resources} />;
}
```

### Client Components

Adicione `'use client'` somente quando precisar de interatividade:

```tsx
'use client';

import { useState } from 'react';

export function ResourceFilter({ onFilter }: { onFilter: (term: string) => void }) {
  const [term, setTerm] = useState('');
  return (
    <input
      value={term}
      onChange={e => { setTerm(e.target.value); onFilter(e.target.value); }}
      placeholder="Filter resources..."
    />
  );
}
```

Regras:

- **Minimize a superfície de `'use client'`**: Empurre a interatividade para o menor componente possível. Uma página que busca dados deve ser um Server Component; somente o filtro/form interativo dentro dela deve ser um Client Component.
- **Nunca exponha secrets em client components**: API keys, tokens e URLs internas devem permanecer server-side.
- **Evite dependências de estado por padrão**: Use `useState` local e Context para estado client compartilhado. Adicione uma biblioteca de estado ou cache somente com ADR que justifique a dependência.

### Server Actions para Mutations

Use server actions em vez de API route handlers para submissões de formulário:

```tsx
// app/<resource>/actions.ts
'use server';

export async function createResource(formData: FormData) {
  const value = formData.get('value');
  // Valida e chama a API de backend
  const res = await fetch(`${process.env.API_URL}/api/v1/<resource>`, {
    method: 'POST',
    body: JSON.stringify({ value }),
    headers: { 'Content-Type': 'application/json' },
  });
  if (!res.ok) throw new Error('Resource creation failed');
}
```

## Convenções TypeScript

- **`strict: true`** em `tsconfig.json` — sem exceções, sem `// @ts-ignore`
- **Sem `any`**: Use `unknown` e refine com type guards
- **Somente named exports em componentes reutilizáveis**: `export function ResourceCard()`. Arquivos de rota do App Router podem usar o `export default` exigido pelo Next.js.
- **Interface em vez de type** para object shapes que podem ser estendidos
- **Utility types**: Use `Pick`, `Omit`, `Partial` em vez de duplicar interfaces

```tsx
// Good: named export, typed props
export function ResourceCard({ resource }: { resource: ResourceDto }) {
  return <div>{resource.label}</div>;
}

// Bad: default export, any type
export default function ResourceCard({ resource }: { resource: any }) { ... }
```

## Tailwind CSS + shadcn/ui

- Use classes utilitárias do Tailwind diretamente — sem arquivos CSS separados, a menos que seja absolutamente necessário
- Use componentes shadcn/ui para elementos padrão de UI (Button, Card, Table, Dialog etc.)
- Quando o time definir tokens de design system, use-os para cores e espaçamento
- Responsivo por padrão: mobile-first com breakpoints `sm:`, `md:`, `lg:`

```tsx
import { Card, CardContent, CardHeader, CardTitle } from '@/components/ui/card';

export function ResourceSummary({ total }: { total: number }) {
  return (
    <Card>
      <CardHeader>
        <CardTitle>Resource Summary</CardTitle>
      </CardHeader>
      <CardContent>
        <p className="text-2xl font-bold">{total.toLocaleString('pt-BR', { style: 'currency', currency: 'BRL' })}</p>
      </CardContent>
    </Card>
  );
}
```

## Baseline de Acessibilidade

Toda página e componente deve cumprir estes mínimos:

- Todas as imagens têm texto `alt`
- Inputs de formulário têm elementos `<label>` associados
- Elementos interativos são navegáveis por teclado
- Cor não é o único meio de transmitir informação
- A página tem um único `<h1>`, e headings seguem ordem lógica

## Testes com Vitest

```tsx
import { render, screen } from '@testing-library/react';
import { describe, it, expect } from 'vitest';
import { ResourceCard } from './ResourceCard';

describe('ResourceCard', () => {
  it('displays the resource label when a resource is provided', () => {
    render(<ResourceCard resource={{ label: 'Example' }} />);
    expect(screen.getByText('Example')).toBeInTheDocument();
  });
});
```

Nome de teste: `should_[expected behavior]_when_[condition]` ou `displays [what] when [condition]`.

## O Que NÃO Fazer

- **Sem `export default`** em arquivos de componentes — use named exports
- **Sem `any`** — use `unknown` e type guards
- **Sem cadeias `.then()`** — use `async/await`
- **Sem CSS modules ou styled-components** — use Tailwind
- **Sem data fetching client-side em Server Components** — faça fetch diretamente com `await`
- **Sem secrets em arquivos `'use client'`** — variáveis de ambiente que começam com `NEXT_PUBLIC_` são expostas ao browser
