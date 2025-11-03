class CustomDropdownModel {
  final String title;
  final dynamic children;

  CustomDropdownModel({required this.title, this.children});

  CustomDropdownModel copyWith({
    String? title,
    dynamic children,
  }) {
    return CustomDropdownModel(
      title: title ?? this.title,
      children: children ?? this.children,
    );
  }

  @override
  String toString() => title;
}
