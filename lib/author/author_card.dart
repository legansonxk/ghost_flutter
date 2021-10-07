import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../detail/detail.dart';

class AuthorCard extends StatelessWidget {
  final Map<String, dynamic> post;
  AuthorCard({this.post});

  @override
  Widget build(BuildContext context) {
    String image = post['feature_image'];
    String title = post['title'];
    String excerpt = post['excerpt'];
    DateTime date = DateTime.parse(post['published_at']);
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
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: Image.network(image),
            ),
            const SizedBox(height: 5),
            Text(
              (DateFormat('yMMMd').format(date) + ' • $time min read')
                  .toUpperCase(),
              style: TextStyle(fontSize: 12),
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
      ),
    );
  }
}
