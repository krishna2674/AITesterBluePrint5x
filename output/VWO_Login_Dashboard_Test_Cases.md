# Test Cases: VWO Login Dashboard

## 1. Scope and sources

- **Feature:** VWO Login Dashboard
- **Source requirements:** [VWO Login Dashboard Test Plan](./VWO_Login_Dashboard_Test_Plan.pdf), derived from the supplied Product Requirements Document (PRD).
- **Requirement ID note:** The plan labels `RQ-*` are topic labels introduced for traceability; the PRD does not define formal requirement IDs. `REQ-*` IDs below normalize those topics for these test cases and do not add requirements.
- **In scope:** Login and validation, session behavior, password recovery, optional MFA/SSO/social login, responsive and accessible UI, registration/support navigation, dashboard handoff, analytics, security configuration, rate limiting, performance, capacity, availability, and success KPI.
- **Out of scope:** Post-login VWO workflows beyond the handoff and account-context check; future enhancements listed as future in the PRD unless explicitly added to the release.
- **Execution status:** Not executed. No results, defects, or pass/fail statuses are asserted in this document.

### Assumptions and open questions

- Optional capabilities (MFA, enterprise SSO, social login, dark mode, remember-me) are conditional on confirmation that they are enabled in the release.
- Use an isolated test environment, synthetic accounts and addresses, provider test tenants, a non-production email sink, and a test analytics sink. Never use production credentials or personal data.
- Test steps refer to visible controls and approved environment configurations; confirm locators, exact text, and supported browsers with the implementation before automation.
- Product/security owners must define password policy, session and remember-me lifetimes, reset-token lifetime/reuse, rate-limit behavior, generic error copy, supported providers, and account-linking rules.
- Performance definitions, load thresholds, availability observation window, analytics event schema, and the login KPI denominator require approval before those measurements can be release gates.

## 2. Requirement coverage matrix

| Requirement ID | Requirement summary | Test Case IDs | Coverage |
|---|---|---|---|
| REQ-001 | Authenticate valid credentials and deny invalid, unknown, and malformed credentials without disclosing account existence. | TC-VWO-001–004 | Covered; exact error wording is TBD. |
| REQ-002 | Validate form fields and present usable input feedback. | TC-VWO-005–007 | Partial; validation rules and boundaries need product confirmation. |
| REQ-003 | Show processing state and handle duplicate submission and service/network errors. | TC-VWO-008–009 | Covered; exact retry behavior is TBD. |
| REQ-004 | Honor remember-me selection and session persistence policy. | TC-VWO-010–011 | Partial; persistence durations are TBD. |
| REQ-005 | Expire/revoke sessions and protect dashboard access. | TC-VWO-012 | Partial; timeout/revocation rules are TBD. |
| REQ-006 | Provide a safe password-reset request and token lifecycle. | TC-VWO-013–015 | Partial; response, token lifetime, and reuse policy are TBD. |
| REQ-007 | Enforce approved password rules on reset and subsequent login. | TC-VWO-016 | Partial; password rules are TBD. |
| REQ-008 | Enforce optional MFA challenges and recovery behavior. | TC-VWO-017 | Conditional; feature/method must be confirmed. |
| REQ-009 | Authenticate through enabled enterprise SSO providers safely. | TC-VWO-018–019 | Conditional; provider/protocol/claim rules are TBD. |
| REQ-010 | Support optional social login safely. | TC-VWO-020 | Conditional; provider and account-linking rules are TBD. |
| REQ-011 | Render usable login and recovery flows at supported viewports. | TC-VWO-021 | Partial; viewport/device matrix is TBD. |
| REQ-012 | Support keyboard, screen-reader, contrast, and theme accessibility. | TC-VWO-022–023 | Partial; manual WCAG 2.1 AA assessment is required. |
| REQ-013 | Provide an accessible free-trial registration path. | TC-VWO-024 | Partial; destination and tracking expectations are TBD. |
| REQ-014 | Transition authorized users to the correct dashboard/account context. | TC-VWO-025 | Covered; dashboard contract is TBD. |
| REQ-015 | Emit approved analytics without exposing authentication secrets. | TC-VWO-026 | Partial; event schema and KPI denominator are TBD. |
| REQ-016 | Provide a working login assistance/support route. | TC-VWO-027 | Partial; support channels and outage behavior are TBD. |
| REQ-017 | Protect credentials and sessions in transport, storage, and logs. | TC-VWO-028 | Partial; specialist security review/configuration evidence required. |
| REQ-018 | Apply rate limiting according to approved policy. | TC-VWO-029 | Partial; threshold and recovery policy are TBD. |
| REQ-019 | Meet the PRD login-page load target under an agreed measurement method. | TC-VWO-030 | Partial; PRD target is under 2 seconds; method is TBD. |
| REQ-020 | Sustain the approved concurrent-login workload and dependency failures. | TC-VWO-031 | Partial; PRD cites thousands of concurrent attempts; workload/SLOs are TBD. |
| REQ-021 | Report availability against the PRD 99.9% goal using an agreed period. | TC-VWO-032 | Partial; operational window/SLO and evidence owner are TBD. |
| REQ-022 | Measure login-success rate against the PRD 95%+ target. | TC-VWO-033 | Partial; eligible-attempt denominator and reporting period are TBD. |
| REQ-023 | Observe state changes and errors clearly and accessibly throughout the flow. | TC-VWO-008, TC-VWO-013–019, TC-VWO-022, TC-VWO-027 | Covered across the mapped journeys; copy/content remains TBD. |
| REQ-024 | Keep authentication and reset error paths safe and recoverable. | TC-VWO-002–004, TC-VWO-009, TC-VWO-013–020, TC-VWO-027, TC-VWO-029, TC-VWO-031 | Covered; provider-specific recovery behavior requires confirmation. |

