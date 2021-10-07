import 'package:flutter/material.dart';
import '../service/ghost_api.dart';

class HomeModel with ChangeNotifier {
  List<Map<String, dynamic>> posts = [];
  bool loading = false;
  bool isEnd = false;
  int page = 1;

  Future<void> loadMorePosts() async {
    if (loading) return;
    loading = true;
    notifyListeners();
    var response = await GhostAPI().getPosts(page: page);
    if (response['posts'] != null && response['posts'].isNotEmpty) {
      posts = [...posts, ...response['posts']];
      page++;
    } else {
      isEnd = true;
    }
    loading = false;
    notifyListeners();
  }

  Future<void> refeshPosts() async {
    if (loading) return;
    loading = true;
    notifyListeners();
    page = 1;
    posts = [];
    var response = await GhostAPI().getPosts(page: page);
    
    if (response['posts'] != null && response['posts'].isNotEmpty) {
      posts = [...posts, ...response['posts']];
      page++;
    } else {
      isEnd = true;
    }
    loading = false;
    notifyListeners();
  }
}
