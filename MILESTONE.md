# Milestone 1 — working submission record

**Prepared:** 26 November 2026
**Branch:** `feature/m1-final-integration`
**Submission status:** Both required checks passed in a development run. Group review and verification of the final submission commit remain pending.

## Done

- All ten proposal screen groups, plus separate register, recovery and edit routes, are implemented and reachable through `go_router`.
- Bottom navigation, a wide-screen navigation rail, parameterized routes, back navigation, authentication redirects, and missing/private-record handling are implemented.
- Feature-first `lib/core` and `lib/features/<feature>/{domain,data,presentation}` structure is in place.
- Riverpod owns application state; Freezed models and in-memory repositories sit behind interfaces.
- Fictional accounts support offer creation/editing, requests, lender approval, borrower confirmation, loan schedules, repayment recording and confirmation, settings, and explanation consent.
- Demo controls expose loading, empty, error and offline views. Offline mode blocks financial changes while retaining readable records.
- Loan Detail marks an unpaid instalment overdue only after its local due date has passed. A regression test covers yesterday, today, and tomorrow.
- The analyzer reported no issues, and all 34 unit and widget tests passed with the standard Flutter test runner.

## Not done / outside this milestone

- Persistence, real authentication, REST, Firebase and server-side atomic transactions are not implemented.
- Camera/photo capture, email recovery, notifications and AI service calls are simulated or described in the UI.
- Android/iOS device builds and manual device acceptance are not claimed.
- Team PR authorship/reviews, instructor/TA access for a private repository, proposal approval/change status and oral checks still require group confirmation.
- No `m1` tag has been created or pushed. The existing `proposal` tag has been preserved.

## Member pull requests

| Member | GitHub | Authored PRs | Reviewed PRs |
|---|---|---|---|
| Nolawi Assefa | `123nol` | [#4](https://github.com/123nol/peer_lend/pull/4) |   [#5](https://github.com/123nol/peer_lend/pull/5)|
| Sitotaw Ashagre | `yotors` | [#3](https://github.com/123nol/peer_lend/pull/3) |[#6](https://github.com/123nol/peer_lend/pull/6)  |
| Yonas Ayele | `yonayetol` |  [#5](https://github.com/123nol/peer_lend/pull/5) | [#3](https://github.com/123nol/peer_lend/pull/3) |
| Yonatan Getachew | `jajos12` | [#6](https://github.com/123nol/peer_lend/pull/6) | [#4](https://github.com/123nol/peer_lend/pull/4)|

## Provisional self-score before tagging

This draft scores the evidence recorded so far. Revise it after group review and verification of the final submission commit.

| Criterion | Self-score | Evidence |
|---|---:|---|
| All proposed screens present and navigable | 3/3 | `test/navigation/app_navigation_test.dart` verifies that the proposed screens are reachable and checks the phone and wide-screen navigation. |
| Feature-first structure; state in providers | 2/2 | Seven features have domain/data/presentation layers, repository interfaces, Freezed models and Riverpod-owned application state. |
| Tests and clean analyzer/test output | 1/1 | The analyzer reported no issues and the standard Flutter test runner passed all 34 tests in the development run documented below. |
| Repository hygiene | 0/1 pending | All four members have linked authored PRs, and two members have recorded reviews. |
| Individual oral checks | 0/3 pending | Oral checks have not occurred and must be recorded individually by the instructor. |
| **Total currently evidenced** | **6/10** | Four additional points depend on repository hygiene evidence and the individual oral checks. |

## One change before Milestone 2

Replace the fake authentication and in-memory repositories with authenticated persistent implementations, retaining the same interfaces and adding integration tests for account isolation and atomic request/repayment transitions.

## Verification evidence

The following output is from a development run. Verify the final submission commit before tagging it `m1`.

### Analyzer passed

Command `flutter analyze --fatal-infos`

```text
  _fe_analyzer_shared 96.0.0 (111.0.0 available)
  analyzer 10.2.0 (14.7.0 available)
  build 4.0.7 (5.0.0 available)
  build_config 1.3.3 (1.4.0 available)
  build_runner 2.15.1 (2.17.1 available)
  built_collection 5.1.2 (6.0.0 available)
  cli_util 0.6.0 (0.6.1 available)
  coverage 1.16.0 (1.16.2 available)
  dart_style 3.1.7 (3.1.14 available)
  flutter_riverpod 3.3.1 (3.5.0 available)
  freezed 3.2.5 (4.0.3 available)
  go_router 17.5.0 (18.1.4 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  meta 1.18.3 (1.19.0 available)
  package_config 2.2.0 (3.0.0 available)
  riverpod 3.2.1 (3.5.0 available)
  source_gen 4.2.4 (4.3.1 available)
  test 1.31.1 (1.33.0 available)
  test_api 0.7.12 (0.7.15 available)
  test_core 0.6.18 (0.6.21 available)
  vector_math 2.4.0 (2.4.4 available)
Got dependencies!
21 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
Analyzing elective...                                                   
No issues found! (ran in 0.6s)
```

### Standard Flutter tests passed

Command `flutter test`

```text
Resolving dependencies... 
Downloading packages... 
  _fe_analyzer_shared 96.0.0 (111.0.0 available)
  analyzer 10.2.0 (14.7.0 available)
  build 4.0.7 (5.0.0 available)
  build_config 1.3.3 (1.4.0 available)
  build_runner 2.15.1 (2.17.1 available)
  built_collection 5.1.2 (6.0.0 available)
  cli_util 0.6.0 (0.6.1 available)
  coverage 1.16.0 (1.16.2 available)
  dart_style 3.1.7 (3.1.14 available)
  flutter_riverpod 3.3.1 (3.5.0 available)
  freezed 3.2.5 (4.0.3 available)
  go_router 17.5.0 (18.1.4 available)
  material_color_utilities 0.13.0 (0.13.1 available)
  meta 1.18.3 (1.19.0 available)
  package_config 2.2.0 (3.0.0 available)
  riverpod 3.2.1 (3.5.0 available)
  source_gen 4.2.4 (4.3.1 available)
  test 1.31.1 (1.33.0 available)
  test_api 0.7.12 (0.7.15 available)
  test_core 0.6.18 (0.6.21 available)
  vector_math 2.4.0 (2.4.4 available)
Got dependencies!
21 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
00:07 +34: All tests passed!
```
