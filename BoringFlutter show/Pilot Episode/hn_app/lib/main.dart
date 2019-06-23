import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hn_app/src/hn_bloc.dart';
import 'json_parsing.dart';
import 'src/article.dart';
import "package:url_launcher/url_launcher.dart";
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        primarySwatch: Colors.deepOrange
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

  /// create current index to change the active color on the bottom navigation  icons when it's clicked
  int _currentIndex =0;



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
        leading: LoadingInfo(widget.bloc.isLoading),
      ),
      body: StreamBuilder<UnmodifiableListView<Article>>(
          stream: widget.bloc.articles,
          initialData:UnmodifiableListView<Article>([]),
          builder: (context,snapshot) => ListView(
            /// Data mapped to some widgets
            children: snapshot.data.map(_buildItem).toList(),
          )
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          items: [
          BottomNavigationBarItem(
          icon: Icon(Icons.arrow_drop_up),
          title: Text('Top Stories')
          ),
          BottomNavigationBarItem(
          icon: Icon(Icons.new_releases),
          title: Text('New Stories')
          ),
      ],
       onTap: (index) {
        if (index == 0) {
          widget.bloc.storiesType.add(StoriesType.topStories);

        }
        else{
          widget.bloc.storiesType.add(StoriesType.newStories);
          index=1;
        }
        setState(() {
          _currentIndex=index;
        });

        })
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

class LoadingInfo extends StatefulWidget {

  Stream<bool> _isLoading;

  LoadingInfo(this._isLoading);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoadingInfoState();
  }

}


class LoadingInfoState extends State<LoadingInfo> with SingleTickerProviderStateMixin {


  AnimationController _controller;


  @override
  void initState() {
    super.initState();
    /// vsync => checks if the widget in the view or not so the flutter don't be panic animate things that not shown in the view
    _controller=AnimationController(vsync: this,
      duration: Duration(seconds: 3)
    );
  }

  @override
  Widget build(BuildContext context) {



    return StreamBuilder(
      stream: widget._isLoading,
      builder: (BuildContext context,AsyncSnapshot<bool>snapshot){
        ///  snapshot.hasData => to check if it's have data  because it it's not it will called before have data and will cause problems
        if(snapshot.hasData && snapshot.data) {
          _controller.forward().then((f)=>_controller.reverse());

          return FadeTransition(opacity: _controller,
              child: Icon(FontAwesomeIcons.hackerNewsSquare));
        }
        else
          return Container();
      },
    );
  }

}




