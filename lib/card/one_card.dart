import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../detail/detail.dart';

class OneCard extends StatelessWidget {
  final Map<String, dynamic> post;
  final bool isLeft;
  OneCard({this.post, this.isLeft = true});

  @override
  Widget build(BuildContext context) {
    String image = post['feature_image'];
    String title = post['title'];
    String excerpt = post['excerpt'];
    DateTime date = DateTime.parse(post['published_at']);
    String author = post['authors'][0]['name'];
    String avatar = post['authors'][0]['profile_image'];
    int time = post['reading_time'];
    if (isLeft) {
      return LayoutBuilder(
        builder: (context, constraints) {
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
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 2),
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(color: Colors.grey, width: 0.2),
                  borderRadius: BorderRadius.circular(3)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    width: constraints.maxWidth * 0.5,
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
                                    (DateFormat('yMMMd').format(date) +
                                            ' • $time min read')
                                        .toUpperCase(),
                                    style: TextStyle(fontSize: 12),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: constraints.maxWidth * 0.5 - 4.0,
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 7),
                        Text(
                          excerpt,
                          maxLines: 8,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
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
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 2),
            margin: const EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                border: Border.all(color: Colors.grey, width: 0.2),
                borderRadius: BorderRadius.circular(3)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: constraints.maxWidth * 0.5 - 4.0,
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        excerpt,
                        maxLines: 8,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  width: constraints.maxWidth * 0.5,
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
                                  (DateFormat('yMMMd').format(date) +
                                          ' • $time min read')
                                      .toUpperCase(),
                                  style: TextStyle(fontSize: 12),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
