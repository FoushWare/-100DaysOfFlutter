import 'package:hn_app/src/article.dart';
import 'dart:convert' as json;

List<int> parseTopStories(String jsonString){

  final parsed = json.jsonDecode(jsonString);
  final listOfIds=List<int>.from(parsed);

  return listOfIds;
}

Article parseArticle(String jsonStr){

  final parsed= json.jsonDecode(jsonStr);  //Decode the Json
  Article article=Article.fromJson(parsed);
  return article;

}