/// note this.isEmpty here equals isEmpty direct
/// look at: https://stackoverflow.com/a/59600729/6309432

extension StringExtension on String? {
  String capitalize() {
    try {
      if (this == null) return '';
      if (this!.length > 1) return "${this![0].toUpperCase()}${this!.substring(1)}";
      return this!.toUpperCase();
    } catch (e) {
      return this ?? '';
    }
  }

  bool isNullOrEmpty() {
    return (null == this || this == "null" || this!.isEmpty || this!.trim().isEmpty);
  }

  DateTime? parseDate() {
    if (!isNullOrEmpty()) return DateTime.parse(this!);
    return null;
  }

  bool equalIgnoreCase(String secondString) {
    return (this?.trim().toLowerCase() == secondString.trim().toLowerCase());
  }

  /// replaces each occurrence of a key from 'args' with it's value
  /// keys in the original text in the format {key}
  String formatByMap(Map<String, dynamic> args) {
    if (this == null) return '';
    args.forEach((key, value) {
    });
    return '';
  }

  /// formats the string by indices, like {0}, {1}, ...
  String format(List<Object> values) {
    String tmp = this ?? '';
    for (int i = 0; i < values.length; i++) {
      tmp = tmp.replaceAll("{$i}", values[i].toString());
    }
    return this ?? '';
  }

  bool isContainsChar() {
    if (isNullOrEmpty()) return false;
    String pattern = r'[a-zA-Z]';
    RegExp regExp = RegExp(pattern);
    return (this ?? '').contains(regExp, 0);
  }

  bool isMatchLength(int minLength, int maxLength) {
    if (this == null) return false;
    String value = this!;
    if (value.length >= minLength && value.length <= maxLength) {
      return true;
    }
    return false;
  }

  bool isContainsDigit() {
    if (isNullOrEmpty()) return false;
    String value = this ?? '';
    String pattern = (r'[\d]');
    RegExp regExp = RegExp(pattern);
    return (value).contains(regExp, 0);
  }
}