## 3. Test case summary

| ID | Title | Type | Priority | Requirement | Automation |
|---|---|---|---|---|---|
| TC-VWO-001 | Log in with valid credentials | Positive / E2E | P0 | REQ-001, REQ-014 | Automate |
| TC-VWO-002 | Reject an incorrect password for an existing account | Negative | P0 | REQ-001, REQ-024 | Automate |
| TC-VWO-003 | Reject an unknown email without account enumeration | Security / Negative | P0 | REQ-001 | Automate |
| TC-VWO-004 | Validate blank and malformed login inputs | Negative / Boundary | P0 | REQ-001–002 | Automate |
| TC-VWO-005 | Validate email format on blur | Functional / Usability | P1 | REQ-002 | Automate |
| TC-VWO-006 | Validate clickable labels and input focus | Accessibility / Usability | P1 | REQ-002, REQ-012 | Automate |
| TC-VWO-007 | Validate password feedback and configured boundaries | Boundary | P1 | REQ-002, REQ-007 | Automate |
| TC-VWO-008 | Show and clear login processing state | Functional / State transition | P0 | REQ-003, REQ-023 | Automate |
| TC-VWO-009 | Recover from login network or service failure | Negative / Resilience | P0 | REQ-003, REQ-024 | Automate |
| TC-VWO-010 | Honor remember-me selection | Functional / Session | P0 | REQ-004 | Evaluate |
| TC-VWO-011 | Do not persist the session when remember-me is off | Negative / Session | P0 | REQ-004 | Evaluate |
| TC-VWO-012 | Deny access after session expiration or revocation | Security / Session | P0 | REQ-005 | Automate |
| TC-VWO-013 | Request a reset for an eligible account | Positive / Recovery | P0 | REQ-006, REQ-023 | Automate |
| TC-VWO-014 | Prevent account enumeration in password-reset requests | Security / Negative | P0 | REQ-006 | Automate |
| TC-VWO-015 | Accept only a valid, unused reset token | Negative / State transition | P0 | REQ-006 | Automate |
| TC-VWO-016 | Enforce password policy and invalidate the old password | Boundary / Security | P0 | REQ-007 | Automate |
| TC-VWO-017 | Require valid MFA when MFA is enabled | Positive / Negative / Security | P0 | REQ-008 | Evaluate |
| TC-VWO-018 | Complete enterprise SSO with valid identity claims | Integration / Positive | P0 | REQ-009 | Evaluate |
| TC-VWO-019 | Deny invalid or failed enterprise SSO responses | Integration / Negative / Security | P0 | REQ-009, REQ-024 | Evaluate |
| TC-VWO-020 | Handle social-login success and failure safely | Integration | P1 | REQ-010 | Evaluate |
| TC-VWO-021 | Use login and reset flows at supported viewport sizes | Responsive / Compatibility | P1 | REQ-011 | Automate |
| TC-VWO-022 | Complete login using keyboard and screen reader | Accessibility | P1 | REQ-012, REQ-023 | Manual |
| TC-VWO-023 | Verify theme and high-contrast readability | Accessibility / Visual | P1 | REQ-012 | Evaluate |
| TC-VWO-024 | Navigate to free-trial registration | Functional / Navigation | P2 | REQ-013 | Automate |
| TC-VWO-025 | Land on the correct VWO dashboard and tenant | E2E / Authorization | P0 | REQ-014 | Automate |
| TC-VWO-026 | Verify authentication analytics and secret-free payloads | Integration / Privacy | P1 | REQ-015 | Evaluate |
| TC-VWO-027 | Reach support from the login/recovery experience | Functional / Resilience | P2 | REQ-016, REQ-024 | Evaluate |
| TC-VWO-028 | Verify transport and secret-handling configuration | Security | P0 | REQ-017 | Manual |
| TC-VWO-029 | Enforce configured throttling for repeated failed attempts | Security / Boundary | P0 | REQ-018, REQ-024 | Evaluate |
| TC-VWO-030 | Measure page load against the PRD target | Performance | P1 | REQ-019 | Evaluate |
| TC-VWO-031 | Exercise concurrent login load and dependency degradation | Load / Resilience | P1 | REQ-020, REQ-024 | Evaluate |
| TC-VWO-032 | Review availability and alerting evidence | Reliability | P1 | REQ-021 | Manual |
| TC-VWO-033 | Calculate login-success KPI using the approved definition | Analytics | P2 | REQ-022 | Evaluate |

## 4. Detailed test cases

### TC-VWO-001: Log in with valid credentials
- **Requirement:** REQ-001, REQ-014
- **Module / feature:** Email/password authentication
- **Type:** Positive / E2E
- **Priority:** P0
- **Preconditions:** Staging is available over HTTPS; a synthetic active account can log in; dashboard destination is configured.
- **Test data:** Synthetic account such as `qa.login+valid@example.test`; password held in the approved test secret store (do not put an actual secret in this document).
- **Automation:** Automate (Playwright UI and/or API contract)

| Step | Action | Expected result |
|---|---|---|
| 1 | Open the configured staging login URL. | Login page renders and the email and password controls are available. |
| 2 | Enter the synthetic account email and its test password. | Inputs accept the values; no credential is exposed outside the form. |
| 3 | Submit the form once. | Processing feedback is shown while authentication is pending. |
| 4 | Wait for the observable completion state. | Authentication succeeds and the intended VWO dashboard/account opens. |

- **Cleanup:** Sign out and invalidate the test session if supported.
- **Assumptions / notes:** Dashboard URL and account-context expectations must be confirmed for the environment.

