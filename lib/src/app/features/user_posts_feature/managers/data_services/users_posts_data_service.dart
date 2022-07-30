import 'package:topics/src/app/managers/managers_lib.dart';
import 'package:topics/src/app/urls.dart';
import 'package:topics/src/core/core_lib.dart';

import 'models/post.dart';
import 'models/user.dart';

class UsersPostsDataServiceImpl implements UsersPostsDataService {
  final HttpManager httpManager;

  UsersPostsDataServiceImpl(this.httpManager);

  @override
  Future<List<Post>> getPosts() async {
    var result = await httpManager.httpService.get(Urls.postsUrl, RequestData());
    return postFromJson(result.data);
  }

  @override
  Future<List<User>> getUsers() async{
    var result = await httpManager.httpService.get(Urls.usersUrl, RequestData());
    return userFromJson(result.data);
  }
}

abstract class UsersPostsDataService {
  Future<List<User>> getUsers();

  Future<List<Post>> getPosts();
}
