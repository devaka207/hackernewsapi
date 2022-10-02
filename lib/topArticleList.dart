
import 'package:webview_flutter/webview_flutter.dart';

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hackernews/story.dart';
import 'package:hackernews/webservice.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hackernews/urlHelper.dart';

class TopArticleList extends StatefulWidget {
  const TopArticleList({Key? key}) : super(key: key);

  @override
  _TopArticleListState createState() => _TopArticleListState();
}

class _TopArticleListState extends State<TopArticleList> {
  /*int _page = 0;

  final int _limit = 20;

  bool _isFirstLoadRunning = false;
  bool _hasNextPage = true;

  bool _isLoadMoreRunning = false;*/
  List<Story> _stories = List<Story>.empty();


  @override
  void initState() {
    super.initState();
    _populateTopStories();
  }

  void _populateTopStories() async {

    final responses = await Webservice().getTopStories();
    final stories = responses.map((response) {
    final json = jsonDecode(response.body);
      return Story.fromJSON(json);

    }).toList();
    //final prettyString = jsonEncode(json);
    //print(prettyString);
    //log('json: $prettyString');

    setState(() {
      _stories = stories;
    });
  }
  void _navigateToNextScreen(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => NewScreen()));
  }

  /*void _navigateToShowCommentsPage(BuildContext context, int index) async {

    final story = this._stories[index];
    final responses = await Webservice().getCommentsByStory(story);
    final comments = responses.map((response) {
      final json = jsonDecode(response.body);
      return Comment.fromJSON(json);

    }).toList();

    Navigator.push(context, MaterialPageRoute(
        builder: (context) => CommentListPage(story: story, comments: comments)
    ));


  }*/

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: const Text("Hacker News"),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemCount: _stories.length,
          itemBuilder: (_, index) {
            return ListTile(
              onTap: () {
                _navigateToNextScreen(context);
                Fluttertoast.showToast(
                    msg: "Pressed",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 16.0
                );

              },
              title: Text(_stories[index].title, style: const TextStyle(fontSize: 18)),
              subtitle: Text(_stories[index].url, style: const TextStyle(fontSize: 15)),
              trailing: Container(
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(20))
                  ),
                  alignment: Alignment.center,
                  width: 50,
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text("${_stories[index].commentIds.length}",style: const TextStyle(color: Colors.white)),
                  )
              ),
            );
          },
        )
    );

  }

}
