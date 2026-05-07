class Role {
  final int id;
  final String name;

  Role({required this.id, required this.name});

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Role && other.id == id);

  @override
  int get hashCode => id.hashCode;
}
