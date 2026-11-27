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
| Offer Detail and offer routing in [PR #5](https://github.com/123nol/peer_lend/pull/5) | Nolawi Assefa | 2 (Review) | Codex identified the unresolved Requests import and the missing navigation routes for Offers. | The follow-up deferred the Requests and Explanations buttons and wired the browse, detail, create, and edit routes. | Reproduced the analyzer errors on the original PR snapshot. After the fixes, the analyzer reported no issues and all seven widget tests passed. |



## Which tasks did we do without an assistant first?

- The group  The submitted proposal records the group's roles, screen list, and milestone scope.

- Reported the due-today display issue in the PR. The comment described the midnight comparison and proposed coverage for yesterday, today, and tomorrow.
- Ran the analyzer and the standard Flutter test suite locally after the patch and supplied the terminal output as evidence for `MILESTONE.md`.
- Code skeleton design. 

## Problems found in AI output

- While patching the overdue-date issue, Codex ran `build_runner` with a file filter for `loan.freezed.dart`. The command regenerated the loan model and also removed five unrelated `.freezed.dart` files in that checkout. The analyzer failed because the source models still referenced those files. The Git diff exposed the deletions. Codex restored the five files from Git, kept the regenerated loan model, and reran verification. The analyzer reported no issues and all 32 tests passed at that stage.

## Individual declaration

The file lists below are draft review areas for each member to check before signing. Each member answers the personal-data declaration in their own row. The course oral check can draw from code outside a member’s list.

| Name | I wrote or reviewed and can explain these files | I entered no passwords, keys or personal data into an AI tool (yes / no) | Signature |
|---|---|---|---|
| Nolawi Assefa | Requests and loans in `lib/features/requests/` and `lib/features/loans/`, including the overdue-date fix, plus `test/providers/request_loan_workflow_test.dart`. |no |Nolawi Assefa |
| Sitotaw Ashagre | App startup, routing, theme, shared widgets and demo state in `lib/main.dart` and `lib/core/`, authentication in `lib/features/auth/`, and the startup and navigation tests in `test/widget_test.dart` and `test/navigation/`. |no |Sitotaw Ashagre |
| Yonas Ayele | Offer screens, controller, models, repository and repayment calculator in `lib/features/offers/`, plus repayment records and their repository in `lib/features/repayments/domain/` and `lib/features/repayments/data/`. |no |Yonas Ayele |
| Yonatan Getachew | Settings and simulated explanations in `lib/features/settings/` and `lib/features/explanations/`, the repayment form and controller in `lib/features/repayments/presentation/`, and the domain tests in `test/domain/repayment_calculator_test.dart`. |no | Yonatan Getachew |

**Date signed** 11/27/2026
