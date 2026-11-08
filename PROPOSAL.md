# Project proposal

## 1. Title and one-sentence description

**PeerLend: A Peer-to-Peer Lending and Loan Management App**

An app that helps individual borrowers and lenders arrange small peer-to-peer loans, track repayment terms and understand calculations through an AI assistant so that both sides have a clear record of their agreement.

## 2. Group

| Name | Proposed starting role |
|---|---|
| Nolawi Assefa | Coordination and loan workflow |
| Sitotaw Ashagre | UI and navigation |
| Yonas Ayele | Data and backend |
| Yonatan Getachew | Testing and AI integration |

Roles are starting points for team review; everyone will write and review code across layers. Member identifiers and contact details remain in `project.yaml`.

## 3. The problem

People arranging small personal loans can lose track of agreed amounts, interest and due dates when records are spread across conversations, paper notes or spreadsheets. Borrowers need to compare the full repayment cost; lenders need to see requests and distinguish scheduled repayments from recorded repayments. These are problem assumptions to validate, not findings from completed interviews.

A mobile app puts offers, agreed terms and repayment records in one place, with offline access, reminders and an optional camera note. PeerLend will be an educational prototype using fictional loans and test accounts. It will not move money, collect identity documents, assess creditworthiness, enforce contracts or give financial advice. A real-money service would require separate legal, security and regulatory review.

**Validation before submission:** identify one real potential user who experiences this problem and record their name with permission, current workaround and feedback. This required rubric item remains unconfirmed; no interview is claimed.

## 4. Users

- **Occasional borrower:** needs clear offer comparisons and repayment totals; browses when seeking a loan and checks progress near due dates.
- **Individual lender:** needs to publish terms, review requests and follow repayment records; checks weekly and when a request arrives.

One account may use either role, but cannot request its own offer.

## 5. User stories

1. **S1:** As a participant, I want to sign in and access my own records so that other users cannot change them. (**must**)
2. **S2:** As a lender, I want to publish an amount, interest rate and repayment period so that borrowers can inspect my offer. (**must**)
3. **S3:** As a borrower, I want to browse offers, preview total repayments and submit a request so that I can compare terms. (**must**)
4. **S4:** As a participant, I want lender approval followed by borrower confirmation of the same terms so that the loan record reflects both decisions. (**must**)
5. **S5:** As a participant, I want to record and confirm repayments and view cached schedules and history so that I can track the remaining balance. (**must**)
6. **S6:** As a borrower, I want optional due-date reminders so that I can plan repayments. (**should**)
7. **S7:** As a participant, I want to photograph a mock repayment receipt as a private local note so that I can keep supporting context. (**must**)
8. **S8:** As a participant, I want an AI explanation of example loan terms and calculated totals so that I can understand them. (**must**)

## 6. Screens

| Screen | Purpose | Stories |
|---|---|---|
| Sign in / register | Authentication, validation and recovery | S1 |
| Home / loan history | Active loans, balance and completed records | S5, S6 |
| Offer list | Browse and filter available offers | S3 |
| Offer detail / request | Terms, repayment preview and request action | S3, S8 |
| Create / edit offer | Validate and publish an available offer | S2 |
| Requests / confirmation | Lender decision and borrower confirmation | S4 |
| Loan detail | Schedule, terms snapshot and repayment status | S4–S6 |
| Record repayment / camera | Amount, date, confirmation and local photo | S5, S7 |
| AI explanation | Consent, example inputs and explanation | S8 |
| Settings | Reminder controls, privacy and sign out | S1, S6–S8 |

Four key screen sketches, using fictional amounts:

```text
+-----------------------------+  +-----------------------------+
| OFFERS                      |  | OFFER DETAIL                |
| Amount [ ]  Term [ ]         |  | Principal 1,000 test units  |
| 1,000 | 12% annual | 3 months|  | Simple interest: 30         |
| Total 1,030       [View]     |  | Total 1,030 / 3 instalments |
| 500 | 0% | 2 months [View]   |  | [Explain] [Send request]    |
+-----------------------------+  +-----------------------------+
| CREATE OFFER                |  | LOAN DETAIL                 |
| Amount [1000]               |  | Confirmed terms [View]      |
| Annual rate % [12]          |  | Due 1: 343.33 [Recorded]    |
| Months [3]                  |  | Due 2: 343.33 [Upcoming]    |
| [Preview] [Publish]         |  | [Record repayment] [Photo]  |
+-----------------------------+  +-----------------------------+
```

Navigation will use `go_router`; every data screen will handle loading, empty, error and offline states.

## 7. Data model

