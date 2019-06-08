import 'package:flutter/material.dart';
import 'src/article.dart';
import "package:url_launcher/url_launcher.dart";
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List <Article> _articles = articles;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: new RefreshIndicator(
          onRefresh: () async{
            await new Future.delayed(const Duration(seconds: 1));
            setState(() {
              _articles.removeAt(0);
            });

          },
          child: ListView(
//        mainAxisAlignment: MainAxisAlignment.center,
            children: _articles.map( _buildItem).toList()
          ),
        ),
      ),
     // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _buildItem(Article article) {
//    if(e.text.startsWith("Circular")) return null;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: new ExpansionTile(title: new Text(article.text,style: TextStyle(fontSize: 19),),
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
                new Text("${article.commentsCount} Comments"),
                new MaterialButton(color: Colors.deepOrange,
                  textColor: Colors.white,

                  onPressed:() async{

                      final fakeUrl="http://${article.domain}";
                      if (await canLaunch(fakeUrl)){
                        launch(fakeUrl);
                      }
                      

                },child: new Text("OPEN"),)
              ],
            ),
          ],
          ),
        );
  }
}
