/// Builds auth links without losing the page requested before sign-in.
enum AuthRoute {
  signIn('/sign-in'),
  register('/register'),
  recovery('/recovery');

  const AuthRoute(this.path);
  final String path;

  static bool matches(String path) {
    final normalized = path.replaceFirst(RegExp(r'/+$'), '');
    return values.any((route) => route.path == normalized);
  }

  String location({String? returnTo}) => Uri(
    path: path,
    queryParameters: returnTo == null ? null : {'from': returnTo},
  ).toString();

  String from(Uri current) =>
      location(returnTo: safeAuthReturnTo(current.queryParameters['from']));
}

/// Only internal, non-auth paths are eligible for post-auth navigation.
String? safeAuthReturnTo(String? value) {
  if (value == null || !value.startsWith('/') || value.startsWith('//')) {
    return null;
  }
  final target = Uri.tryParse(value);
  if (target == null || target.hasScheme || target.hasAuthority) return null;
  try {
    final path = Uri.decodeComponent(target.path);
    if (path.startsWith('//') ||
        path.contains(r'\') ||
        AuthRoute.matches(path)) {
      return null;
    }
  } on FormatException {
    return null;
  } on ArgumentError {
    return null;
  }
  return target.toString();
}
