---
name: test-case-creator
description: Create detailed, traceable, review-ready software test cases from requirements, user stories, acceptance criteria, API contracts, designs, or existing application code. Use when asked to generate manual test cases, a test case matrix, edge cases, negative tests, regression coverage, or Playwright automation candidates.
---

# Test Case Creator

## Purpose
Generate precise, executable test cases based on available evidence. Cover business workflows, validation, errors, boundaries, security-related behavior, and regression risks without inventing requirements.

## When to use
Use this skill when the user requests test cases for a feature, user story, screen, API, or application workflow. It can also review existing test cases for coverage gaps and duplicates.

## Inputs to inspect
1. User story, business requirements, and acceptance criteria.
2. Designs, API specifications, validation rules, and error messages.
3. Existing implementation, tests, fixtures, page objects, and project conventions if accessible.
4. User preferences for format (Markdown, CSV, Excel), test levels, browsers, and automation framework.

If key information is missing, proceed using explicit assumptions. Separate confirmed requirements from assumptions and unresolved questions. Never present guessed behavior as a requirement.

## Workflow
1. **Extract requirements:** Assign requirement IDs (`REQ-001`, etc.) and summarize expected behavior.
2. **Identify test conditions:** Map each requirement to observable behavior and expected outcomes.
3. **Design coverage:** Include relevant positive, negative, boundary, equivalence partitioning, state transition, decision table, error handling, authorization, accessibility, usability, compatibility, and regression tests. Only include applicable categories.
4. **Prioritize:** Use `P0` (business-critical/blocker), `P1` (high), `P2` (medium), `P3` (low). Base priority on impact, frequency, and likelihood.
5. **Write atomic cases:** One clear objective per case; deterministic steps, reproducible data, and measurable expected results.
6. **Identify automation:** Label `Automate`, `Manual`, or `Evaluate`; explain where automation adds value, especially using Playwright for stable UI flows.
7. **Check traceability:** Every applicable requirement must map to at least one test case; flag uncovered requirements.
8. **Review:** Remove duplicates, avoid vague assertions, check independent setup/cleanup, ensure negative and boundary tests where appropriate.
9. **Produce output:** Save to the user-requested location and format, otherwise `TEST_CASES.md`. If repository access is available, follow its conventions and avoid overwriting existing artifacts without instruction.

## Mandatory test case fields
- **Test Case ID:** unique and stable, e.g. `TC-LOGIN-001`
- **Requirement ID(s):** linked acceptance criterion or `Unmapped`
- **Title:** action and intended behavior
- **Module / feature**
- **Test type:** functional, negative, boundary, security, accessibility, etc.
- **Priority:** P0/P1/P2/P3
- **Preconditions:** user state, permissions, flags, dependencies
- **Test data:** concrete, safe sample values; never real credentials or secrets
- **Steps:** numbered, unambiguous actions
- **Expected result:** observable outcome corresponding to each relevant step and final state
- **Automation suitability:** Automate / Manual / Evaluate
- **Notes / assumptions:** where needed

Do not fill in actual results, execution status, pass/fail, or defect IDs unless supplied by a real test execution.

## Output template

# Test Cases: [Feature Name]

## 1. Scope and sources
- **Feature:** [name]
- **Source requirements:** [files, issue references, or user input]
- **In scope:** [features covered]
- **Out of scope:** [explicit exclusions]
- **Assumptions / open questions:** [bullets]

## 2. Requirement coverage matrix
| Requirement ID | Requirement summary | Test Case IDs | Coverage |
|---|---|---|---|
| REQ-001 | [expected behavior] | TC-[...]-001 | Covered / Partial / Gap |

## 3. Test case summary
| ID | Title | Type | Priority | Requirement | Automation |
|---|---|---|---|---|---|
| TC-[MODULE]-001 | [clear test objective] | Positive | P1 | REQ-001 | Automate |

## 4. Detailed test cases

### TC-[MODULE]-001: [Title]
- **Requirement:** REQ-001
- **Type:** Positive
- **Priority:** P1
- **Preconditions:** [specific state]
- **Test data:** [specific values]
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | [exact action] | [observable result] |
| 2 | [exact action] | [observable result] |

- **Cleanup:** [restore state, if necessary]
- **Assumptions / notes:** [if applicable]

## 5. Coverage gaps and questions
- [missing detail, requirement, or edge case]

## 6. Automation recommendations
- **Playwright candidates:** [stable critical paths, validation, role-based scenarios]
- **Manual / specialist checks:** [visual, accessibility exploratory, penetration testing where required]
- **Test fixtures / mocks:** [needed data or dependencies]

## Quality gates
Before delivering, verify:
- Every test case has a unique ID and traceability link where possible.
- Every step is actionable and the expected result is measurable.
- Coverage includes risk-relevant positive, negative, and boundary cases.
- Permissions, data integrity, and error paths are considered when applicable.
- Cases are independent or clearly describe dependencies and cleanup.
- No fabricated requirements, execution outcomes, or security guarantees.
- Redundant scenarios are consolidated; missing requirements are highlighted.

## Usage examples
- "Use the test-case-creator skill to create test cases for a login page based on these acceptance criteria."
- "Analyze this user story and produce a test case matrix with boundaries and negative cases."
- "Inspect the checkout feature and save review-ready test cases to docs/TEST_CASES.md."
- "Identify which test cases should be automated in Playwright TypeScript, but do not write test code yet."

## Important distinction
This skill **creates test cases**, not a high-level test plan, test scripts, or fabricated execution results. Generate Playwright code only when specifically requested.
