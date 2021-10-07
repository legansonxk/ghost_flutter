import 'package:flutter/material.dart';
import '../service/ghost_api.dart';

class TagModel with ChangeNotifier {
  List<Map<String, dynamic>> tags = [];
  bool loading = false;
  int page = 1;
  bool isEnd = false;

  Future<void> loadMoreTags() async{
    if (loading) return;
    loading = true;
    notifyListeners();
    var response = await GhostAPI().getTags(page: page);
    if (response['tags'] != null && response['tags'].isNotEmpty) {
      tags = [...tags, ...response['tags']];
      page++;
      notifyListeners();
    } else {
      isEnd = true;
    }
    for (var i = 0; i < tags.length; i++) {
      var tag = tags[i];
      if (tag['posts'] == null) {
        var posts = await GhostAPI().getPosts(page: 1, tag: tags[i]['slug']);
        tag['posts'] = posts['posts'];
      }
      tags[i] = tag;
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }

  Future<void> refreshTags() async{
    if (loading) return;
    loading = true;
    notifyListeners();
    tags = [];
    page = 1;
    var response = await GhostAPI().getTags(page: page);
    if (response['tags'] != null && response['tags'].isNotEmpty) {
      tags = [...tags, ...response['tags']];
      page++;
      notifyListeners();
    } else {
      isEnd = true;
    }
    for (var i = 0; i < tags.length; i++) {
      var tag = tags[i];
      if (tag['posts'] == null) {
        var posts = await GhostAPI().getPosts(page: 1, tag: tags[i]['slug']);
        tag['posts'] = posts['posts'];
      }
      tags[i] = tag;
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }
}