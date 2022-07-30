import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/grouped_user_posts.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/users_posts_data_service.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/users_posts_manager/users_posts_manager.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/post.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/user.dart';

class UsersPostsManagerImpl extends UsersPostsManager {
  final UsersPostsDataService usersDataService;

  UsersPostsManagerImpl(this.usersDataService);

  @override
  Future<List<GroupedUserPosts>> getUsersWithPostsGrouped() async {
    var result = await Future.wait([_downloadUsers(), _downloadPosts()]);
    //group and return new object
    var users = result[0] as List<User>;
    var posts = result[1] as List<Post>;

    List<GroupedUserPosts> groupdUserPosts = [];
    for (var user in users) {
      var userPosts = posts.where((post) => post.userId == user.userId).toList();
      groupdUserPosts.add(GroupedUserPosts(user, userPosts));
    }
    return groupdUserPosts;
  }

  Future<List<User>> _downloadUsers() => usersDataService.getUsers();

  Future<List<Post>> _downloadPosts() => usersDataService.getPosts();
}
