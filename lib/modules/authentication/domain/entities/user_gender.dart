enum UserGender {
  male("Male"),
  female("Female"),
  notSpecified("Not Specified");

  final String displayName;
  const UserGender(this.displayName);

  @override
  String toString() {
    return displayName;
  }

  get getStringValues {
    return UserGender.values.map((e) => e.displayName).toList();
  }
}