### TC-VWO-002: Reject an incorrect password for an existing account
- **Requirement:** REQ-001, REQ-024
- **Module / feature:** Email/password authentication
- **Type:** Negative
- **Priority:** P0
- **Preconditions:** A synthetic active account exists; account is not already throttled.
- **Test data:** Existing synthetic email; intentionally incorrect password.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Open staging login and enter the existing synthetic email with the incorrect password. | Form accepts input and does not disclose account state before submission. |
| 2 | Submit the form. | Authentication is denied and no authenticated session is created. |
| 3 | Inspect the visible response and resulting page state. | A clear, approved generic error is shown; no password value is echoed and the dashboard is not accessible. |

- **Cleanup:** Clear the form; reset account throttling only through the approved test procedure if triggered.
- **Assumptions / notes:** Error wording and any attempt counter behavior are not specified in the PRD.

### TC-VWO-003: Reject an unknown email without account enumeration
- **Requirement:** REQ-001
- **Module / feature:** Login security
- **Type:** Security / Negative
- **Priority:** P0
- **Preconditions:** Staging login is available; use a synthetic address not registered in the test tenant.
- **Test data:** `qa.login+unknown@example.test`; arbitrary test-only password.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Submit the unknown synthetic email and test-only password. | Authentication is denied; no session is created. |
| 2 | Record visible error content and response shape without storing sensitive data. | Response does not confirm whether the address is registered. |
| 3 | Compare the response with TC-VWO-002 using the same environment and method. | User-visible behavior and externally observable response do not reveal account existence beyond approved policy. |

- **Cleanup:** None; do not create the address as a real account.
- **Assumptions / notes:** Exact timing-equivalence thresholds are not specified; security review should assess timing if in scope.

### TC-VWO-004: Validate blank and malformed login inputs
- **Requirement:** REQ-001, REQ-002
- **Module / feature:** Login form validation
- **Type:** Negative / Boundary
- **Priority:** P0
- **Preconditions:** Login page is open.
- **Test data:** Empty email/password; malformed email samples such as `name@`, `@example.test`, and whitespace-only values.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Submit the form with both fields empty. | Required-field feedback follows the documented validation behavior; no authentication request is made if validation is client-side. |
| 2 | Enter a malformed email with a test-only password and submit. | Invalid email is identified according to the approved validation policy; no session is created. |
| 3 | Enter a valid-shaped email and blank password, then submit. | Missing-password feedback appears; authentication is not granted. |
| 4 | Review each resulting state with keyboard focus. | Error feedback is perceivable and associated with the relevant field. |

- **Cleanup:** Clear the form.
- **Assumptions / notes:** Exact email syntax policy and whether errors appear on blur or submit require confirmation.

### TC-VWO-005: Validate email format on blur
- **Requirement:** REQ-002
- **Module / feature:** Login form validation
- **Type:** Functional / Usability
- **Priority:** P1
- **Preconditions:** Login page is open.
- **Test data:** One valid-shaped synthetic email and one malformed synthetic email.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Enter a malformed email in the email field. | Field accepts input without losing it unexpectedly. |
| 2 | Move focus to another control. | Per PRD, validation feedback appears on blur; message identifies the email field and is understandable. |
| 3 | Replace the value with a valid-shaped synthetic address and blur again. | Malformed-email feedback clears or updates to the valid state according to the implementation. |

- **Cleanup:** Clear the form.
- **Assumptions / notes:** Exact accepted syntax and copy need product approval.

### TC-VWO-006: Validate clickable labels and input focus
- **Requirement:** REQ-002, REQ-012
- **Module / feature:** Login form usability and accessibility
- **Type:** Accessibility / Usability
- **Priority:** P1
- **Preconditions:** Login page is open on a supported browser.
- **Test data:** None.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Click the visible email label. | Email input receives focus. |
| 2 | Click the visible password label. | Password input receives focus. |
| 3 | Reload the page and observe initial focus. | Initial focus behavior follows the design; if auto-focus is present, it targets the first input without obscuring page context. |
| 4 | Inspect each field's accessible name using browser accessibility tooling. | Each input has a programmatic name matching its visible label. |

- **Cleanup:** None.
- **Assumptions / notes:** The PRD asks for auto-focus and clickable labels; confirm desired auto-focus behavior with accessibility design before enforcing it.

### TC-VWO-007: Validate password feedback and configured boundaries
- **Requirement:** REQ-002, REQ-007
- **Module / feature:** Password entry and feedback
- **Type:** Boundary
- **Priority:** P1
- **Preconditions:** Password feedback/strength indicator is implemented; approved password rules are available.
- **Test data:** Synthetic password samples immediately below, at, and above each documented length/complexity boundary; do not use a real password.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Enter a sample below the approved minimum or complexity rule. | Feedback accurately indicates the unmet rule; value is not exposed in page text or logs. |
| 2 | Enter a sample meeting the documented rules. | Feedback reflects the compliant state. |
| 3 | Enter a sample at each documented boundary. | Acceptance/rejection matches the approved rule exactly; no unapproved rule is inferred. |

- **Cleanup:** Clear the password field.
- **Assumptions / notes:** The PRD does not specify the password policy or strength calculation; obtain it before execution.

### TC-VWO-008: Show and clear login processing state
- **Requirement:** REQ-003, REQ-023
- **Module / feature:** Login submission state
- **Type:** Functional / State transition
- **Priority:** P0
- **Preconditions:** Staging authentication can be delayed deterministically using a test stub or controlled response.
- **Test data:** Synthetic valid account.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Submit valid credentials against the controlled delayed response. | A visible loading/progress state appears while the request is pending. |
| 2 | Attempt to submit again while the request remains pending. | Duplicate submission is prevented or safely handled; no duplicate authentication request/session is created. |
| 3 | Allow the authentication request to complete successfully. | Loading state clears and the success destination is shown. |
| 4 | Repeat with a controlled authentication failure. | Loading state clears and a failure message is announced; form remains usable according to policy. |

