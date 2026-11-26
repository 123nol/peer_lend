# Milestone 1 — working submission record

**Prepared:** 26 November 2026
**Branch:** `feature/m1-screens-navigation`
**Implementation/test commit:** `d735a8819a5d7124fd8e669f5893bb1d9f4ad910`
**Submission status:** Not tagged. Group review and standard-runner verification remain pending.

## Done

- All ten proposal screen groups, plus separate register, recovery and edit routes, are implemented and reachable through `go_router`.
- Bottom navigation, a wide-screen navigation rail, parameterized routes, back navigation, authentication redirects, and missing/private-record handling are implemented.
- Feature-first `lib/core` and `lib/features/<feature>/{domain,data,presentation}` structure is in place.
- Riverpod owns application state; Freezed models and in-memory repositories sit behind interfaces.
- Fictional accounts support offer creation/editing, requests, lender approval, borrower confirmation, loan schedules, repayment recording and confirmation, settings, and explanation consent.
- Demo controls expose loading, empty, error and offline views. Offline mode blocks financial changes while retaining readable records.
- 31 meaningful unit/widget tests are included. The analyzer is clean and all 31 tests pass through the direct headless Flutter engine.

## Not done / outside this milestone

- Persistence, real authentication, REST, Firebase and server-side atomic transactions are not implemented.
- Camera/photo capture, email recovery, notifications and AI service calls are simulated or described in the UI.
- Android/iOS device builds and manual device acceptance are not claimed.
- The normal `flutter test` runner cannot start in this sandbox because localhost socket binding is denied; passing standard output must be captured on a normal development machine before submission.
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

This conservative draft scores completed evidence only; revise it after the remaining group work and standard checks.

| Criterion | Self-score | Evidence |
|---|---:|---|
| All proposed screens present and navigable | 3/3 | The route table in README covers every proposal screen group and widget tests visit each route. |
| Feature-first structure; state in providers | 2/2 | Seven features have domain/data/presentation layers, repository interfaces, Freezed models and Riverpod-owned application state. |
| Tests and clean analyzer/test output | 0/1 pending | Analyzer and 31 headless tests pass, but the required standard `flutter test` output is blocked by this environment. |
| Repository hygiene | 0/1 pending | A dedicated branch has progressive descriptive commits, but group-authored/reviewed PR evidence has not yet been recorded. |
| Individual oral checks | 0/3 pending | Oral checks have not occurred and must be recorded individually by the instructor. |
| **Total currently evidenced** | **5/10** | Five additional points depend on completing verification, review evidence and the oral checks. |

## One change before Milestone 2

Replace the fake authentication and in-memory repositories with authenticated persistent implementations, retaining the same interfaces and adding integration tests for account isolation and atomic request/repayment transitions.

## Verification evidence

Toolchain: Flutter 3.47.7, Dart 3.13.5. These are development results for the implementation commit above, not a claim of checks on a final `m1` tag. A temporary writable copy of the installed SDK was used because the installed SDK directory is read-only in this sandbox.

### Analyzer — passed

Command: `flutter analyze --fatal-infos` (SDK version checking suppressed in the sandbox).

```text
Analyzing peer_lend...
No issues found! (ran in 13.6s)
```

### Standard test runner — blocked by environment

Command: `flutter test --reporter expanded` (SDK version checking suppressed in the sandbox). The suite compiles, but the runner cannot bind its local communication socket. Actual output:

```text
00:00 +0: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/widget_test.dart
00:00 +0 -1: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/widget_test.dart [E]
  Failed to load "/home/yonas/Desktop/coding/elective_class/peer_lend/test/widget_test.dart": Failed to create server socket (OS Error: Operation not permitted, errno = 1), address = 127.0.0.1, port = 0
  dart:io-patch/socket_patch.dart 1248:7                           _NativeSocket.bind
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2195:12                          _RawServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2515:12                          _ServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:_http/http_impl.dart 3479:24                                _HttpServer.bind.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_tester_device.dart 89:15  FlutterTesterTestDevice.start
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_platform.dart 679:51      FlutterPlatform._startTest.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/base/async_guard.dart 108:24           asyncGuard.<fn>

00:00 +0 -2: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/navigation/app_navigation_test.dart [E]
  Failed to load "/home/yonas/Desktop/coding/elective_class/peer_lend/test/navigation/app_navigation_test.dart": Failed to create server socket (OS Error: Operation not permitted, errno = 1), address = 127.0.0.1, port = 0
  dart:io-patch/socket_patch.dart 1248:7                           _NativeSocket.bind
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2195:12                          _RawServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2515:12                          _ServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:_http/http_impl.dart 3479:24                                _HttpServer.bind.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_tester_device.dart 89:15  FlutterTesterTestDevice.start
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_platform.dart 679:51      FlutterPlatform._startTest.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/base/async_guard.dart 108:24           asyncGuard.<fn>

00:00 +0 -3: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/domain/repayment_calculator_test.dart [E]
  Failed to load "/home/yonas/Desktop/coding/elective_class/peer_lend/test/domain/repayment_calculator_test.dart": Failed to create server socket (OS Error: Operation not permitted, errno = 1), address = 127.0.0.1, port = 0
  dart:io-patch/socket_patch.dart 1248:7                           _NativeSocket.bind
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2195:12                          _RawServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2515:12                          _ServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:_http/http_impl.dart 3479:24                                _HttpServer.bind.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_tester_device.dart 89:15  FlutterTesterTestDevice.start
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_platform.dart 679:51      FlutterPlatform._startTest.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/base/async_guard.dart 108:24           asyncGuard.<fn>

00:00 +0 -4: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/providers/workflow_test.dart [E]
  Failed to load "/home/yonas/Desktop/coding/elective_class/peer_lend/test/providers/workflow_test.dart": Failed to create server socket (OS Error: Operation not permitted, errno = 1), address = 127.0.0.1, port = 0
  dart:io-patch/socket_patch.dart 1248:7                           _NativeSocket.bind
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2195:12                          _RawServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:io-patch/socket_patch.dart 2515:12                          _ServerSocket.bind.<fn>
  ===== asynchronous gap ===========================
  dart:_http/http_impl.dart 3479:24                                _HttpServer.bind.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_tester_device.dart 89:15  FlutterTesterTestDevice.start
  ===== asynchronous gap ===========================
  package:flutter_tools/src/test/flutter_platform.dart 679:51      FlutterPlatform._startTest.<fn>
  ===== asynchronous gap ===========================
  package:flutter_tools/src/base/async_guard.dart 108:24           asyncGuard.<fn>

00:00 +0 -4: Some tests failed.

Failing tests:
  /home/yonas/Desktop/coding/elective_class/peer_lend/test/domain/repayment_calculator_test.dart: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/domain/repayment_calculator_test.dart
  /home/yonas/Desktop/coding/elective_class/peer_lend/test/navigation/app_navigation_test.dart: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/navigation/app_navigation_test.dart
  /home/yonas/Desktop/coding/elective_class/peer_lend/test/providers/workflow_test.dart: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/providers/workflow_test.dart
  /home/yonas/Desktop/coding/elective_class/peer_lend/test/widget_test.dart: loading /home/yonas/Desktop/coding/elective_class/peer_lend/test/widget_test.dart
```

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
3. Run `flutter analyze --fatal-infos` and `flutter test` on the final implementation, replace the blocked output with passing output, and update the self-score before tagging.
4. Commit the final evidence document. Run both commands again on that candidate commit, then tag that same commit `m1` and push the tag.
5. Every member should explain the route tree, provider/repository separation, terms snapshots and repayment confirmation during the oral check.
