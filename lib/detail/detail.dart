import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

class Detail extends StatelessWidget {
  final Map<String, dynamic> post;
  Detail({this.post});

  @override
  Widget build(BuildContext context) {
    String image = post['feature_image'];
    String title = post['title'];
    String excerpt = post['excerpt'];
    DateTime date = DateTime.parse(post['published_at']);
    String author = post['authors'][0]['name'];
    String avatar = post['authors'][0]['profile_image'];
    int time = post['reading_time'];
    String html = post['html'];

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(image),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
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
                      const SizedBox(height: 5),
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      Text(excerpt),
                      const SizedBox(height: 5),
                      HtmlWidget(html),
                      const SizedBox(height: 20),
                    ],
                  ),
                )
              ],
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(left: 10),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(50)),
                  padding: const EdgeInsets.all(8),
                  child: Icon(CupertinoIcons.back),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
