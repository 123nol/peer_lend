# Milestone 1 — working submission record

**Prepared:** 26 November 2026
**Branch:** `feature/m1-screens-navigation`
**Submission status:** Both required checks passed in a development run. Group review and verification of the final submission commit remain pending.

## Done

- All ten proposal screen groups, plus separate register, recovery and edit routes, are implemented and reachable through `go_router`.
- Bottom navigation, a wide-screen navigation rail, parameterized routes, back navigation, authentication redirects, and missing/private-record handling are implemented.
- Feature-first `lib/core` and `lib/features/<feature>/{domain,data,presentation}` structure is in place.
- Riverpod owns application state; Freezed models and in-memory repositories sit behind interfaces.
- Fictional accounts support offer creation/editing, requests, lender approval, borrower confirmation, loan schedules, repayment recording and confirmation, settings, and explanation consent.
- Demo controls expose loading, empty, error and offline views. Offline mode blocks financial changes while retaining readable records.
- Loan Detail marks an unpaid instalment overdue only after its local due date has passed. A regression test covers yesterday, today, and tomorrow.
- The analyzer reported no issues, and all 32 unit and widget tests passed with the standard Flutter test runner.

## Not done / outside this milestone

- Persistence, real authentication, REST, Firebase and server-side atomic transactions are not implemented.
- Camera/photo capture, email recovery, notifications and AI service calls are simulated or described in the UI.
- Android/iOS device builds and manual device acceptance are not claimed.
- Team PR authorship/reviews, instructor/TA access for a private repository, proposal approval/change status and oral checks still require group confirmation.
- No `m1` tag has been created or pushed. The existing `proposal` tag has been preserved.

## Member pull requests

Fill these with real links after authorship/review occurs; this document does not claim unperformed reviews.

| Member | GitHub | Authored PRs | Reviewed PRs |
|---|---|---|---|
| Nolawi Assefa | `123nol` | Pending group entry | Pending group entry |
| Sitotaw Ashagre | `yotors` | Pending group entry | Pending group entry |
| Yonas Ayele | `yonayetol` | Local feature branch prepared; PR pending | Pending review |
| Yonatan Getachew | `jajos12` | Pending group entry | Pending group entry |

## Provisional self-score before tagging

This draft scores the evidence recorded so far. Revise it after group review and verification of the final submission commit.

| Criterion | Self-score | Evidence |
|---|---:|---|
| All proposed screens present and navigable | 3/3 | The route table in README covers every proposal screen group and widget tests visit each route. |
| Feature-first structure; state in providers | 2/2 | Seven features have domain/data/presentation layers, repository interfaces, Freezed models and Riverpod-owned application state. |
| Tests and clean analyzer/test output | 1/1 | The analyzer reported no issues and the standard Flutter test runner passed all 32 tests in the development run documented below. |
| Repository hygiene | 0/1 pending | A dedicated branch has progressive descriptive commits, but group-authored/reviewed PR evidence has not yet been recorded. |
| Individual oral checks | 0/3 pending | Oral checks have not occurred and must be recorded individually by the instructor. |
| **Total currently evidenced** | **6/10** | Four additional points depend on repository hygiene evidence and the individual oral checks. |

## One change before Milestone 2

Replace the fake authentication and in-memory repositories with authenticated persistent implementations, retaining the same interfaces and adding integration tests for account isolation and atomic request/repayment transitions.

## Verification evidence

The following output is from a development run. Verify the final submission commit before tagging it `m1`.

### Analyzer passed

Command `flutter analyze --fatal-infos`

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
Analyzing elective...
No issues found! (ran in 0.6s)
```

### Standard Flutter tests passed

Command `flutter test`

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
00:06 +32: All tests passed!
```

## Additional development checks

The headless test and web build logs below are from implementation commit `d735a8819a5d7124fd8e669f5893bb1d9f4ad910` using Flutter 3.47.7 and Dart 3.13.5.

### Direct headless Flutter tests

Command: `PEER_LEND_FLUTTER_BIN=/tmp/peer-lend-flutter/bin/flutter bash tool/test_headless.sh`.

Actual output from the final fallback run: This executes the actual test files through Flutter's headless engine and the test package's standalone runner, without a localhost socket. It does not replace the required standard command for submission.

```text
00:00 +0: domain proposal example produces 30 ETB interest and exact instalments
00:00 +1: domain interest-free loan preserves principal
00:00 +2: domain rounding is exact for boundary amounts and all allowed terms
00:00 +3: domain invalid amount, rate and term are rejected
00:00 +4: domain terms are value objects and copyWith preserves original snapshot
00:00 +5: domain loan copies its schedule and exposes an immutable list
00:00 +6: domain repositories expose immutable snapshots and independent instances
00:00 +7: domain demo auth validates credentials and duplicate registrations
00:00 +8: providers repository interface can be overridden for tests
00:00 +9: providers borrower request, lender approval and borrower confirmation create one loan
00:00 +10: providers self requests and duplicate requests are rejected
00:00 +11: providers approving an offer declines competing pending requests
00:00 +12: providers edited terms cannot silently replace a pending request snapshot
00:00 +13: providers only owners can edit available offers
00:00 +14: providers pending repayments reserve amount but do not reduce balance
00:00 +15: providers confirmed final repayments complete the loan
00:00 +16: providers unrelated accounts cannot read private lists or mutate repayments
00:00 +17: providers offline blocks financial mutations but preserves data
00:00 +18: providers preferences belong to the signed-in account
00:00 +19: navigation every proposed screen is reachable on a phone
00:06 +20: navigation bottom navigation, offer detail and back work by tapping
00:08 +21: navigation deep link survives sign-in and logout protects records
00:09 +22: navigation register and recovery screens are reachable
00:09 +23: navigation invalid IDs and unauthorized edit routes show a recovery screen
00:10 +24: navigation new user cannot view another participant loan by URL
00:11 +25: navigation empty, error, loading and offline previews render
00:11 +26: navigation explanation is shown only after consent
00:12 +27: navigation offer creation validates and updates the browsable detail
00:13 +28: navigation small phone with enlarged text has no layout exceptions
00:15 +29: navigation wide screen uses the navigation rail
00:15 +30: smoke app starts at the demo sign-in screen
00:15 +31: All tests passed!
```

### Web release build — passed

Command: `flutter build web --no-pub --no-wasm-dry-run` (SDK version checking suppressed in the sandbox).

```text
Compiling lib/main.dart for the Web...
Expected to find fonts for (MaterialIcons, packages/cupertino_icons/CupertinoIcons), but found (MaterialIcons). This usually means you are referring to font families in an IconData class but not including them in the assets section of your pubspec.yaml, are missing the package that would include them, or are missing "uses-material-design: true".
Font asset "MaterialIcons-Regular.otf" was tree-shaken, reducing it from 1645184 to 10220 bytes (99.4% reduction). Tree-shaking can be disabled by providing the --no-tree-shake-icons flag when building your app.
Compiling lib/main.dart for the Web...                             63.3s
✓ Built build/web
```

The build reports an optional Cupertino font-family warning; this app uses Material icons. Phone home/offers and desktop home were rendered and visually inspected; previews are in `docs/screenshots/`.

## Before the group tags m1

1. Open and review feature PRs; every member must author and review actual work. Add those links above.
2. Verify any proposal feedback is resolved and private-repository staff access is configured.
3. Refresh the passing command output if the implementation changes and finalize the self-score before tagging.
4. Commit the final evidence document. Run both commands again on that candidate commit, then tag that same commit `m1` and push the tag.
5. Every member should explain the route tree, provider/repository separation, terms snapshots and repayment confirmation during the oral check.
