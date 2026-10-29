---
name: "Test Plan Creator"
description: "A concise description of what this skill does (10-500 chars)."
version: "1.0.0"
author: "Krishnamurthy"
license: "MIT"
tags:
  - example
testingTypes:
  - e2e
frameworks:
  - playwright
languages:
  - typescript
domains:
  - web
agents:
  - claude-code
  - cursor
  - github-copilot
---
---
name: test-plan-creator
description: Create comprehensive, risk-based software test plans from requirements, user stories, PRDs, API specifications, or repository code. Use when asked to write a test plan, QA strategy, release test approach, regression scope, or testing estimates. Supports manual and automated testing, including Playwright and API tests.
---

# Test Plan Creator

## Goal
Create an actionable, traceable, risk-based test plan that a QA team can execute and maintain. Adapt depth to the system and release. Do not invent requirements or assert that tests have run.

## Inputs
Gather available information, in priority order:
1. Product purpose and features in scope.
2. Requirements, user stories, acceptance criteria, designs, API specifications, and relevant source code.
3. Release or change scope, supported platforms, user roles, integrations, and dependencies.
4. Test environments, tools, data constraints, team capacity, and timelines.
5. Known bugs, production incidents, compliance requirements, and high-risk workflows.

If information is missing, make clearly labeled assumptions and list precise open questions. Do not block the initial draft for noncritical details.

## Workflow

### 1. Understand scope
- Summarize the product/change and intended users.
- Identify in-scope and out-of-scope functionality.
- Map every relevant requirement or story to at least one coverage area.
- Separate confirmed facts from assumptions.

### 2. Analyze risk
- Identify failure modes and assess likelihood (Low/Medium/High) and impact (Low/Medium/High).
- Prioritize security, data integrity, authentication, payments, privacy, critical journeys, integrations, and historically fragile areas when applicable.
- Explain why P0/P1 tests are high priority.

### 3. Design coverage
Consider only the areas relevant to the product:
- Functional positive, negative, boundary, equivalence partitioning, and state transitions.
- API contracts, authorization, validation, errors, idempotency, and resilience.
- UI usability, accessibility, browser/device compatibility, and responsive behavior.
- Integration, end-to-end, regression, smoke, and exploratory testing.
- Security, performance, reliability, localization, and recovery where relevant.
- Observability, logs, feature flags, migrations, and rollback where relevant.

Include realistic edge cases and failure paths. Don't equate test volume with quality.

### 4. Establish execution strategy
- Organize tests into smoke, critical path, full regression, and nonfunctional suites.
- Label suitable automation candidates and manual-only checks with rationale.
- For web projects, prefer Playwright for stable UI journeys if the team uses it; use API-level tests for faster feedback where possible.
- Specify environment, fixtures, test accounts/roles, synthetic data, cleanup, mocks/service virtualization, CI triggers, reporting, and defect triage.
- Never use real credentials or production personal data in examples.

### 5. Define release gates
- Entry criteria: stable build, available environment, agreed requirements, access and data readiness.
- Exit criteria: critical coverage completion, clear pass/fail status, acceptable defect severity, agreed residual risk, stakeholder sign-off.
- Define blockers, escalation, dependencies, and contingency plans.

### 6. Review and validate
Before finalizing, check:
- Each in-scope requirement has planned coverage.
- Every high-risk workflow has positive and failure cases.
- Test IDs are unique and priorities consistent.
- Expected outcomes are measurable.
- Assumptions, gaps, and exclusions are visible.
- Metrics and release gates are realistic and not fabricated.

## Default output format
Produce a Markdown document with these sections:

1. **Test Plan Overview**: name, version, date, owner (TBD if unknown), objective.
2. **Product / Change Summary**.
3. **Scope**: in scope and out of scope.
4. **Assumptions and Dependencies**.
5. **Risk Assessment**: table with area, failure risk, likelihood, impact, mitigation, priority.
6. **Test Strategy**: test levels/types, manual vs. automation approach, exploratory testing.
7. **Environment and Test Data**.
8. **Test Scenarios**: table with ID, requirement/story, scenario, test type, priority, expected result, automation candidate.
9. **Requirements Traceability Matrix**: requirement to scenario IDs; mark requirements without coverage.
10. **Execution Plan**: phases, sequencing, owners (TBD if unknown), dependencies.
11. **Entry and Exit Criteria**.
12. **Defect Management and Reporting**: severity definitions, triage cadence, metrics.
13. **Risks, Open Questions, and Decisions Needed**.

Use concise tables and concrete examples. If the user requests a brief test plan, condense sections without dropping scope, risks, coverage, or release criteria.

## Priority definitions
- **P0 / Critical**: essential user journey or severe security/data-loss risk; must pass before release.
- **P1 / High**: important feature or common failure path; strong release gate.
- **P2 / Medium**: secondary workflow, compatibility, less common cases.
- **P3 / Low**: cosmetic or rare low-impact behavior.

Priority indicates execution order and business risk, not defect severity.

## Automation guidance
When the user requests implementation:
- Inspect existing framework, conventions, and package configuration before generating code.
- For Playwright + TypeScript, use existing fixtures and Page Object Model if present; avoid arbitrary waits and brittle selectors.
- Keep assertions observable and deterministic; ensure isolation and data cleanup.
- Clearly distinguish proposed test code from tests actually executed.
- Do not modify application code unless explicitly asked.

## Quality rules
- Never invent a feature, requirement ID, test result, environment URL, or compliance mandate.
- Label illustrative examples as examples.
- State uncertainty and ask only the most consequential clarification questions after presenting a useful draft.
- Prefer risk-weighted coverage over exhaustive, repetitive cases.
