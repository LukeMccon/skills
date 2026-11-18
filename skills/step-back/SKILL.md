---
name: step-back
description: Use when the user asks to step back, zoom out, or sanity-check the approach to a task, fix, feature, plan, or decision.
---

# Step back

Pause the work. The question is not "is this done right?" but "are we doing the right thing?" Do not change files during the step-back. Match the effort to the stakes.

You likely chose the current approach, so guard against defending it. Judge it as if no work had been done: finished work counts only where it carries over to another path.

## 1. Restate the goal

State what we are trying to achieve and why, separate from how we are doing it. Name the user or system that benefits, the constraints the user set, and how we will know it worked. If any of these is unclear, say so. That is often the finding.

## 2. Describe the current approach

Summarize what we are doing, how we got here, and which assumptions it rests on. Use evidence from the conversation, code, git history, issues, and docs. Separate facts from inferences. Name the assumption that sinks the approach if it is wrong, such as an unconfirmed diagnosis, and look for evidence against it when that is cheap.

## 3. Widen the view

Raise a point only if it could change the direction:

- **Existing solutions.** How do other parts of this codebase, or well-known libraries and tools, solve this? Are we diverging, duplicating, or repeating a known mistake?
- **The root, not the symptom.** Are we fixing one instance of a wider problem?
- **The right layer.** Prefer handling the concern once at the layer that owns it, such as a type, schema, constraint, or shared library, over patching each caller or the UI. Could that make the problem impossible? Note when the policy belongs with the callers or the owner is too costly to change.
- **Scope.** Are we building more than the goal needs, or less?
- **Alternatives.** What else could reach the goal, including doing nothing or deleting something? When the stakes are high and subagents are available, give a fresh one only the goal and constraints, then compare its answer.

## 4. Ask questions

List the questions whose answers would change the direction. Ask the user only those that you cannot answer from the code, docs, or context. If an answer could reverse the recommendation, make the recommendation conditional on it: "if A, continue; if B, switch."

## 5. Report

Keep it short and omit empty sections:

1. **Goal**: what we are trying to achieve and how we will know it worked.
2. **Current approach**: one or two sentences.
3. **What the wider view shows**: findings that bear on the direction, with evidence.
4. **Alternatives**: each with its main tradeoff and the cost of switching from here.
5. **Questions**: only those that matter.
6. **Recommendation**: continue, adjust, or change course, and the next step.

If the current approach is right, say so plainly. Continue or adjust within what the user already authorized. Wait for the user when an answer could reverse the recommendation or the change needs new authorization. Do not invent concerns to justify the exercise. Tie every point to this task, not to generic best practices.
