import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hn_app/src/hn_bloc.dart';
import 'json_parsing.dart';
import 'src/article.dart';
import "package:url_launcher/url_launcher.dart";
import 'dart:async';
import 'package:http/http.dart' as http;

/// inherited widget provide blocs to widgets blow
void main() async {
  final hnBloc= HackerNewsBloc();
  runApp(MyApp(bloc:hnBloc));
}

class MyApp extends StatelessWidget {

  final HackerNewsBloc bloc;

  const MyApp({Key key, this.bloc}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: MyHomePage(
        title: 'Flutter Demo Home Page',
        bloc: bloc,),
    );
  }
}

class MyHomePage extends StatefulWidget {


  MyHomePage({Key key, this.title, this.bloc}) : super(key: key);

  final String title;
  final HackerNewsBloc bloc;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

//  List <Article> _articles = articles;

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

//return future Articles
  Future<Article>_getArticle(int id ) async{
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return parseArticle(storyRes.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
          stream: widget.bloc.articles,
          initialData:UnmodifiableListView<Article>([]),
          builder: (context,snapshot) => ListView(
            /// Data mapped to some widgets
            children: snapshot.data.map(_buildItem).toList(),
          )
      )
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article article) {
//    if(e.text.startsWith("Circular")) return null;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ExpansionTile(title: new Text(article.title?? '[null]',style: TextStyle(fontSize: 19),),
//            subtitle: new Text("${article.commentsCount} Comments"),
//            onTap: () async {
//                final fakeUrl="http://${article.domain}";
//                if (await canLaunch(fakeUrl)){
//                  launch(fakeUrl);
//                }
//            },
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text("${article.type}"),
                new MaterialButton(color: Colors.deepOrange,
                  textColor: Colors.white,

                  onPressed:() async{

//                      final fakeUrl="http://${article.url}";
                      if (await canLaunch(article.url)){
                        launch(article.url);
                      }
                      

                },child: new Text("OPEN"),)
              ],
            ),
          ],
          ),
        );
  }
}
