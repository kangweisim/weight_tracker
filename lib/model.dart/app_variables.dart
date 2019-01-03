class AppVariables {
  final bool hasLoaded;
  
  AppVariables({
    this.hasLoaded = false,
  });

  AppVariables copyWith({bool hasLoaded}) {
    return AppVariables(
      hasLoaded: hasLoaded ?? this.hasLoaded,
    );
  }

  AppVariables.fromJson(Map json)
    : hasLoaded = false;

  Map toJson() {
    return {
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }
}