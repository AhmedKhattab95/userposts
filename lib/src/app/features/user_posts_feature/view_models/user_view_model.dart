import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:topics/src/app/executer/executer.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/data_services/models/grouped_user_posts.dart';
import 'package:topics/src/app/features/user_posts_feature/managers/users_posts_manager/users_posts_manager.dart';
import 'package:topics/src/app/features/user_posts_feature/views/user_posts_view.dart';
import 'package:topics/src/core/core_lib.dart';

var userViewModel = ChangeNotifierProvider<UserViewModel>((ref) => UserViewModel(
    serviceLocator<UsersPostsManager>(), serviceLocator<Executer>(), serviceLocator<NavigationService>()));

class UserViewModel extends ChangeNotifier {
  final UsersPostsManager _usersPostsManager;
  final NavigationService _navigationService;
  final Executer _executer;

  UserViewModel(this._usersPostsManager, this._executer, this._navigationService);

  /// region  should be called first thing in page
  List<GroupedUserPosts> groupedPostsPerUser = [];

  Future<void> onLoad() async {
    _updateLoading(true);
    await _executer.execute<void>(() async {
      groupedPostsPerUser = await _usersPostsManager.getUsersWithPostsGrouped();

      return const Right(null);
    });
    _updateLoading(false);
    notifyListeners();
  }

  /// endregion

  ///region loading
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void _updateLoading(bool newValue) {
    _isLoading = newValue;
    notifyListeners();
  }

  void navigateToUserPosts(GroupedUserPosts userData) {
    _navigationService.push(UserPostsView(userWithPosts: userData));
  }

  ///endregion
}
