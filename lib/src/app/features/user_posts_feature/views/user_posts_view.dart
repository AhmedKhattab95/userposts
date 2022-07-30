import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/grouped_user_posts.dart';
import 'package:topics/src/app/theme/app_sizes.dart';
import 'package:topics/src/localization/app_localization.dart';

class UserPostsView extends ConsumerStatefulWidget {
  final GroupedUserPosts userWithPosts;

  const UserPostsView({required this.userWithPosts, Key? key}) : super(key: key);

  @override
  AuthorPostsViewState createState() => AuthorPostsViewState();
}

class AuthorPostsViewState extends ConsumerState<UserPostsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userWithPosts.user.name),
      ),
      body: Padding(
        padding: AppSizes.pagePadding,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(widget.userWithPosts.user.url, width: double.infinity),
              const SizedBox(
                height: 20,
              ),
              ..._getPostsDesign()
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _getPostsDesign() {
    var result = widget.userWithPosts.posts
        ?.map((post) => Card(
              child: Padding(
                padding: AppSizes.cardPadding,
                child: ListTile(
                  title: Text(post.title),
                  subtitle: Text(post.body),
                ),
              ),
            ))
        .toList();
    if (result == null) {
      return [Text(AppLocalization.translation.noContent)];
    }
    return result;
  }
}
