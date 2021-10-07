import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../service/ghost_api.dart';
import '../card/one_card.dart';

class TagPosts extends StatefulWidget {
  final List<Map<String, dynamic>> posts;
  final String slug;
  final String name;
  TagPosts({this.posts, this.slug, this.name});

  @override
  _StateTagPosts createState() => _StateTagPosts();
}

class _StateTagPosts extends State<TagPosts> {
  List<Map<String, dynamic>> posts;
  int page = 2;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isEnd = false;

  @override
  void initState() {
    super.initState();
    posts = widget.posts;
  }

  Future<void> onRefresh() async {
    var response = await GhostAPI().getPosts(page: 1, tag: widget.slug);
    setState(() {
      page = 2;
      posts = List<Map<String, dynamic>>.from(response['posts'] ?? []);
      isEnd = false;
    });
    _refreshController.refreshCompleted();
  }

  Future<void> onLoadMore() async {
    var response = await GhostAPI().getPosts(page: page, tag: widget.slug);
    if (response['posts'] != null && response['posts'].isEmpty) {
      setState(() {
        isEnd = true;
      });
    }
    setState(() {
      page = page + 1;
      posts = [
        ...posts,
        ...List<Map<String, dynamic>>.from(response['posts'] ?? [])
      ];
    });
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Icon(CupertinoIcons.back),
                  ),
                ),
                Text(
                  widget.name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: !isEnd,
                  header: WaterDropHeader(
                    complete: Container(),
                  ),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus mode) {
                      return Container();
                    },
                  ),
                  controller: _refreshController,
                  onRefresh: onRefresh,
                  onLoading: onLoadMore,
                  child: ListView.builder(
                    itemBuilder: (context, index) => OneCard(
                      post: posts[index],
                    ),
                    itemCount: posts.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
