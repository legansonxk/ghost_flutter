import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'tag_model.dart';
import 'tag_card.dart';
import 'tag_posts.dart';

class TagScreen extends StatefulWidget {
  @override
  _StateTagScreen createState() => _StateTagScreen();
}

class _StateTagScreen extends State<TagScreen> with AfterLayoutMixin {
  TagModel get tagModel => Provider.of<TagModel>(context, listen: false);
    RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void afterFirstLayout(BuildContext context) {
    tagModel.loadMoreTags();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TagModel>(builder: (context, model, child) {
      return Scaffold(
        body: SafeArea(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: !model.isEnd,
            header: WaterDropHeader(
              complete: Container(),
            ),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                return Container();
              },
            ),
            controller: _refreshController,
            onRefresh: () async{
              await model.refreshTags();
              _refreshController.refreshCompleted();
            },
            onLoading: () async{
              await model.loadMoreTags();
              _refreshController.loadComplete();
            },
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HorizontalTag(
                  tag: model.tags[index],
                ),
              ),
              itemCount: model.tags.length,
            ),
          )
        ),
      );
    });
  }
}

class HorizontalTag extends StatelessWidget {
  final Map<String, dynamic> tag;
  HorizontalTag({this.tag});

  @override
  Widget build(BuildContext context) {
    String name = tag['name'];
    List<dynamic> posts = tag['posts'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(microseconds: 300),
                    pageBuilder: (BuildContext context, Animation<double> _,
                        Animation<double> __) {
                      return TagPosts(
                        posts: List<Map<String, dynamic>>.from(posts),
                        name: name,
                        slug: tag['slug'],
                      );
                    },
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var tween = Tween<double>(begin: 0.0, end: 1.0);

                      return FadeTransition(
                        opacity: tween.animate(animation),
                        child: child,
                      );
                    },
                  ),
                ),
                child: Text(
                  'See All',
                  style: TextStyle(color: Colors.blue),
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          if (posts != null)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  posts.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TagCard(
                      post: posts[index],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
