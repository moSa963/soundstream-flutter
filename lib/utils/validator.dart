class Validator {
  /// validate [value]
  /// 
  /// Returns an error message or null if there is no error.
  static String? validate(String? value,
      {bool required = true,
      int? max,
      int? min,
      String? regex,
      String? equal}) {
    if (value == null || value.isEmpty) {
      if (required) {
        return "This field is required";
      }
      return null;
    }

    if (max != null && value.length > max) {
      return "The maximum length is $max";
    }

    if (min != null && value.length < min) {
      return "The minimum length is $min";
    }

    if (regex != null && !RegExp(regex).hasMatch(value)) {
      return "Incorrect format";
    }

    if (equal != null && value != equal) {
      return "This is not a valid value";
    }

    return null;
  }
}
