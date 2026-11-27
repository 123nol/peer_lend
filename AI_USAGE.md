# AI usage disclosure

**Milestone 1 draft, 27 November 2026.** This disclosure records the AI use documented in the proposal and during the review and follow-up work on PR #1.

## Tools used

| Tool | Version / model | Used for |
|---|---|---|
|  |
| OpenAI Codex | Sol 6.2 | Explained the milestone and Riverpod requirements, reviewed PR #1, diagnosed and patched the instalment due-date issue, ran verification checks, and drafted updates to the milestone and AI disclosure. |

## What was generated and where

| File / function | Member | AI-use level | What the tool produced | What we changed | How we verified it |
|---|---|---|---|---|---|
| |
| PR #1 navigation, provider, and repayment code | Nolawi Assefa | 2 (review) | findings about the lending workflow, test evidence, and the date comparison raised in PR review. | Followed up on the date finding with the patch listed below. | Inspected the PR source and reproduced the due-today date comparison with a fixed reference time. |



## Which tasks did we do without an assistant first?

- The group  The submitted proposal records the group's roles, screen list, and milestone scope.

- Reported the due-today display issue in the PR. The comment described the midnight comparison and proposed coverage for yesterday, today, and tomorrow.
- Ran the analyzer and the standard Flutter test suite locally after the patch and supplied the terminal output as evidence for `MILESTONE.md`.
- Code skeleton design. 

## Problems found in AI output

- Codex ran Freezed generation with a file filter. In the relevant checkout, the command removed unrelated generated model files, and the first analyzer run failed on the missing files. Codex restored those files from Git and reran verification. The analyzer then reported no issues and all 32 tests passed.

## Individual declaration

The file lists below are draft review areas for each member to check before signing. Each member answers the personal-data declaration in their own row. The course oral check can draw from code outside a member’s list.

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Nolawi Assefa | Requests and loans in `lib/features/requests/` and `lib/features/loans/`, including the overdue-date fix, plus `test/providers/workflow_test.dart`. |no |Nolawi Assefa |
| Sitotaw Ashagre | App startup, routing, theme, shared widgets and demo state in `lib/main.dart` and `lib/core/`, authentication in `lib/features/auth/`, and the startup and navigation tests in `test/widget_test.dart` and `test/navigation/`. |no |Sitotaw Ashagre |
| Yonas Ayele | Offer screens, controller, models, repository and repayment calculator in `lib/features/offers/`, plus repayment records and their repository in `lib/features/repayments/domain/` and `lib/features/repayments/data/`. |no |Yonas Ayele |
| Yonatan Getachew | Settings and simulated explanations in `lib/features/settings/` and `lib/features/explanations/`, the repayment form and controller in `lib/features/repayments/presentation/`, and the domain tests in `test/domain/repayment_calculator_test.dart`. |no | Yonatan Getachew |

**Date signed** 11/27/2026
