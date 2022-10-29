part of 'postingan_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostinganData _$PostinganDataFromJson(Map<String, dynamic> json) {
  return PostinganData(
    id: json['id'] as int,
    title: json['title'] as String,
    content: json['content'] as String,
  );
}

Map<String, dynamic> _$PostinganDataToJson(PostinganData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
    };
