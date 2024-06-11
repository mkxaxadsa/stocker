extension Replacer on String {
  String rp(Map<String, String> params) {
    String result = this;
    for (final key in params.keys) {
      result = result.replaceAll("{$key}", params[key] ?? "");
    }
    return result;
  }
}
