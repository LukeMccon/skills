---
name: business-logic-review
description: Use when a PR, diff, feature, or proposal needs review against business rules, product goals, or user expectations. Also use for product manager reviews.
---

# Business logic review

Review the change as a product manager who can read code. Check whether it helps users complete their task and follows the rules of the product.

Answer two questions:

1. Does the code produce the requested behavior?
2. Does that behavior support the product goal?

Change files only when the user authorizes changes. Publish review comments only when the user authorizes publication. Report technical issues when they explain an observable effect on users or the business.

## Define the scope of the review

Identify the pull request (PR), commit range, local changes, or proposal to review. For a repository review, check the source and target branches before you select a comparison. State the base revision and the scope of the comparison. State whether the review includes uncommitted changes.

For a proposal or supplied excerpt, assess the available evidence. State which implementation details you cannot check. Do not imply that you reviewed the full repository.

## Establish the expected result from product evidence

Use the product context to identify:

- The users, their task, and the result they need.
- The behavior before and after the change, including effects on other users.
- The business rules, access rights, promised times, and other promises that apply.
- The expected benefit and any tradeoffs the product owner has accepted.

Follow the repository instructions. Use local context first. Read the request and linked issues or pull requests. Check acceptance criteria, product documentation, help text, pricing text, screens, related workflows, and tests. Read linked sources when you have access. State which sources you cannot access.

Separate **explicit requirements**, **observed behavior**, and **assumed expectations**. Code and tests show what the system does or checks. They do not establish intended behavior by themselves. Do not invent requirements, market practices, usage data, or user research.

If sources conflict, compare their authority, date, and audience. An explicit approved policy change can replace an older rule. Check promises to existing users and the change from the old policy to the new policy. Identify outdated promises in documents or product text.

If product intent is unclear, state your assumptions. Continue the checks that those assumptions support. Ask only for missing information that can materially change the recommendation. Treat an unsupported expectation as a product question.

## Trace the change to the result the user sees

Follow the path from the user action to the final result. Check the decisions, state changes, and other effects along that path. Read relevant code outside the diff that calls the changed code or uses its results. An unchanged access check, background job, notification, or report can reveal the effect of a changed value.

Use realistic scenarios for the affected users and states. Select the relevant checks from this table.

| Area | Questions to answer with evidence |
| --- | --- |
| User task | Can the user still complete the task? Does the requested change help? Could more signups or clicks hide a worse result? |
| Access and ownership | Do the correct roles, plans, account states, and resource owners receive the expected access? Who gains or loses access? |
| Charges and paid access | Do charges, refunds, usage limits, and paid access match the promise? What happens when the action fails? |
| Time and state | Does the rule start at the promised time? Do relevant workflows interpret pending, completed, failed, canceled, expired, and retried states consistently? |
| Completion and recovery | Does the product distinguish accepted work from completed work? Can the user recover after an interruption or partial success? Can a retry cause a duplicate charge or action? |
| Existing users | What happens to existing records, work in progress, saved settings, and promised access? Do default values or data migrations change their meaning? |
| Product text and behavior | Do labels, confirmations, emails, status displays, and related workflows describe the same result? Can the user understand the effect and the next step? |

If evidence shows that the requested behavior defeats the product goal, explain the conflict. Acceptance tests can pass despite that conflict. Propose the smallest useful alternative or product decision. Respect explicit product tradeoffs. Do not replace them with personal preferences or unrelated feature proposals.

For each possible finding, describe a specific failure scenario:

> Identify the user and the starting state. State the action. Cite the source of the expected result. Describe the actual result and its effect on the user or business.

Before you report a finding, check for evidence that could disprove it. A later refund, reconciliation step, access check, feature flag, or approved policy decision can explain an apparent failure.

Distinguish a new defect from an existing problem that the change exposes. Exclude unrelated problems from the review.

## Separate proven defects from product questions

A confirmed finding needs four elements:

- Evidence for the expected result.
- A scenario that can occur.
- Evidence for the actual or proposed behavior.
- A meaningful effect on a user or the business.

Cite the precise code location and the source of the expected result. Do not invent line numbers for evidence supplied only as a description.

Put missing or conflicting requirements under **Product decisions needed**. Explain the possible results and why the decision matters. An unresolved product decision can prevent a release recommendation without proving a defect.

Keep optional improvements separate from defects. Include an improvement only when it adds useful information. A shorter workflow or different visual style does not automatically improve the result.

Use the severity rules of the repository when available. Otherwise, assess the effect, affected users, conditions that trigger it, and recovery options.

| Priority | Meaning |
| --- | --- |
| **P0** | Evidence shows a critical, widespread effect that needs immediate attention. |
| **P1** | The change breaks a material promise or core user task, such as correct charges or paid access. Resolve the defect before release. |
| **P2** | Evidence shows a problem with limited impact or a practical workaround. |
| **P3** | Evidence shows a minor inconsistency or usability defect. |

Severity describes the effect. Confidence describes the strength of the evidence. Do not increase severity because evidence is uncertain. Combine findings that describe the same business rule failure.

For example, a scheduled seat reduction can change the next invoice correctly but reduce the current invitation limit too early. A customer with 10 paid seats and 6 members then loses four invitation slots before renewal.

Connect the renewal promise to the changed limit and the code that checks invitations. Recommend that the current paid limit stay in effect until renewal. Propose checks before and after renewal. Do not claim that existing members lose access without evidence.

## Give the product owner a clear recommendation

Start with the affected users, intended result, and actual change in behavior. State whether the code follows the request. State whether the requested behavior supports the documented product goal. These conclusions can differ.

Give one recommendation with the main reason:

- **Ready from this review's product perspective.**
- **Changes needed.**
- **Product decision needed.**

The recommendation does not authorize a merge or release.

Order findings by their effect. For each finding, include:

- The priority and a title that states the effect on users.
- The user, starting state, action, expected result, and actual result.
- Evidence for the expectation and behavior, including any uncertainty.
- A specific correction or product decision.
- An acceptance scenario that checks the expected result.

Finish with material product questions and the limits of the review. Separate completed checks from proposed checks. Do not report a proposed test as passing. Omit empty sections and unsupported findings.

If the evidence supports no defects, say so. State the scope and any unresolved assumptions that limit confidence.

When you change this skill, use the [evaluation cases](references/evaluation.md) to check judgment, scope, and unsupported findings.
