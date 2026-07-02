/// The state of a single scheduled dose for a given day.
enum DoseStatus {
  /// Neither taken nor rejected yet — the default state.
  pending,
  taken,
  rejected;

  static DoseStatus fromName(String name) {
    return DoseStatus.values.firstWhere(
      (s) => s.name == name,
      orElse: () => DoseStatus.pending,
    );
  }
}
