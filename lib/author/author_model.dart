import 'package:flutter/material.dart';
import '../service/ghost_api.dart';

class AuthorModel with ChangeNotifier {
  List<Map<String, dynamic>> authors = [];
  bool loading = false;
  int page = 1;
  bool isEnd = false;

  Future<void> loadMoreAuthors() async{
    if (loading) return;
    loading = true;
    notifyListeners();
    var response = await GhostAPI().getAuthors(page: page);
    if (response['authors'] != null && response['authors'].isNotEmpty) {
      authors = [...authors, ...response['authors']];
      page++;
      notifyListeners();
    } else {
      isEnd = true;
    }
    for (var i = 0; i < authors.length; i++) {
      var author = authors[i];
      if (author['posts'] == null) {
        var posts = await GhostAPI().getPosts(page: 1, author: authors[i]['slug']);
        author['posts'] = posts['posts'];
      }
      authors[i] = author;
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }

  Future<void> refreshAuthors() async{
    if (loading) return;
    loading = true;
    notifyListeners();
    authors = [];
    page = 1;
    var response = await GhostAPI().getAuthors(page: page);
    if (response['authors'] != null && response['authors'].isNotEmpty) {
      authors = [...authors, ...response['authors']];
      page++;
      notifyListeners();
    } else {
      isEnd = true;
    }
    for (var i = 0; i < authors.length; i++) {
      var author = authors[i];
      if (author['posts'] == null) {
        var posts = await GhostAPI().getPosts(page: 1, author: authors[i]['slug']);
        author['posts'] = posts['posts'];
      }
      authors[i] = author;
      notifyListeners();
    }
    loading = false;
    notifyListeners();
  }
}