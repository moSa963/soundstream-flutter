class DurationFormat {
  // return duration as hours:minutes:seconds string
  static String toHms(Duration? duration) {
    if (duration == null) return "0:00";

    int seconds = duration.inSeconds;
    int hours = (seconds / 3600).floor();
    int minutes = ((seconds -= (hours * 3600)) / 60).floor();
    int rseconds = (seconds - (minutes * 60)).floor();

    String res = "";

    if (hours > 0) {
      res += "$hours:";
    }

    return "$res${minutes.toString().padLeft(2, "0")}:${rseconds.toString().padLeft(2, "0")}";
  }
}
