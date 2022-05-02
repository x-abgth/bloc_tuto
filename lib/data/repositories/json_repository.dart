import 'package:bloc_tuto/data/models/posts_model.dart';
import 'package:http/http.dart' as http;

class JsonRepository {
  static String url = "https://jsonplaceholder.typicode.com/posts";

  Future<List<Posts>?> getData() async {
    final client = http.Client();

    var uri = Uri.parse(url);
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      return postsFromJson(response.body);
    }
    return null;
  }
}
