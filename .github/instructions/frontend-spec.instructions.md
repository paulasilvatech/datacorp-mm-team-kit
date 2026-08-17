---
description: "Use when implementing or reviewing Next.js 15 App Router, TypeScript, Tailwind CSS, shadcn/ui, and server components under frontend/."
applyTo: "frontend/app/**,frontend/components/**,frontend/src/app/**,frontend/src/components/**,frontend/**/*.ts,frontend/**/*.tsx"
---

# Frontend Specification — Next.js 15 + TypeScript

This file is activated when you work with TypeScript, TSX, `app/`, or `components/` within `frontend/`. It enforces the frontend conventions for the modernized system.

## Stack Summary

| Layer | Technology | Version |
|-------|-----------|---------|
| Framework | Next.js (App Router) | 15 |
| Language | TypeScript (strict mode) | 5+ |
| Styling | Tailwind CSS | 3.4+ |
| Components | shadcn/ui | Latest |
| State (client) | React `useState` and Context when necessary | Native |
| Server data | Server Components and Server Actions | Native |
| Testing | Vitest + Testing Library | Latest |

## App Router Patterns

### Server Components (Default)

Every component is a Server Component unless explicitly marked otherwise. Server Components:

- Run on the server and never send JS to the client
- Can use `await` directly for data fetching
- Cannot use hooks, event handlers, or browser APIs

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

Add `'use client'` only when interactivity is required:

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

Rules:

- **Minimize the `'use client'` surface area**: Push interactivity into the smallest possible component. A page that fetches data MUST be a Server Component; only the interactive filter/form within it MUST be a Client Component.
- **NEVER expose secrets in client components**: API keys, tokens, and internal URLs MUST remain server-side.
- **Avoid state dependencies by default**: Use local `useState` and Context for shared client state. Add a state or caching library only with an ADR that justifies the dependency.

### Server Actions for Mutations

Use server actions instead of API route handlers for form submissions:

```tsx
// app/<resource>/actions.ts
'use server';

export async function createResource(formData: FormData) {
  const value = formData.get('value');
  // Validate and call the backend API
  const res = await fetch(`${process.env.API_URL}/api/v1/<resource>`, {
    method: 'POST',
    body: JSON.stringify({ value }),
    headers: { 'Content-Type': 'application/json' },
  });
  if (!res.ok) throw new Error('Resource creation failed');
}
```

## TypeScript Conventions

- **`strict: true`** in `tsconfig.json` — no exceptions, no `// @ts-ignore`
- **No `any`**: Use `unknown` and narrow it with type guards
- **Named exports only in reusable components**: `export function ResourceCard()`. App Router route files may use the `export default` required by Next.js.
- **Interface instead of type** for object shapes that can be extended
- **Utility types**: Use `Pick`, `Omit`, and `Partial` instead of duplicating interfaces

```tsx
// Good: named export, typed props
export function ResourceCard({ resource }: { resource: ResourceDto }) {
  return <div>{resource.label}</div>;
}

// Bad: default export, any type
export default function ResourceCard({ resource }: { resource: any }) { ... }
```

## Tailwind CSS + shadcn/ui

- Use Tailwind utility classes directly — no separate CSS files unless absolutely necessary
- Use shadcn/ui components for standard UI elements (Button, Card, Table, Dialog, etc.)
- When the team defines design system tokens, use them for colors and spacing
- Responsive by default: mobile-first with `sm:`, `md:`, and `lg:` breakpoints

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

## Accessibility Baseline

Every page and component MUST meet these minimum requirements:

- All images have `alt` text
- Form inputs have associated `<label>` elements
- Interactive elements are keyboard-navigable
- Color is not the only means of conveying information
- The page has a single `<h1>`, and headings follow a logical order

## Testing with Vitest

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

Test name: `should_[expected behavior]_when_[condition]` or `displays [what] when [condition]`.

## What NOT to Do

- **No `export default`** in component files — use named exports
- **No `any`** — use `unknown` and type guards
- **No `.then()` chains** — use `async/await`
- **No CSS modules or styled-components** — use Tailwind
- **No client-side data fetching in Server Components** — fetch directly with `await`
- **No secrets in `'use client'` files** — environment variables beginning with `NEXT_PUBLIC_` are exposed to the browser
