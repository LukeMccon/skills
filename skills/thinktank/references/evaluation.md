# Thinktank evaluation cases

These cases check delegation planning, not the truth or quality of an investigation. Evaluate in planning mode with no actual agent dispatch, model CLI calls, shared-file changes, or live-system access. For scoring mechanics, use three supplied example ballots and an ordinary calculator.

| Request or setup | Expected behavior |
| --- | --- |
| Use thinktank to explore how a neighborhood repair café could organize volunteer shifts. | Five presenters with task-specific angles, exactly three fresh judges, one bounded investigation round. The noncoding topic is eligible without a topic whitelist. |
| Use thinktank agents=7 to compare these options. | Seven presenters, three judges; the explicit count affects presenters only. |
| Use thinktank with two presenters to compare these options. | Two presenters, three judges; honor the natural-language override. |
| Use thinktank agents=0 to compare these options. | Resolve the invalid count before dispatch; do not silently use the default or invent a zero-presenter panel. |
| Use thinktank agents=2.5 to compare these options. | Resolve the noninteger count before dispatch. |
| Use thinktank agents=7, but use only two presenters. | Resolve the conflicting counts before dispatch. |
| Four total-live-agent slots, completed contexts retain their slots, and no release operation. | Report that the default cannot complete under this constraint; nine slots cover coordinator, presenters and three fresh judges, plus replacement capacity if needed. Do not silently shrink the team or reuse presenter contexts as judges. |
| Choose a creative direction with supplied designs A/B and goals beyond appearance. | Presenters initially receive the goals, constraints and background without A/B. Fresh contexts avoid inheriting the designs. Preserve independent alternatives before revealing A/B; judge both sets together using criteria covering the full objective. |
| A creative task explicitly asks to compare only supplied options. | Honor the constrained comparison rather than forcing new alternatives. |
| The coordinator proposes visual novelty as the only criterion despite goals of usability and maintainability. | Judges flag material omitted dimensions and relate them to the objective. Correct the shared rubric and rescore within the existing bounded round, without independently changing individual judges' criteria. |
| Three fully scored findings total 24, 24, and 21. | Shared ranks 1, 1, 3; combined scores stay out of 30 regardless of presenter count. Preserve disagreements and majority/disputed verdicts. |

Baseline observed before this edit: the previous skill planned three investigators and three judges for the repair-café request, requiring seven initial agent slots. It already accepted the noncoding topic. The edit changes the presenter default and names, adds the count override contract, and preserves topic breadth and judging invariants.

Creative-decision baseline before the conditional addition: the coordinator exposed supplied layouts A/B in all five initial presenter briefs. Only one presenter was expressly assigned alternatives, allowing options to emerge after seeing A/B. The revised protocol separates initial independent generation from later comparison and lets judges challenge criteria that omit material parts of the objective.

## Custom rubric consistency

Use a custom rubric with three components worth 5, 3, and 2 points. Require each judge to return those three components and a total /10. A rubric revision must still sum to 10, and all three judges must rescore the entire packet. Reject incomplete components, out-of-range scores, or rubrics whose maxima do not sum to 10 before aggregation.
