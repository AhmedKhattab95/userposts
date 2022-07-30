import 'package:flutter/material.dart';
import 'package:topics/src/app/gloabl.dart';
import 'package:topics/src/core/core_lib.dart';
import 'package:topics/src/localization/app_localization.dart';

import '../theme/theme_lib.dart';

class NoConnectionView extends StatelessWidget {
  final VoidCallback? afterNetworkBackCallback;

  NoConnectionView({Key? key, this.afterNetworkBackCallback}) : super(key: key);

  final ConnectivityService connectivityService = serviceLocator<ConnectivityService>();
  final NavigationService navigationService = serviceLocator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: Padding(
          padding: AppSizes.pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const NoConnection(),
              ElevatedButton(
                  onPressed: () {
                    _checkNetwork();
                  },
                  child: Text(AppLocalization.translation.retry))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _checkNetwork() async {
    if (await connectivityService.hasInterentConnection) {
      afterNetworkBackCallback?.call();
      navigationService.pop();
    }
  }
}

class NoConnection extends StatelessWidget {
  const NoConnection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppAssets.noConnection,
        ),
        const SizedBox(height: 36),
        Text(
          AppLocalization.translation.noNetwork,
          style: theme.textTheme.headline6,
        ),
        const SizedBox(height: 45),
      ],
    );
  }
}
