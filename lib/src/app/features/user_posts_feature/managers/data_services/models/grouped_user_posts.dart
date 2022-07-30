import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/post.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/user.dart';

class GroupedUserPosts {
  final User user;
  final List<Post>? posts;

  GroupedUserPosts(this.user, this.posts);
}
