---
name: "azure-pricing"
description: "Use when the user asks about the cost of an Azure service, wants to compare SKU or region prices, needs pricing data for an estimate, or asks about Copilot Studio pricing and agent credit consumption. Fetches real-time retail pricing from the public Azure Retail Prices API (no auth) and estimates Copilot Studio credits. Triggers include \"Azure pricing\", \"how much does\", \"compare SKU price\", \"cost estimate\", and \"Copilot Studio credits\". For turning an existing workload into cost-optimization issues, use az-cost-optimize."
---
# Azure pricing

Retrieve real-time Azure retail pricing from the public Azure Retail Prices API. No authentication is required; only outbound HTTPS access to `prices.azure.com`.

> [!NOTE]
> This skill depends on outbound web access (the built-in `web_fetch` tool or equivalent) to reach `prices.azure.com`. If web access is unavailable, say so and fall back to the cached rates in the reference files.

## When to invoke

- "How much does a Standard_D4s_v5 VM cost in East US?"
- "Compare Blob Storage prices across regions."
- "Give me a monthly estimate for this architecture."
- "How many Copilot Credits will our agent consume per month?"

## API endpoint

```text
GET https://prices.azure.com/api/retail/prices?api-version=2023-01-01-preview
```

Append `$filter` as a query parameter using OData filter syntax. Always use `api-version=2023-01-01-preview` so savings-plan data is included.

## Step-by-step

If anything about the request is unclear, ask clarifying questions to identify the correct filter fields and values before calling the API.

1. **Identify filter fields** from the request (service name, region, SKU, price type).
2. **Resolve the region** to an `armRegionName` — lowercase, no spaces (`East US` becomes `eastus`, `West Europe` becomes `westeurope`). See [references/REGIONS.md](references/REGIONS.md) for the full list.
3. **Build the filter string** from the fields below and fetch the URL.
4. **Parse the `Items` array** from the JSON response; each item carries price and metadata.
5. **Follow pagination** via `NextPageLink` only if you need more than the first 1000 results (rarely necessary).
6. **Calculate estimates** with the formulas in [references/COST-ESTIMATOR.md](references/COST-ESTIMATOR.md) to produce monthly and annual figures.
7. **Present results** in a summary table with service, SKU, region, unit price, and monthly/annual estimates.

## Filterable fields

| Field | Type | Example |
|---|---|---|
| `serviceName` | string (exact, case-sensitive) | `'Functions'`, `'Virtual Machines'`, `'Storage'` |
| `serviceFamily` | string (exact, case-sensitive) | `'Compute'`, `'Storage'`, `'Databases'`, `'AI + Machine Learning'` |
| `armRegionName` | string (exact, lowercase) | `'eastus'`, `'westeurope'`, `'southeastasia'` |
| `armSkuName` | string (exact) | `'Standard_D4s_v5'`, `'Standard_LRS'` |
| `skuName` | string (contains supported) | `'D4s v5'` |
| `priceType` | string | `'Consumption'`, `'Reservation'`, `'DevTestConsumption'` |
| `meterName` | string (contains supported) | `'Spot'` |

Use `eq` for equality, `and` to combine conditions, and `contains(field, 'value')` for partial matches.

## Example filter strings

| Purpose | `$filter` value |
|---|---|
| Consumption prices for Functions in East US | `serviceName eq 'Functions' and armRegionName eq 'eastus' and priceType eq 'Consumption'` |
| D4s v5 VMs in West Europe (consumption) | `armSkuName eq 'Standard_D4s_v5' and armRegionName eq 'westeurope' and priceType eq 'Consumption'` |
| All Storage prices in a region | `serviceName eq 'Storage' and armRegionName eq 'eastus'` |
| Spot pricing for a specific SKU | `armSkuName eq 'Standard_D4s_v5' and contains(meterName, 'Spot') and armRegionName eq 'eastus'` |
| One-year reservation pricing | `serviceName eq 'Virtual Machines' and priceType eq 'Reservation' and armRegionName eq 'eastus'` |
| Azure AI / OpenAI (Foundry Models) | `serviceName eq 'Foundry Models' and armRegionName eq 'eastus' and priceType eq 'Consumption'` |
| Azure Cosmos DB | `serviceName eq 'Azure Cosmos DB' and armRegionName eq 'eastus' and priceType eq 'Consumption'` |

## Full example fetch URL

```text
https://prices.azure.com/api/retail/prices?api-version=2023-01-01-preview&$filter=serviceName eq 'Functions' and armRegionName eq 'eastus' and priceType eq 'Consumption'
```

URL-encode spaces as `%20` and quotes as `%27` when constructing the URL.

## Key response fields

