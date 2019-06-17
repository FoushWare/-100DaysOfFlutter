import 'article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';

class HackerNewsBloc{

// initialize new empty list of articles
var _articles=<Article>[];


Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;
/// BehaviorSubject => It also allows sending data, error and done events
/// to the listener, but the latest item that has been added to the subject
/// will be sent to any new listeners of the subject
final _articlesSubject= BehaviorSubject<UnmodifiableListView<Article>>();

HackerNewsBloc(){
_updateArticles().then((_){
  /// push list of articles to the stream  .. send to the UI what will represent in the ui not make it do some logic
  _articlesSubject.add(UnmodifiableListView(_articles));
   
});
}

List<int>_ids=[
  18052923,
  18053337,
  18034912,
  18046274,
  18041368,
  18054574,
  18039489,
  18050090,
  18047418,
  18035283
];

Future<Null> _updateArticles() async{
  /// iterable future  ... use Future.wait(_iterable)
  final futuresArticles=  _ids.map((id)=>_getArticle(id));

  final articles= await Future.wait(futuresArticles);
  _articles=articles;

}


//return future Articles
  Future<Article> _getArticle(int id ) async{
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }


}
