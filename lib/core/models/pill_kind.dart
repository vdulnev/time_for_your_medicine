/// The visual shape of a pill in the design.
enum PillKind {
  capsule,
  round;

  static PillKind fromName(String name) => PillKind.values.firstWhere(
    (k) => k.name == name,
    orElse: () => PillKind.round,
  );
}
