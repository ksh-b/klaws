class Modifier {
  static String strip(String value, List<String> params) {
    for (String param in params) {
      value =  value.replaceAll(param, "");
    }
    return value;
  }

  static String replace(String value, List<String> params) {
    if (params.length!=2) return value;
    return value.replaceAll(params.first, params.last);
  }

  static String applyModification(
      String target,
      Map<String, dynamic> modification,
      List<String> params
  ) {
    switch (modification["action"]) {
      case "strip":
        return Modifier.strip(target, params);
      case "replace":
        return Modifier.replace(target, params);
      default:
        return target;
    }
  }
}
