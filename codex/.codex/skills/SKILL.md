---
name: generate-tickets-dev-qa-version
description: Create, refine, bulk-update, and link Jira tickets through Atlassian MCP for the Video and Streaming project. Use when turning implementation docs, bug notes, QA findings, or engineering notes into field-complete Stories, Tasks, Bugs, and ticket previews before applying changes.
---

# Generate Tickets

Turn engineering and QA input into Jira-ready work in the `VID` project. Optimize for correct fields, clean ticket boundaries, reproducible bug descriptions, concise acceptance criteria, and safe MCP execution.

## Project Scope

- Limit Jira work to the `Video and Streaming` project (`VID`) unless the user explicitly overrides that scope.
- Prefer exact issue keys, epic keys, fix version names, and Jira field values over guesses.
- When the request depends on current Jira state, verify it through Jira MCP instead of relying on memory.

## Supported Inputs

Use the best available source in this order:

- `planning/{featureName}/implementation.md`
- QA notes or bug reports
- engineering notes
- user-provided raw notes

If no planning file exists, do not block. Use the available notes and still produce Jira-ready output.

## Assignee Guardrail

When this skill is used for Jira drafting, Jira creation, assignee suggestions, or Jira field updates, only use the following Video and Streaming users as valid assignees unless the user explicitly asks to update the allowlist.

- Anthony Pangarakis — `712020:e788f7ce-1990-49d3-afcf-fa85126117a4`
- Artur Shpontak — `712020:d627a825-4b21-4b96-8bca-ff49050ed3cd`
- Andrii Dubinin — `63e3587f8978d7a4353ce156`
- Carlos Collazos — `712020:f9b7ef32-471a-4096-81b1-b846d947312b`
- Daria Tykhonchuk — `712020:63a5bb5c-29ca-4ed6-905f-52a5af0acaa2`
- Dmytro Korchevskyi — `712020:41086a04-9a75-4240-9b00-2e763a6c246c`
- Eduard Volynets — `712020:0c974cb0-0d2f-44c7-b6d5-04f98412068e`
- Illia Melnychuk — `712020:b6199257-f842-4441-8c08-be21c23364f3`
- Iryna Kandyba — `712020:1ac89f02-6e73-451b-a8e4-5b2503ca1c77`
- Ivan Hrypak — `63e26fca724a5c79c7bb1fab`
- Jordan Newberry — `624f1e9845ece00069cea386`
- Kostiantyn Maksymov — `712020:5b1f6b0d-fd9a-4c22-a309-9595b62bddbb`
- Kyle Burger — `712020:35c969cd-c55d-4027-9d66-ea1c6ba6ca32`
- Kyrylo Bonduryansky — `712020:4be7a3a1-2eb4-4248-84a7-7927c66e8e69`
- Lyubomyr Khodak — `712020:9c547b33-5d2a-4ede-8bb6-45caa40c54ac`
- Macie Sherman — `712020:f09ba6cc-8a5f-4c6c-92d2-297c8c7b7aeb`
- Mike Yarulin — `712020:b7f3c1c9-4484-4187-9767-d6460a48dd11`
- Nuh Piskin — `712020:a483d04c-5fe1-4e47-97ac-e4c12636aa15`
- Pavlo Matsibokh — `712020:c78f107b-2121-4f05-b62b-3ad1709c7b76`
- Ross Bornitskyi — `6362cce5548f1fe6f0c7eb16`
- Serhii Chelak — `712020:05425545-2103-49f1-86d0-a74a374a6756`
- Sergey Bobyr — `63996086f7f0ee492fced04e`
- Vasyl Petrashkevych — `63da9ef0f1475ad42c5881a5`
- Vladyslava Buriakovska — `712020:7fc72de9-324e-4932-9333-3e2493cf7afe`
- Volodymyr Chornous — `639960862c2bbfc5f9dd2683`

Apply these rules whenever assignees come up:

- Prefer the exact account IDs above instead of name search when creating or updating Jira issues.
- Map `Pablo` to Pavlo Matsibokh — `712020:c78f107b-2121-4f05-b62b-3ad1709c7b76`.
- If the requested assignee is outside this list, stop and ask whether the allowlist should be updated.

## Workflow

1. Confirm the request belongs to `VID`.
2. Read the source material and identify the work as bug fix, QA follow-up, technical task, implementation slice, or UX work.
3. Review existing `VID` tickets in the same area, release, component, or epic before creating anything new.
4. Suggest ticket groupings first when the request covers multiple issues or workstreams.
5. Show a preview before creating new tickets or making broad updates.
6. Collect or validate the required Jira fields.
7. Draft concise Jira-ready ticket text.
8. Create or update issues only after the preview step is satisfied.
9. Link the new or updated issues to relevant related tickets.
10. Report issue keys, links, and any assumptions or blockers.

## Grouping Rules

Before creating new tickets:

- split unrelated bugs into separate tickets
- group closely related implementation tasks only when they ship together or test together
- keep QA follow-up work separate from engineering implementation when different owners or validation paths are likely
- mention duplicate, near-duplicate, prerequisite, follow-up, and sibling `VID` tickets when relevant
- wait for confirmation before creating any new issue

