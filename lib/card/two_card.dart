import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../detail/detail.dart';

class TwoCard extends StatelessWidget {
  final Map<String, dynamic> leftPost;
  final Map<String, dynamic> rightPost;
  TwoCard({this.leftPost, this.rightPost});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: Card(
              post: leftPost,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Card(
              post: rightPost,
            ),
          ),
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final Map<String, dynamic> post;
  Card({this.post});

  @override
  Widget build(BuildContext context) {
    if (post == null) return Container();
    String image = post['feature_image'];
    String title = post['title'];
    String excerpt = post['excerpt'];
    DateTime date = DateTime.parse(post['published_at']);
    String author = post['authors'][0]['name'];
    String avatar = post['authors'][0]['profile_image'];
    int time = post['reading_time'];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(microseconds: 300),
            pageBuilder: (BuildContext context, Animation<double> _,
                Animation<double> __) {
              return Detail(post: post);
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
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: CachedNetworkImage(imageUrl: image),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(avatar),
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(author),
                    const SizedBox(height: 2),
                    Text(
                      (DateFormat('yMMMd').format(date) + ' • $time min read')
                          .toUpperCase(),
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            excerpt,
            maxLines: 8,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
