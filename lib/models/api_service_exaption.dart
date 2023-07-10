

class ApiServiceExaption  {
  final int? status;
  final String message;

  ApiServiceExaption({ this.status, this.message="" });

  @override
  String toString() {
    return message;
  }
}