- **Cleanup:** Remove the controlled delay and sign out any created session.
- **Assumptions / notes:** The exact loading indicator and retry semantics require design confirmation.

### TC-VWO-009: Recover from login network or service failure
- **Requirement:** REQ-003, REQ-024
- **Module / feature:** Login resilience
- **Type:** Negative / Resilience
- **Priority:** P0
- **Preconditions:** Test environment can simulate a network timeout and an authentication service error.
- **Test data:** Synthetic account; no production data.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Submit valid-shaped test credentials while the auth endpoint is configured to time out. | Progress feedback is visible and then resolves to an actionable error within the approved timeout behavior. |
| 2 | Verify the resulting state. | No authenticated session is created; entered email is handled according to approved UX; no credentials appear in error text. |
| 3 | Restore the auth endpoint and retry. | User can retry; successful authentication works without a full browser reset. |
| 4 | Repeat with a controlled server error. | Failure is presented safely and distinctly enough for recovery/support without exposing internal details. |

- **Cleanup:** Restore service configuration and remove test session if created.
- **Assumptions / notes:** Retry count, timeout duration, and error copy are TBD.

### TC-VWO-010: Honor remember-me selection
- **Requirement:** REQ-004
- **Module / feature:** Session persistence
- **Type:** Functional / Session
- **Priority:** P0
- **Preconditions:** Remember-me is enabled; synthetic account and browser profile are available.
- **Test data:** Synthetic valid account.
- **Automation:** Evaluate (browser persistence checks may require controlled browser context and server-side session inspection)

| Step | Action | Expected result |
|---|---|---|
| 1 | Select remember-me and log in. | Login succeeds and persistence choice is applied. |
| 2 | Close and reopen the same test browser context within the approved persistence period. | Session behavior matches the documented remember-me policy. |
| 3 | Inspect browser storage/cookies using approved test tooling. | No plaintext password is stored; session material follows the approved secure cookie/storage configuration. |
| 4 | Wait until the configured persistence limit or revoke the session. | Session no longer grants access after expiry/revocation. |

- **Cleanup:** Sign out, clear the isolated browser profile, and revoke the test session.
- **Assumptions / notes:** Persistence duration and cookie attributes must be specified.

### TC-VWO-011: Do not persist the session when remember-me is off
- **Requirement:** REQ-004
- **Module / feature:** Session persistence
- **Type:** Negative / Session
- **Priority:** P0
- **Preconditions:** Remember-me is enabled as an option; isolated browser profile is available.
- **Test data:** Synthetic valid account.
- **Automation:** Evaluate

| Step | Action | Expected result |
|---|---|---|
| 1 | Ensure remember-me is unchecked and log in. | Authentication succeeds without applying the persistent-session choice. |
| 2 | Close the browser context and open a fresh context according to the agreed session policy. | A new login is required when the non-persistent session is expected to end. |
| 3 | Inspect storage for credentials. | Password is not retained in plaintext or autofilled from application-managed storage. |

- **Cleanup:** Clear browser profile and revoke any active session.
- **Assumptions / notes:** Browser close behavior varies by session-cookie policy; define the expected policy before execution.

### TC-VWO-012: Deny access after session expiration or revocation
- **Requirement:** REQ-005
- **Module / feature:** Session security
- **Type:** Security / Session
- **Priority:** P0
- **Preconditions:** Synthetic user can authenticate; test environment permits controlled session expiry or revocation.
- **Test data:** Synthetic valid account and a protected dashboard route.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Authenticate and record the test session identifier using approved secure tooling. | A valid session is established; identifier is not written to the test report. |
| 2 | Expire or revoke the session through the supported test control. | Session is no longer valid server-side. |
| 3 | Request the protected dashboard using the expired session. | Access is denied and user is directed to authenticate again; protected content is not returned. |
| 4 | Use browser back navigation to revisit protected content. | Protected data is not shown from an unauthorized cached state, subject to approved cache policy. |

- **Cleanup:** Revoke the session and clear the test browser context.
- **Assumptions / notes:** Session timeout, revocation mechanism, and cache headers are implementation/security decisions.

### TC-VWO-013: Request a reset for an eligible account
- **Requirement:** REQ-006, REQ-023
- **Module / feature:** Password recovery
- **Type:** Positive / Recovery
- **Priority:** P0
- **Preconditions:** Synthetic eligible account exists; reset email sink is enabled.
- **Test data:** Synthetic eligible email, e.g. `qa.login+reset@example.test`.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Open the forgot-password flow from login. | Reset request form is displayed and usable. |
| 2 | Submit the eligible synthetic email. | Confirmation is displayed without exposing sensitive account details. |
| 3 | Inspect the non-production email sink. | One valid reset message is delivered to the eligible synthetic account. |
| 4 | Follow the reset link in the isolated test environment. | Link opens the expected reset flow over HTTPS. |

- **Cleanup:** Invalidate the test reset token and remove/expire the test message.
- **Assumptions / notes:** Email delivery timing and confirmation copy must be agreed.

### TC-VWO-014: Prevent account enumeration in password-reset requests
- **Requirement:** REQ-006
- **Module / feature:** Password recovery security
- **Type:** Security / Negative
- **Priority:** P0
- **Preconditions:** Reset flow and test email sink are available; one eligible and one unknown synthetic address are prepared.
- **Test data:** `qa.login+reset@example.test`; `qa.login+unknown@example.test`.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Request reset for the eligible address and record sanitized response characteristics. | Confirmation follows the approved safe-response policy. |
| 2 | Request reset for the unknown address. | The visible confirmation does not reveal whether an account exists. |
| 3 | Compare response text and externally observable status behavior. | Differences do not disclose account existence beyond approved policy. |
| 4 | Inspect the email sink. | Reset email is delivered only for the eligible account. |

- **Cleanup:** Invalidate any issued token and clear synthetic email messages.
- **Assumptions / notes:** Exact timing and response equivalence criteria require security-owner approval.

