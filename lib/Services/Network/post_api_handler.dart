import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:socialapp/contant.dart';

class PostApiHelper {
  Future addPost({PickedFile image, caption}) async {
    var authToken = await FlutterSecureStorage().read(key: "authToken");
    var request = new http.MultipartRequest(
        "POST", Uri.parse("${baseUrl}post/create-post/"));
    request.files.add(await http.MultipartFile.fromPath(
      "image",
      image.path,
    ));
    print(image.path);
    request.fields.addAll(
        {"is_video": "False", "caption": caption.length > 0 ? caption : ""});
    request.headers.addAll({
      "Authorization": "Token $authToken",
      "Content-type": "multipart/form-data"
    });
    request.send().then((response) async {
      if (response.statusCode == 200)
        print(await response.stream.bytesToString());
      else
        print(await response.stream.bytesToString());
    });
  }

  Future<List> getHome() async {
    String authToken = await FlutterSecureStorage().read(key: "authToken");
    http.Response response = await http.get('${baseUrl}content/home',
        headers: {"Authorization": "Token $authToken"});
    var data = jsonDecode(response.body);
    return data;
  }

  Future<Map> likePost({postId}) async {
    String authToken = await FlutterSecureStorage().read(key: "authToken");
    // /post/like-post/7
    http.Response response = await http.get('${baseUrl}post/like-post/$postId',
        headers: {"Authorization": "Token $authToken"});
    var data = jsonDecode(response.body);
    print(data);
    return data;
  }

  Future<Map> unLikePost({postId}) async {
    String authToken = await FlutterSecureStorage().read(key: "authToken");
    // /post/like-post/7
    http.Response response = await http.get(
        '${baseUrl}post/unlike-post/$postId',
        headers: {"Authorization": "Token $authToken"});
    var data = jsonDecode(response.body);
    print(data);
    return data;
  }
}