```json
{
  "Items": [
    {
      "retailPrice": 0.000016,
      "unitPrice": 0.000016,
      "currencyCode": "USD",
      "unitOfMeasure": "1 Execution",
      "serviceName": "Functions",
      "skuName": "Premium",
      "armRegionName": "eastus",
      "meterName": "vCPU Duration",
      "productName": "Functions",
      "priceType": "Consumption",
      "isPrimaryMeterRegion": true,
      "savingsPlan": [
        { "unitPrice": 0.000012, "term": "1 Year" },
        { "unitPrice": 0.000010, "term": "3 Years" }
      ]
    }
  ],
  "NextPageLink": null,
  "Count": 1
}
```

Only use items where `isPrimaryMeterRegion` is `true` unless the user specifically asks for non-primary meters.

## Supported serviceFamily values

`Analytics`, `Compute`, `Containers`, `Data`, `Databases`, `Developer Tools`, `Integration`, `Internet of Things`, `Management and Governance`, `Networking`, `Security`, `Storage`, `Web`, `AI + Machine Learning`.

## Tips

- `serviceName` values are case-sensitive. When unsure, filter by `serviceFamily` first to discover valid `serviceName` values.
- If results are empty, broaden the filter (remove `priceType` or region constraints first).
- Prices are in USD unless `currencyCode` is set in the request.
- For savings-plan prices, look for the `savingsPlan` array on each item (only present with `2023-01-01-preview`).
- See [references/SERVICE-NAMES.md](references/SERVICE-NAMES.md) for common service names and correct casing.

## Troubleshooting

| Issue | Solution |
|---|---|
| Empty results | Broaden the filter — remove `priceType` or `armRegionName` first |
| Wrong service name | Use the `serviceFamily` filter to discover valid `serviceName` values |
| Missing savings-plan data | Ensure `api-version=2023-01-01-preview` is in the URL |
| URL errors | Check encoding — spaces as `%20`, quotes as `%27` |
| Too many results | Add more filter fields (region, SKU, priceType) to narrow the query |

## Copilot Studio agent usage estimation

Use this section when the user asks about Copilot Studio pricing, Copilot Credits, or agent usage costs.

### Key facts

- **1 Copilot Credit = 0.01 USD.**
- Credits are pooled across the entire tenant.
- Employee-facing agents with M365 Copilot licensed users get classic answers, generative answers, and tenant graph grounding at zero cost.
- Overage enforcement triggers at 125% of prepaid capacity.

### Estimation steps

1. **Gather inputs**: agent type (employee/customer), number of users, interactions per month, knowledge percentage, tenant-graph percentage, and tool usage per session.
2. **Fetch live billing rates** with the web fetch tool so the estimate uses current Microsoft pricing.
3. **Parse the fetched content** to extract the current billing-rate table (credits per feature type).
4. **Calculate the estimate**:
   - `total_sessions = users * interactions_per_month`
   - Knowledge credits: apply tenant-graph grounding, generative-answer, and classic-answer rates.
   - Agent-tool credits: apply the agent-action rate per tool call.
   - Agent-flow credits: apply the flow rate per 100 actions.
   - Prompt-modifier credits: apply basic/standard/premium rates per 10 responses.
5. **Present results** in a table broken down by category, with total credits and estimated USD cost.

### Source URLs to fetch

| URL | Content |
|---|---|
| `https://learn.microsoft.com/en-us/microsoft-copilot-studio/requirements-messages-management` | Billing-rate table, billing examples, overage rules |
| `https://learn.microsoft.com/en-us/microsoft-copilot-studio/billing-licensing` | Licensing options, M365 Copilot inclusions, prepaid vs pay-as-you-go |

Fetch at least the first URL (billing rates) before calculating. See [references/COPILOT-STUDIO-RATES.md](references/COPILOT-STUDIO-RATES.md) for a cached snapshot of rates, formulas, and examples (fallback when web fetch is unavailable).

## Output template

Present retail pricing as a table with the source and assumptions stated:

```markdown
## Azure pricing — Standard_D4s_v5, eastus

| Service | SKU | Region | Unit price | Unit | Monthly est. |
|---|---|---|---|---|---|
| Virtual Machines | Standard_D4s_v5 | eastus | $0.192 | 1 Hour | ~$140 (730 h) |
| Virtual Machines | Standard_D4s_v5 (1yr savings plan) | eastus | $0.113 | 1 Hour | ~$82 (730 h) |

Source: Azure Retail Prices API, api-version 2023-01-01-preview, retrieved 2026-08-17. Prices in USD; assumes 730 h/month, isPrimaryMeterRegion only.
```

## Quality gate

- [ ] The region is resolved to a valid lowercase `armRegionName`.
- [ ] The filter uses the exact, case-sensitive `serviceName`/`serviceFamily`.
- [ ] Only `isPrimaryMeterRegion == true` items are used unless non-primary meters were requested.
- [ ] `api-version=2023-01-01-preview` is used so savings-plan data is available when relevant.
- [ ] Monthly/annual estimates state their assumptions (hours, quantity) and cite the API and retrieval date.
- [ ] The currency is stated (USD unless the request specifies otherwise).
- [ ] Copilot Studio estimates use freshly fetched rates, or explicitly note the cached fallback.