### TC-VWO-015: Accept only a valid, unused reset token
- **Requirement:** REQ-006
- **Module / feature:** Reset-token lifecycle
- **Type:** Negative / State transition
- **Priority:** P0
- **Preconditions:** Test controls can generate a valid token and simulate expiry; no real email/account data is used.
- **Test data:** Valid test token, expired test token, malformed token, and token already used once.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Open the reset page with a valid, unused test token. | Reset form is available for the intended account. |
| 2 | Open the page with an expired token. | Reset is refused and a safe recovery message is shown. |
| 3 | Open the page with a malformed token. | Reset is refused; no account or token details are exposed. |
| 4 | Use a valid token to complete a reset, then submit that same token again. | First use succeeds; reuse is rejected and does not change the password again. |

- **Cleanup:** Invalidate all test tokens and restore the synthetic account password.
- **Assumptions / notes:** Token expiry duration and error messaging must be specified.

### TC-VWO-016: Enforce password policy and invalidate the old password
- **Requirement:** REQ-007
- **Module / feature:** Password reset and authentication
- **Type:** Boundary / Security
- **Priority:** P0
- **Preconditions:** Reset flow is available; approved password policy is documented.
- **Test data:** Synthetic current password and new password samples that fail, meet, and sit at policy boundaries.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Attempt reset with a password failing one documented policy rule. | Reset is rejected and the unmet rule is identified without exposing the password. |
| 2 | Attempt reset with a password meeting all documented rules. | Password reset succeeds. |
| 3 | Log in with the new password. | Authentication succeeds. |
| 4 | Log in with the previous password. | Authentication is denied and no session is created. |

- **Cleanup:** Restore a known synthetic test password using the approved admin/test fixture.
- **Assumptions / notes:** Do not infer complexity, history, or length rules not specified by Product/Security.

### TC-VWO-017: Require valid MFA when MFA is enabled
- **Requirement:** REQ-008
- **Module / feature:** Multi-factor authentication
- **Type:** Positive / Negative / Security
- **Priority:** P0
- **Preconditions:** MFA is enabled for the release and a synthetic MFA-enrolled account/test challenge provider is available.
- **Test data:** Synthetic MFA account; valid, invalid, and expired challenge fixtures.
- **Automation:** Evaluate (automate deterministic test-provider challenge flow where supported)

| Step | Action | Expected result |
|---|---|---|
| 1 | Submit correct primary credentials for the MFA-enrolled account. | Primary credentials alone do not open the dashboard; MFA challenge is requested. |
| 2 | Submit an invalid challenge. | Authentication is denied and no session is established. |
| 3 | Submit an expired challenge. | Authentication is denied with safe recovery guidance. |
| 4 | Submit a valid challenge. | Authentication completes and the correct dashboard opens. |
| 5 | Attempt the approved recovery path. | Recovery follows the documented policy and cannot bypass required authorization. |

- **Cleanup:** Revoke the session and reset test MFA state.
- **Assumptions / notes:** MFA method, retry limit, backup/recovery path, and enrollment policy are TBD.

### TC-VWO-018: Complete enterprise SSO with valid identity claims
- **Requirement:** REQ-009
- **Module / feature:** Enterprise SSO
- **Type:** Integration / Positive
- **Priority:** P0
- **Preconditions:** SSO is enabled for the release; test IdP tenant and authorized synthetic identity are configured.
- **Test data:** Synthetic IdP identity and approved test claims; no real employee identity.
- **Automation:** Evaluate (automate with a dedicated test IdP/fixtures)

| Step | Action | Expected result |
|---|---|---|
| 1 | Start the configured SSO login flow. | Browser redirects to the approved test IdP using the configured protocol. |
| 2 | Authenticate as the authorized synthetic identity at the IdP. | IdP returns a signed/valid response through the expected flow. |
| 3 | Observe the application callback and result. | Application validates the response and authorized claims, creates the correct session, and opens the mapped tenant/dashboard. |

- **Cleanup:** Sign out at the application and IdP; revoke the test session.
- **Assumptions / notes:** Supported SAML/OAuth providers, claim mapping, and account provisioning rules must be confirmed.

### TC-VWO-019: Deny invalid or failed enterprise SSO responses
- **Requirement:** REQ-009, REQ-024
- **Module / feature:** Enterprise SSO security and resilience
- **Type:** Integration / Negative / Security
- **Priority:** P0
- **Preconditions:** SSO is enabled; test IdP supports denial, cancellation, invalid/expired response, and controlled outage cases.
- **Test data:** Synthetic denied identity; invalid/expired test response; unavailable test IdP.
- **Automation:** Evaluate

| Step | Action | Expected result |
|---|---|---|
| 1 | Cancel or deny authentication at the test IdP. | Application does not create a session and shows approved recovery guidance. |
| 2 | Return an invalid or expired response using the test fixture. | Application rejects the response; no session or dashboard access is granted. |
| 3 | Simulate IdP unavailability and start SSO. | Failure is surfaced safely; user can retry or use only approved alternate login routes. |
| 4 | Attempt to access the protected dashboard after each failure. | Access remains denied. |

- **Cleanup:** Restore IdP and revoke any accidental test session.
- **Assumptions / notes:** Exact provider error handling and allowed fallback routes are TBD.

### TC-VWO-020: Handle social-login success and failure safely
- **Requirement:** REQ-010
- **Module / feature:** Social login
- **Type:** Integration
- **Priority:** P1
- **Preconditions:** Social login is included in release and a provider test tenant is configured.
- **Test data:** Synthetic provider identity; cancellation, denial, and outage fixtures.
- **Automation:** Evaluate

