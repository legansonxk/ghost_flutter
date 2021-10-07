import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:after_layout/after_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'home_model.dart';

import '../card/one_card.dart';
import '../card/two_card.dart';

const ui = [1, 3, 2, 1];

class HomeScreen extends StatefulWidget {
  @override
  _StateHomeScreen createState() => _StateHomeScreen();
}

class _StateHomeScreen extends State<HomeScreen> with AfterLayoutMixin {
  HomeModel get homeModel => Provider.of<HomeModel>(context, listen: false);
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void afterFirstLayout(BuildContext context) {
    homeModel.loadMorePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(builder: (context, model, child) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
              onRefresh: () async {
                await model.refeshPosts();
                _refreshController.refreshCompleted();
              },
              onLoading: () async {
                await model.loadMorePosts();
                _refreshController.loadComplete();
              },
              child: ListView.builder(
                itemBuilder: (context, value) {
                  return OneCard(
                    post: model.posts[value],
                    isLeft: value % 2 == 0,
                  );
                },
                itemCount: model.posts.length,
              ),
            ),
          ),
        ),
      );
    });
  }
}
