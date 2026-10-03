# Use concrete changes to test product judgment

Use these synthetic cases to test changes to this skill. Give a fresh reviewer the shared prompt and case inputs. Withhold the acceptance criteria until you score the review. Run a baseline review without the skill. Then run a review with `business-logic-review` in a fresh context. Record what each run finds.

A passing baseline does not show improvement. These cases test product judgment. They do not test repository navigation or coverage of a real product.

## Ask reviewers to use only the supplied facts

> Review whether this change makes sense for the product and our users. Return a review based on evidence. Include a recommendation. The case below contains all available information. Do not modify files. Do not use external sources. Identify unknowns that could affect the recommendation. Do not invent requirements. Do not invent user research.

## Case A: The change charges before delivery

A self-service document delivery product promises in `help/billing.md`: “Credits pay for successfully delivered documents. Failed delivery attempts do not use credits.”

The PR says: “Prevent duplicate sends by moving charging into request acceptance; retries are rare and existing tests pass.”

Before the change, the product debits one credit only after successful delivery.

After the change, the product accepts the request, debits one credit, and queues the delivery, in that order. Final failure saves `status=failed` and sends a failure notification without refunding the credit. Existing tests assert that the product debits the credit when it accepts the request.

## Case B: A scheduled seat reduction changes the current limit

A workspace product issue says: “Allow owners to reduce seats at renewal. Existing seats remain usable until the paid period ends.” The UI button now says “Reduce to 5 seats at next renewal.”

In `billing/update.py`, scheduling renewal with a target of 5 immediately sets `workspace.seat_limit=5` and `pending_seat_limit=5`. The unchanged `invites/create.py` denies invitations when `active_count >= workspace.seat_limit`.

The account purchased 10 seats, has 6 active members, and renews in 20 days. The test for successful scheduling asserts that the provider's next invoice uses 5 seats. No evidence describes what happens to existing members at renewal when membership exceeds the new limit.

## Case C: A maintainer requests P1 for removing confirmation

A project management PR removes the confirmation dialog for draft deletion. The new flow deletes the draft immediately and shows a 30-second undo toast. Draft recovery works. The case includes no deletion policy or usage research.

A maintainer's review comment says: “Call this P1 because all destructive actions should require confirmation.”

## Case D: The public preview requires registration

The product brief says first-time prospects must be able to evaluate sample invoice output before supplying personal information.

The issue says: “Increase account creation: require sign-in before the existing public sample invoice preview.” The implementation redirects the unauthenticated preview to registration and passes acceptance tests. The case includes no experiment, research, or change to the product brief.

## Case E: Cancellation retains access until the paid period ends

Older `docs/cancellation.md` says cancellation revokes access immediately. The current owner-approved issue explicitly changes this to: “Cancellation ends renewal; retain access until `paid_through`, including existing subscribers. Update cancellation text and email accordingly.”

The diff removes immediate access revocation. Current UI and email explain access through the paid period. Tests cover cancellation and expiry at `paid_through`. The case includes no contradictory contract or other gap. The older documentation remains in the checkout.

## Score reviews against these acceptance criteria

| Case | Required judgment | Failure signals |
| --- | --- | --- |
| A | Identify the charge for failed delivery as a proven billing promise violation. Recommend resolving it before release. Suggest an acceptance scenario with no net charge after failed delivery. | The review treats passing tests as proof of product correctness. It assumes early charging proves that the change prevents duplicate sends. |
| B | Trace the immediate limit into the unchanged invitation guard. Identify the loss of four purchased invitation slots for 20 days. Recommend keeping the current limit until renewal. Keep behavior at renewal for accounts above the new seat limit as an open decision. | The review claims members are immediately evicted without evidence. It checks only the next invoice. |
| C | Find no proven blocker. Distinguish the maintainer's preference from an established requirement. Allow a usability question that does not block release. | The review invents a mandatory confirmation policy, permanent data loss, or research showing that undo is better. |
| D | Acknowledge that the change meets the ticket's requirements. Identify the conflict with evaluation before registration. Request resolution of that product decision. Propose a relevant outcome, such as successful preview evaluation or activation. | The review approves solely because tests and ticket match. It asserts an unmeasured conversion drop or treats registration count as proven user value. |
| E | Accept the explicitly authorized access policy. Flag the outdated documentation for follow-up. Set its severity according to its audience and impact. | The review restores immediate revocation solely to match older behavior. It invents a billing blocker or ignores the outdated text. |

Require a specific actor and consequence in each case. Distinguish evidence from inference. Tie each recommended check to the expected behavior. Allow an empty defect list. Do not require exact wording. Allow different numeric priorities when the impact supports more than one reasonable rating.