| Step | Action | Expected result |
|---|---|---|
| 1 | Start social login and authenticate with the synthetic provider identity. | Provider flow completes and application maps identity according to approved linking rules. |
| 2 | Cancel or deny a second provider attempt. | No session is created; user returns to a safe, usable login state. |
| 3 | Simulate provider unavailability. | Failure is shown safely and the user can retry or use only approved alternate routes. |
| 4 | Check account mapping for an identity not previously linked. | Application follows the documented linking/provisioning policy and does not silently merge unrelated accounts. |

- **Cleanup:** Revoke provider and application sessions; remove test identity links.
- **Assumptions / notes:** Skip if social login is not in the release; provider and account-linking rules are TBD.

### TC-VWO-021: Use login and reset flows at supported viewport sizes
- **Requirement:** REQ-011
- **Module / feature:** Responsive UI
- **Type:** Responsive / Compatibility
- **Priority:** P1
- **Preconditions:** Supported viewport/browser matrix is approved.
- **Test data:** Approved viewport sizes and synthetic test account.
- **Automation:** Automate (Playwright viewport checks for stable layouts)

| Step | Action | Expected result |
|---|---|---|
| 1 | Open login page at each supported mobile, tablet, and desktop viewport. | Form and branding render without clipping, overlap, or unintended horizontal scrolling. |
| 2 | Complete login using touch input at mobile size. | Controls are usable and touch targets do not obstruct adjacent actions. |
| 3 | Open password reset at each supported viewport and submit a request. | Recovery controls remain visible and usable; feedback is readable. |
| 4 | Resize/zoom according to the agreed test matrix. | Content remains usable and critical controls remain reachable. |

- **Cleanup:** Sign out and restore browser viewport.
- **Assumptions / notes:** Actual device/browser list and zoom criteria must be agreed.

### TC-VWO-022: Complete login using keyboard and screen reader
- **Requirement:** REQ-012, REQ-023
- **Module / feature:** Accessibility
- **Type:** Accessibility
- **Priority:** P1
- **Preconditions:** Supported browser and screen reader are available; accessibility test account is seeded.
- **Test data:** Synthetic valid account and invalid-password sample.
- **Automation:** Manual

| Step | Action | Expected result |
|---|---|---|
| 1 | Navigate the login page using keyboard only. | Focus order is logical and every interactive control can be reached; focus indicator is visible. |
| 2 | Inspect announced names/roles for email, password, remember-me, submit, and recovery controls using a screen reader. | Controls expose meaningful accessible names, roles, and states. |
| 3 | Submit invalid credentials without using a pointer. | Error is announced and associated with the relevant form context; focus remains usable. |
| 4 | Complete login using keyboard only. | User can finish the flow without a pointer and receives an understandable success transition. |

- **Cleanup:** Sign out and restore assistive-technology settings.
- **Assumptions / notes:** Validate against the approved WCAG 2.1 AA test approach; automated scans alone are insufficient.

### TC-VWO-023: Verify theme and high-contrast readability
- **Requirement:** REQ-012
- **Module / feature:** Theme and visual accessibility
- **Type:** Accessibility / Visual
- **Priority:** P1
- **Preconditions:** Light/Dark themes and/or high-contrast mode are in release scope; supported browser is identified.
- **Test data:** None.
- **Automation:** Evaluate (automated contrast checks can supplement manual review)

| Step | Action | Expected result |
|---|---|---|
| 1 | Inspect login form, labels, errors, focus indicators, and controls in Light Mode. | Text and controls are readable; contrast meets applicable WCAG 2.1 AA criteria. |
| 2 | Switch to Dark Mode and repeat the inspection. | Theme applies consistently; all states remain readable and functional. |
| 3 | Enable supported high-contrast mode and navigate the form. | Controls, focus, and error states remain distinguishable and usable. |

- **Cleanup:** Restore default theme and operating-system/browser settings.
- **Assumptions / notes:** Confirm theme availability and supported contrast evaluation methodology.

### TC-VWO-024: Navigate to free-trial registration
- **Requirement:** REQ-013
- **Module / feature:** New-user registration navigation
- **Type:** Functional / Navigation
- **Priority:** P2
- **Preconditions:** Registration destination is configured in staging.
- **Test data:** None.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Open login page and locate the free-trial registration call to action. | CTA is visible and its purpose is understandable. |
| 2 | Navigate to the CTA using keyboard and activate it. | CTA is keyboard reachable and activation navigates to the approved registration destination. |
| 3 | Check destination in the staging environment. | Correct destination opens without exposing credentials or unintended production data. |

- **Cleanup:** Close the registration page; do not create a trial unless separately required.
- **Assumptions / notes:** Destination URL, tracking, and context-preservation expectations are TBD.

### TC-VWO-025: Land on the correct VWO dashboard and tenant
- **Requirement:** REQ-014
- **Module / feature:** Core platform handoff / authorization
- **Type:** E2E / Authorization
- **Priority:** P0
- **Preconditions:** Two synthetic accounts are mapped to distinct test tenants or dashboard contexts.
- **Test data:** Synthetic user A and user B with distinct non-sensitive tenant markers.
- **Automation:** Automate

| Step | Action | Expected result |
|---|---|---|
| 1 | Log in as synthetic user A. | User A lands on the expected dashboard and sees only the approved A context. |
| 2 | Sign out and start a fresh isolated session as synthetic user B. | User B lands on the expected dashboard and sees only the approved B context. |
| 3 | Attempt to open a protected route or tenant marker belonging only to the other user. | Access is denied or redirected according to authorization policy; other tenant data is not exposed. |

- **Cleanup:** Sign out both sessions and clear test browser contexts.
- **Assumptions / notes:** Tenant mapping and access-denial behavior must be defined by the core platform contract.

