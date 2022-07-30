import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/grouped_user_posts.dart';

abstract class UsersPostsManager {
  /// download posts and users and return grouped users with posts
  Future<List<GroupedUserPosts>> getUsersWithPostsGrouped();
}
