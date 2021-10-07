import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'author_model.dart';
import 'author_card.dart';
import 'author_posts.dart';

class AuthorScreen extends StatefulWidget {
  @override
  _StateAuthorScreen createState() => _StateAuthorScreen();
}

class _StateAuthorScreen extends State<AuthorScreen> with AfterLayoutMixin {
  AuthorModel get authorModel =>
      Provider.of<AuthorModel>(context, listen: false);
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void afterFirstLayout(BuildContext context) {
    authorModel.loadMoreAuthors();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthorModel>(builder: (context, model, child) {
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
              await model.refreshAuthors();
              _refreshController.refreshCompleted();
            },
            onLoading: () async{
              await model.loadMoreAuthors();
              _refreshController.loadComplete();
            },
            child: ListView.builder(
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HorizontalAuthor(
                  author: model.authors[index],
                ),
              ),
              itemCount: model.authors.length,
            ),
          ),
        ),
      );
    });
  }
}

class HorizontalAuthor extends StatelessWidget {
  final Map<String, dynamic> author;
  HorizontalAuthor({this.author});

  @override
  Widget build(BuildContext context) {
    String name = author['name'];
    String image = author['profile_image'];
    String bio = author['bio'];
    List<dynamic> posts = author['posts'];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 50,
                height: 50,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.network(image),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(bio)
                  ],
                ),
              ),
              InkWell(
                onTap: () => Navigator.push(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(microseconds: 300),
                    pageBuilder: (BuildContext context, Animation<double> _,
                        Animation<double> __) {
                      return AuthorPosts(
                        posts: List<Map<String, dynamic>>.from(posts ?? []),
                        slug: author['slug'],
                        image: image,
                        name: name,
                        bio: bio,
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
                    child: AuthorCard(
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