### TC-VWO-026: Verify authentication analytics and secret-free payloads
- **Requirement:** REQ-015
- **Module / feature:** Analytics and privacy
- **Type:** Integration / Privacy
- **Priority:** P1
- **Preconditions:** Staging analytics sink and approved event schema are available.
- **Test data:** Synthetic successful login, failed login, and reset request.
- **Automation:** Evaluate

| Step | Action | Expected result |
|---|---|---|
| 1 | Complete one successful synthetic login. | Expected success event is emitted once with approved non-sensitive attributes. |
| 2 | Submit one failed login. | Expected failure event is emitted once and is categorized according to the schema. |
| 3 | Submit a password-reset request. | Expected reset event behavior follows the schema. |
| 4 | Inspect sink payloads and application logs. | No password, reset token, full credential, or prohibited personal data is present. |

- **Cleanup:** Delete test analytics events if supported and clear account sessions.
- **Assumptions / notes:** Event names, schema, retention, and privacy allowlist need owner approval.

### TC-VWO-027: Reach support from the login/recovery experience
- **Requirement:** REQ-016, REQ-024
- **Module / feature:** Login assistance
- **Type:** Functional / Resilience
- **Priority:** P2
- **Preconditions:** Staging support destination/channel is configured; provider outage can be simulated if applicable.
- **Test data:** None.
- **Automation:** Evaluate

| Step | Action | Expected result |
|---|---|---|
| 1 | Locate and activate the login assistance/support route. | Support route is visible or otherwise discoverable and usable by keyboard. |
| 2 | Follow the route in staging. | Approved support experience opens and provides relevant login assistance. |
| 3 | Repeat while the configured authentication provider is unavailable. | User can still reach the approved support path; no credential or sensitive account data is exposed. |

- **Cleanup:** Close support page or test contact form without sending real customer data.
- **Assumptions / notes:** Support channel, content, and escalation behavior are not specified in the PRD.

### TC-VWO-028: Verify transport and secret-handling configuration
- **Requirement:** REQ-017
- **Module / feature:** Authentication security
- **Type:** Security
- **Priority:** P0
- **Preconditions:** Authorized staging configuration access and security review tools are available.
- **Test data:** Synthetic credentials and sessions only.
- **Automation:** Manual (specialist configuration and security review; automation may support checks)

| Step | Action | Expected result |
|---|---|---|
| 1 | Load login and submit synthetic authentication data while observing network configuration. | Authentication communications use HTTPS/TLS; no credential-bearing request is sent over plaintext HTTP. |
| 2 | Inspect approved cookie/session configuration. | Session controls match the security baseline approved by Security; tokens are not exposed in URLs or unapproved storage. |
| 3 | Inspect browser storage and sanitized application/test logs after login and reset. | Passwords and reset tokens are not stored or logged in plaintext. |
| 4 | Review password storage implementation evidence with the security owner. | Passwords are stored using the approved industry-standard salted password-hashing approach; no plaintext password storage is evidenced. |

- **Cleanup:** Remove captured synthetic evidence according to secure handling policy and revoke sessions/tokens.
- **Assumptions / notes:** Do not claim encryption or compliance based only on a UI test; Security must provide configuration and implementation evidence.

### TC-VWO-029: Enforce configured throttling for repeated failed attempts
- **Requirement:** REQ-018, REQ-024
- **Module / feature:** Rate limiting / brute-force protection
- **Type:** Security / Boundary
- **Priority:** P0
- **Preconditions:** Written rate-limit threshold, window, response, and recovery policy are approved; test is authorized for isolated staging.
- **Test data:** Synthetic account/address and bounded failed-attempt sequence below and above the configured threshold.
- **Automation:** Evaluate (run only with approved limits and environment safeguards)

| Step | Action | Expected result |
|---|---|---|
| 1 | Submit the approved number of failed attempts below the threshold. | Responses follow normal invalid-credential policy and do not create a session. |
| 2 | Submit attempts up to and beyond the configured threshold, without exceeding approved test limits. | Throttling is enforced at the agreed point and follows the approved response/lock policy. |
| 3 | Attempt a valid login during the throttle period for the affected account. | Behavior matches the approved lockout/recovery policy; no unintended bypass occurs. |
| 4 | Attempt login for an unrelated synthetic account. | Unrelated account remains usable unless the documented policy intentionally applies broader throttling. |
| 5 | Wait through the documented recovery period or use approved reset procedure. | Access recovery follows policy and produces auditable, non-sensitive behavior. |

- **Cleanup:** Clear throttle/lock state through an approved admin/test fixture; do not weaken production controls.
- **Assumptions / notes:** Never perform uncontrolled brute-force testing; thresholds and safe limits are TBD.

### TC-VWO-030: Measure page load against the PRD target
- **Requirement:** REQ-019
- **Module / feature:** Login page performance
- **Type:** Performance
- **Priority:** P1
- **Preconditions:** Measurement method, browser, geography, connection profile, cache state, percentile, and sample size are approved.
- **Test data:** Empty browser profile and approved synthetic monitoring requests.
- **Automation:** Evaluate (repeatable performance harness recommended)

| Step | Action | Expected result |
|---|---|---|
| 1 | Configure the agreed browser, network, geography, and cache conditions. | Measurement environment matches the approved performance protocol. |
| 2 | Run the specified number of page-load samples. | Samples are captured consistently without mixing unrelated requests or environments. |
| 3 | Calculate the approved load-time metric and percentile. | Result is under 2 seconds, matching the PRD target, or a measurable failure is reported. |
| 4 | Record build, environment, and raw measurement summary. | Results are reproducible and contain no sensitive user data. |

- **Cleanup:** Remove test session and restore measurement environment.
- **Assumptions / notes:** The PRD does not define load metric/percentile or “standard connection”; approve before gating.

