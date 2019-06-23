import 'dart:async';
import 'dart:collection';

import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';

import 'article.dart';

enum StoriesType{
  topStories,
  newStories
}

class HackerNewsBloc {
  static List<int> _newIds = [
    18054574,
    18039489,
    18050090,
    18047418,
    18035283,
  ];

  static List<int> _topIds = [
    18052923,
    18053337,
    18034912,
    18046274,
    18041368,
  ];

  /// we need stream of bool to indicate isLoading or Not
  Stream<bool> get isLoading => _isLoadingSubject.stream;
  final _isLoadingSubject=BehaviorSubject.seeded(false);



  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];

  final _storiesTypeController = StreamController<StoriesType>();

  HackerNewsBloc() {
    _getArticlesAndUpdate(_topIds);

    _storiesTypeController.stream.listen((storiesType) {
      if (storiesType == StoriesType.newStories) {
        _getArticlesAndUpdate(_newIds);
      } else {
        _getArticlesAndUpdate(_topIds);
      }
    });
  }

  Stream<UnmodifiableListView<Article>> get articles => _articlesSubject.stream;

  Sink<StoriesType> get storiesType => _storiesTypeController.sink;

  Future<Article> _getArticle(int id) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  _getArticlesAndUpdate(List<int> ids)  async{
    _isLoadingSubject.add(true);
    _updateArticles(ids).then((_) {
      _articlesSubject.add(UnmodifiableListView(_articles));
      _isLoadingSubject.add(false);
    });
  }

  Future<Null> _updateArticles(List<int> articlesIds) async {
    final futuresArticles = articlesIds.map((id) => _getArticle(id));
    final articles = await Future.wait(futuresArticles);
    _articles = articles;
  }
}