

//// GENERATED CODE - DO NOT MODIFY BY HAND
//
//part of serializers;
//
//// **************************************************************************
//// BuiltValueGenerator
//// **************************************************************************
//
//Serializers _$serializers = (new Serializers().toBuilder()
//  ..add(Article.serializer)
//  ..addBuilderFactory(
//      const FullType(BuiltList, const [const FullType(int)]),
//          () => new ListBuilder<int>())
//  ..addBuilderFactory(
//      const FullType(BuiltList, const [const FullType(int)]),
//          () => new ListBuilder<int>()))
//    .build();
//
//// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new


















//import 'package:hn_app/src/article.dart';
//import 'dart:convert' as json;
//import 'package:built_value/built_value.dart';
//import 'package:built_collection/built_collection.dart';
//import 'package:built_value/serializer.dart';
//
//import 'package:hn_app/src/serializers.dart';
//part 'json_parsing.g.dart';
//
//abstract class Article implements Built<Article, ArticleBuilder> {
//
//    static Serializer<Article> get serializer => _$articleSerializer;
//
//  int get id;
//
//  @nullable
//  bool get deleted;
//
//  String get type;
//
//  String get by;
//
//  int get time;
//
//  @nullable
//  String get text;
//
//  @nullable
//  bool get dead;
//
//  @nullable
//  int get poll;
//
//  BuiltList<int> get kids;
//
//  @nullable
//  String get url;
//
//  @nullable
//  int get score;
//
//  @nullable
//  String get title;
//
//  BuiltList<int> get parts;
//
//  @nullable
//  int get descendants;
//
//  Article._();
//
//  factory Article([void Function(ArticleBuilder) updates]) = _$Article;
//}
//
//List<int> parseTopStories(String jsonString) {
//  return []; // return List<int>();
//
////  final parsed = json.jsonDecode(jsonString);
////  final listOfIds=List<int>.from(parsed);
////
////  return listOfIds;
//}
//
//Article parseArticle(String jsonStr) {
//  final parsed= json.jsonDecode(jsonStr);  //Decode the Json
//  Article article=standardSerializers.deserializeWith(Article.serializer, parsed);
//  return article;
//}