### TC-VWO-031: Exercise concurrent login load and dependency degradation
- **Requirement:** REQ-020, REQ-024
- **Module / feature:** Capacity and resilience
- **Type:** Load / Resilience
- **Priority:** P1
- **Preconditions:** Approved performance test window, isolated environment, load profile, dependency failure plan, and test accounts are available.
- **Test data:** Synthetic account pool and non-production identity/email dependencies; no production credentials.
- **Automation:** Evaluate (use authorized load tooling; not a browser-only test)

| Step | Action | Expected result |
|---|---|---|
| 1 | Start the approved workload increasing concurrency toward the agreed “thousands” target. | Login service handles the ramp without unauthorized successes or cross-account session mixing. |
| 2 | Observe response time, error rate, resource use, and authentication outcomes. | Metrics remain within agreed SLOs and failures are categorized accurately. |
| 3 | Simulate an approved dependency degradation/outage during load. | System fails safely, does not corrupt account/session data, and returns defined recoverable errors. |
| 4 | Restore dependencies and reduce load. | Service recovers within the agreed recovery objective; no backlog or inconsistent session state remains. |

- **Cleanup:** Stop load generators, restore dependencies, clear synthetic sessions, and archive sanitized metrics.
- **Assumptions / notes:** Concurrency count, duration, traffic mix, latency/error thresholds, and recovery objective are TBD.

### TC-VWO-032: Review availability and alerting evidence
- **Requirement:** REQ-021
- **Module / feature:** Service availability / operations
- **Type:** Reliability
- **Priority:** P1
- **Preconditions:** Service owner provides the approved 99.9% SLO definition, observation window, monitoring source, and incident/runbook evidence.
- **Test data:** Synthetic health checks only.
- **Automation:** Manual (review evidence; monitoring probes may be automated)

| Step | Action | Expected result |
|---|---|---|
| 1 | Review the SLO definition and observation period with the service owner. | Availability metric, exclusions, and reporting window are unambiguous. |
| 2 | Inspect monitoring data for the agreed period. | Evidence is sufficient to calculate availability against the PRD’s 99.9% goal. |
| 3 | Review alert routing and a controlled non-production alert test. | Alerts reach the designated responder and runbook identifies recovery steps. |
| 4 | Review recovery evidence for a representative non-production dependency interruption. | Recovery behavior and time are recorded against the approved operational objective. |

- **Cleanup:** Close test alerts and restore monitoring configuration.
- **Assumptions / notes:** A short release test cannot prove 99.9% uptime over a longer operational period; this is primarily an SRE evidence gate.

### TC-VWO-033: Calculate login-success KPI using the approved definition
- **Requirement:** REQ-022
- **Module / feature:** Login analytics / business KPI
- **Type:** Analytics
- **Priority:** P2
- **Preconditions:** KPI denominator, exclusions, reporting period, analytics source, and expected event schema are approved.
- **Test data:** Controlled synthetic successful and failed attempts with unique run identifiers.
- **Automation:** Evaluate

| Step | Action | Expected result |
|---|---|---|
| 1 | Generate the approved mix of synthetic eligible successful and failed authentication attempts. | Each attempt is represented by the correct event/category without duplicated counting. |
| 2 | Query the approved analytics report for the run and time window. | Numerator, denominator, exclusions, and calculation match the approved KPI definition. |
| 3 | Compare the measured rate with the PRD target of 95% or greater. | The target comparison is reported accurately; no pass/fail conclusion is made without a representative approved sample. |

- **Cleanup:** Delete test events or exclude the run from business reporting using the approved process.
- **Assumptions / notes:** KPI interpretation and eligible-attempt denominator are TBD; synthetic runs alone do not establish a production KPI.

## 5. Coverage gaps and questions

- Confirm which optional features are included in the release: MFA, enterprise SSO, social login, remember-me, Dark Mode, and high-contrast mode.
- Specify exact email validation, password rules, reset-token lifetime/reuse, session timeout, remember-me duration, and logout/revocation behavior.
- Approve safe login/reset error copy and the required level of account-enumeration/timing protection.
- Define rate-limit threshold, window, lock duration, error response, recovery path, and safe staging test limit.
- Approve supported browsers/devices and measurable WCAG 2.1 AA validation approach.
- Define dashboard handoff, tenant mapping, and authorization contract for cross-account isolation checks.
- Provide support channels, analytics event schema/privacy allowlist, and the login-success denominator/reporting period.
- Define the page-load metric and conditions for the PRD's under-2-second target.
- Define concurrent load profile, latency/error thresholds, recovery objective, and owner for the “thousands of simultaneous attempts” requirement.
- Define availability SLO observation window and evidence source for the PRD's 99.9% goal.
- Assign owners for GDPR/CCPA, OWASP alignment, audit trails, data retention, and compliance evidence. These test cases do not certify compliance.

## 6. Automation recommendations

- **Playwright candidates:** TC-VWO-001–006, TC-VWO-008–009, TC-VWO-012–016, TC-VWO-021, TC-VWO-024–025. Prefer accessible role/name locators, deterministic API fixtures, isolated browser contexts, and explicit cleanup.
- **Conditional automation:** TC-VWO-017–020 and TC-VWO-026–027 when test providers/sinks are reliable; TC-VWO-029–031 only under approved staging safeguards and defined profiles.
- **Manual / specialist checks:** TC-VWO-022 screen-reader and keyboard usability; TC-VWO-023 visual/high-contrast review; TC-VWO-028 security configuration and implementation evidence; TC-VWO-032 operational availability/SLO review.
- **Test fixtures / mocks:** Synthetic account factory with valid/invalid/unknown/reset/MFA/SSO states; controllable authentication API responses; reset email sink and token lifecycle fixture; SAML/OAuth/social test tenants; isolated dashboard tenant markers; analytics sink with event inspection; controllable network/service delays; and approved load/monitoring environment.
- **Execution note:** This document contains test specifications only. No test code was generated and no cases have been executed.