When the source is:

- `implementation.md`: group work into shippable or testable slices and preserve traceability in `Scope Notes`
- QA notes: group by defect, platform, or reproduction path
- raw notes: convert directly into ticket-ready output and ask only for missing required Jira fields

## Required Fields

Every ticket must include:

- `Summary`
- `Issue Type`
- `Epic`
- `Description`
- `Work Type`

Todo, planned, or active work must also include:

- `Fix Version`

UX tickets must also include:

- `Assignee`
- `Due Date`

Never create a ticket without an Epic.
Never create active work without a Fix Version.

## Ticket Writing Rules

- Prefer concrete summaries over vague ones.
- For bugs, use concise reproduction-oriented wording.
- Keep descriptions factual, compact, and Jira-ready.
- Prefer short STR over long narrative context.
- Keep `Scope Notes` short and use them only when they clarify boundaries, risk, or traceability.
- If screenshots or files cannot be attached through the available tools, capture the useful evidence in the description or a comment and state that attachments were not possible.

## Bug Ticket Rules

Bug tickets should usually include:

- where the issue happens
- the trigger or reproduction path
- the observed result
- the expected result when it is known

Prefer this structure:

- `Summary`
- `Description`
- `STR`
- `Expected Result`
- `Actual Result`
- `Scope Notes` when needed

Good summary style:

- `Error occurs when creating a new Tournament, Team, Stream, or User`

Bad summary style:

- `Open this video and see BUG`

## Acceptance Criteria Rules

Use acceptance criteria for non-UX tickets when the work describes an expected outcome, fix validation target, or user-visible behavior.

Every AC block must:

- have a short behavior header
- use `GIVEN / WHEN / THEN`
- stay user-facing or tester-facing
- avoid implementation details, API language, and internal code terms

Keep AC coverage intentionally minimal. Only include the behaviors needed to verify the work.

For narrow technical tasks or obvious bug fixes, a small AC set is better than exhaustive coverage.

## UX Rules

UX stories use `Deliverables`, not acceptance criteria.

UX deliverables must be concrete and reviewable, for example:

- UX flow for the target journey
- wireframes for key states
- high-fidelity UI in Figma
- design review or handoff-ready mocks

UX stories must still include:

- `Epic`
- `Fix Version` when the work is active
- `Assignee`
- `Due Date`

If assignee or due date is missing, ask before finalizing the ticket.

## Preview-First Behavior

Preview is the default for new-ticket creation.

When preparing a preview:

- return the candidate issue list before making edits
- include proposed summary, issue type, assignee, fix version, epic, work type, and description shape for any new ticket
- call out which issues already match the requested state
- mention related tickets and the planned link types
- wait for confirmation before creating the issue

## Related Ticket Review And Linking

Before creating a new issue:

- search `VID` for existing tickets in the same area, release, component, or epic
- look for duplicates, near-duplicates, prerequisite work, follow-up work, and sibling tasks
- mention related tickets in the preview

After creation or update:

- link the most relevant Jira issues instead of leaving the ticket isolated
- use dependency-style links for direct blockers and `Relates` for adjacent or shared work
- fetch available link types first if the correct link type is unclear

## Common Jira Operations

### Create Issues

- Choose the right type: Story, Task, Bug, Spike, Epic, or Sub-task.
- Validate assignee, fix version, work type, component, and epic before creation.
- Search for related `VID` issues before creation and include the link plan in the preview.

### Refine Existing Issues

- Tighten summaries and descriptions for clarity and reproducibility.
- Add or clean up STR, expected result, actual result, or acceptance criteria when useful.
- Add comments for supplemental evidence, QA notes, or attachment limitations.

### Bulk Updates

- Use project-scoped JQL.
- Preview first when the blast radius is large or the user asks for review first.
- Exclude backlog items when instructed.
- Report which issues changed and which were already correct.

### Linking

- Link implementation work to related bugs, backend dependencies, and follow-up QA tasks when useful.
- Keep dependency links separate from general related-work links.

## Atlassian MCP Guidance

- Prefer Jira MCP tools over free-text assumptions.
- Use project-scoped Jira queries.
- Use `getJiraIssue` before editing when there is a risk of overwriting important fields.
- Use `getTransitionsForJiraIssue` before moving status when the transition id is unknown.
- Validate Jira metadata before writing:
  - assignee account id
  - fix version
  - component
  - issue type
  - epic
  - transition id when status must change
- If Atlassian MCP returns auth or transport errors, stop and report the failure clearly instead of making partial claims.

## Output Expectations

For drafting or preview requests, produce Jira-ready output that maps cleanly to Jira fields.

For non-UX tickets include:

- summary
- issue type
- epic
- work type
- fix version when applicable
- concise description
- STR for bugs when available
- expected result and actual result for bugs when useful
- short scope notes when traceability matters
- acceptance criteria only when they help validate the work

For UX tickets include:

- summary
- issue type
- epic
- work type
- fix version when applicable
- assignee
- due date
- concise description
- short scope notes when traceability matters
- deliverables

Use concise final responses with issue keys, links, and any assumptions or blockers.
