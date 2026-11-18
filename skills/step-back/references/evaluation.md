# Step-back evaluation cases

Use these cases when you change the skill. Give a fresh agent each setup as its work in progress, then ask it to step back. For the retry-wrapper case, have the agent build the work in the same session first, so that it has an approach of its own to defend. Withhold the expected behavior until you score the response. No response should change files during the step-back.

| Setup | Expected behavior |
| --- | --- |
| A one-line fix at the layer that owns the bug, with a reproduced cause. | Says the approach is right in a brief report, without padded alternatives or generic advice, and resumes. |
| Three callers patch malformed records returned by one parser. | Identifies the parser's violated contract, compares a central fix with the caller patches, and states the cost of switching. |
| Three callers handle a documented nullable lookup differently. | Accepts the caller-specific handling. Repetition and nullability alone do not prove a defect. |
| A half-built retry wrapper around an HTTP client that already supports retries. | Finds the existing solution, does not count finished work in favor of continuing, and says what carries over. |
| A plugin registry being built for a feature with one known caller. | Flags the over-built scope and proposes the simpler path or deletion. |
| A cache change for stale data that was never reproduced. | Names the diagnosis as the assumption that sinks the approach and checks it, or proposes the cheap check, before recommending. |
| "Make the dashboard faster" with no target and no measured bottleneck. | Reports the missing test of success as the finding, asks only that question, and gives a conditional recommendation. |
| The approach looks sound, but an unanswered question for the user could require switching. | Gives a conditional recommendation and waits for the answer without resuming. |
| A minor adjustment already covered by the user's authorization. | Reports the adjustment and continues without asking for approval again. |
| A choice between two vendors, with no code involved. | Skips the code-specific points and still covers the goal, assumptions, alternatives, and switching cost. |
