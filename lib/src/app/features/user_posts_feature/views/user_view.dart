import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/grouped_user_posts.dart';
import 'package:topics/src/app/settings/settings_controller.dart';
import 'package:topics/src/app/settings/settings_view.dart';
import 'package:topics/src/app/theme/app_sizes.dart';
import 'package:topics/src/app/widgets/widgets_lib.dart';
import 'package:topics/src/core/core_lib.dart';
import 'package:topics/src/localization/app_localization.dart';

import '../view_models/user_view_model.dart';

class UserView extends ConsumerStatefulWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  ConsumerState<UserView> createState() => _AuthorViewState();
}

class _AuthorViewState extends ConsumerState<UserView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(userViewModel).onLoad();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalization.translation.auhorPosts),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              serviceLocator<NavigationService>().push(SettingsView(
                controller: serviceLocator<SettingsController>(),
              ));
            },
          ),
        ],
      ),
      body: Padding(
        padding: AppSizes.pagePadding,
        child: Consumer(builder: (_, ref, __) {
          var vm = ref.watch(userViewModel);
          if (vm.isLoading) {
            return const PageProgressIndecator();
          }
          if (vm.groupedPostsPerUser.isEmpty) {
            return Center(
              child: Text(AppLocalization.translation.noContent),
            );
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(userViewModel).onLoad(),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                var userWithPosts = vm.groupedPostsPerUser[index];
                return _authorCard(userWithPosts);
              },
              itemCount: vm.groupedPostsPerUser.length,
            ),
          );
        }),
      ),
    );
  }

  Widget _authorCard(GroupedUserPosts userData) {
    return GestureDetector(
      onTap: () => ref.read(userViewModel).navigateToUserPosts(userData),
      child: Card(
        child: ListTile(
          leading: Image.network(userData.user.thumbnailUrl),
          title: Text('${AppLocalization.translation.name}: ${userData.user.name}'),
          subtitle: Text('${AppLocalization.translation.postsCount}: ${userData.posts?.length.toString() ?? '0'}'),
        ),
      ),
    );
  }
}
