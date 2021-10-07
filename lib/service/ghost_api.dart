import 'dart:convert';
import 'package:http/http.dart' as http;

import 'api.dart';

class GhostAPI {
  static final GhostAPI _singleton = GhostAPI._internal();

  factory GhostAPI() {
    return _singleton;
  }

  GhostAPI._internal();

  Future<Map<String, dynamic>> getPosts({int page = 1, String tag, String author}) async {
    String endPoint = 'posts?include=authors&page=$page';
    if (tag != null) {
      endPoint += '&filter=tag:$tag';
    }
    if (author != null) {
      endPoint += '&filter=author:$author';
    }
    var posts = await Services.getAPI(endPoint);
    return Map<String, dynamic>.from(posts);
  }

  Future<Map<String, dynamic>> getTags({int page = 1}) async{
    var tags = await Services.getAPI('tags?page=$page');
    return Map<String, dynamic>.from(tags);
  }

  Future<Map<String, dynamic>> getAuthors({int page = 1}) async{
    var authors = await Services.getAPI('authors?page=$page');
    return Map<String, dynamic>.from(authors);
  }
}

class Services {
  static Future<dynamic> getAPI(String endpoint) async {
    var response;
    if (endpoint.contains('?')) {
      response = await http
          .get(Uri.parse(urlAPI + '/ghost/api/v3/content/' + endpoint + '&key=$keyAPI'));
    } else {
      response = await http
          .get(Uri.parse(urlAPI + '/ghost/api/v3/content/' + endpoint + '?key=$keyAPI'));
    }
    return jsonDecode(response.body);
  }
}
