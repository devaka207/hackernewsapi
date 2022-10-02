import 'dart:convert';

import 'package:hackernews/story.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Webservice {
  
  Future<Response> _getStory(int storyId) {
    return http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/item/${storyId}.json?print=pretty"));
  }

  Future<List<Response>> getCommentsByStory(Story story) async {

    return Future.wait(story.commentIds.map((commentId)  {
        return http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"));
    }));

  }

  Future<List<Response>> getTopStories() async {
    
    final response = await http.get(Uri.parse("https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"));
    if (response.statusCode == 200) {
      Iterable storyIds = jsonDecode(response.body);

      return Future.wait(storyIds.take(5).map((storyId) {
        return _getStory(storyId);
      }));

    } else {
      throw Exception("Unable to fetch data!");
    }
  }
}
