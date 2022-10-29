import 'package:json_annotation/json_annotation.dart';

part 'postingan_data.g.dart';

@JsonSerializable()
class PostinganData {
  @JsonKey(name: 'id')
  late final int id;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'content')
  final String content;

  PostinganData({
    required this.id,
    this.title = "",
    this.content = "",
  });

  factory PostinganData.fromJson(Map<String, dynamic> json) =>
      _$PostinganDataFromJson(json);

  Map<String, dynamic> toJson() => _$PostinganDataToJson(this);

  @override
  String toString() {
    return 'PostinganData{id: $id, name: $title, email: $content}';
  }
}