- **User:** uid, displayName, createdAt.
- **Offer:** id, lenderId, principalMinor, currency, annualRateBps, termMonths, status, version.
- **Request:** id, offerId, borrowerId, termsSnapshot, status, createdAt.
- **Loan:** id, requestId, lenderId, borrowerId, termsSnapshot, startDate, status.
- **Instalment:** id, loanId, dueDate, amountMinor.
- **Repayment:** id, loanId, instalmentId, amountMinor, recordedBy, recordedAt, confirmationStatus.
- **LocalReceipt / Preferences:** repaymentId, localPhotoPath; uid, reminderEnabled, aiConsent.

A user owns many offers and requests; an approved, confirmed request creates one loan with many instalments and repayments. Atomic transitions prevent accepting an offer twice. Confirmed terms cannot be silently edited. Only confirmed repayments reduce the balance.

The prototype uses one currency and simple interest: principal × annual rate × months / 12. Amounts use integer minor units; rounding adjusts the final instalment. For 1,000 at 12% over three months, total repayment is 1,030, split as 343.33, 343.33 and 343.34. No penalties, compounding or refinancing are planned.

## 8. Data sources

- **Local:** Drift stores account-scoped cached loans, schedules, repayment history and local receipt paths; shared_preferences stores settings. Cached views remain readable offline; financial-state changes require connectivity. Sign-out clears private cached data.
- **REST:** a small team-built Node.js service provides `POST /repayment-preview` for deterministic schedules and an AI explanation endpoint. Tests use a local server; production uses a deployed HTTPS endpoint.
- **Firebase:** Authentication manages accounts; Cloud Firestore holds offers, requests, loans and repayment records. Rules restrict private records to participants and validate permitted state changes.

Each source sits behind a repository interface. Flutter 3.47.7, Riverpod, immutable `freezed` models and feature-first folders follow the course toolchain.

## 9. Device feature and AI feature

**Camera (S7):** capture a mock receipt on explicit request. Ask for camera permission only then; handle granted, denied, permanently denied and unavailable states with a typed-note alternative. Photos stay in app-private local storage, with delete controls; no cloud or AI upload.

**AI explanation (S8):** use an `ExplanationService` interface backed by a proposed OpenAI API integration through our server. After explicit consent, send only fictional/example principal, annual rate, term, deterministic schedule and a predefined question to our backend and OpenAI. Do not send names, account IDs, real repayment history, photos or unrestricted personal text. Keep the API key server-side. Label output as AI-generated educational information; arithmetic remains authoritative in tested code. On failure, show the schedule and a static explanation.

## 10. Risks

| Risk | Likelihood | Plan |
|---|---|---|
| Incorrect totals or conflicting updates | Medium | Integer arithmetic, boundary tests and atomic state changes |
| API outage, quotas or cost | Medium | Timeouts, capped requests, fakes and static AI fallback |
| Private-data exposure | Medium | Firebase rule tests, isolated caches and no personal AI inputs |
| Permission denial / missed reminders | High | Typed notes and in-app due dates remain usable |
| Scope and timetable pressure | Medium | Fixed simple-interest model; defer extras and divide reviews |

## 11. Milestone plan

- **Week 6, M1:** all ten screens and S1–S8 interactions demonstrated with in-memory repositories; navigation, Riverpod and models in place. At least five unit/widget tests; record analyzer and test results.
- **Week 10, M2:** S1–S5 work with Firebase, REST previews and persistent local reads. Test access rules, calculations, repositories and main flows; document setup and coverage, with an initial accessibility/release check.
- **Week 14, final:** complete S6–S8, permission/consent fallbacks and user testing. Run analyzer, unit, widget and integration tests in GitHub Actions, targeting at least 60% line coverage. Deliver development/production flavours, signed production build, README, PRIVACY.md, USER_TEST.md, AI_USAGE.md and milestone evidence.

Use weekly reviews, feature branches and merge-commit PRs. Every member authors and reviews at least one PR per milestone.

## 12. AI-use plan

dot, an OpenAI-powered assistant, helped draft this proposal and check it against the course template. The team must review the proposed roles, technical choices and missing user validation before submission. ChatGPT or similar tools may support learning, boilerplate, code review and test ideas. We will verify retained output, understand and explain submitted code, attribute substantial generated code and record tool use and checks in `AI_USAGE.md`. No secrets or other people's private data will be supplied to AI tools.

Course references: [proposal template](https://github.com/betsegawlemma/mobile-application-development-course/blob/main/project/proposal-template.md), [project requirements](https://github.com/betsegawlemma/mobile-application-development-course/blob/main/project/README.md), [AI policy](https://github.com/betsegawlemma/mobile-application-development-course/blob/main/syllabus/policies.md).

