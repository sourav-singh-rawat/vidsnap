import 'dart:developer';

import 'package:vidsnap/modules/domain/module.dart';

class AppModuleImpl extends AppModule<void> {
  @override
  Future<void> bootUp() async {
    log('[AppModuleImpl.bootUp]');

    for (final module in AppModule.bootUpSequence) {
      try {
        await module.bootUp().then(
              (value) => module.onBootUp(),
            );
      } catch (err) {
        log('[AppModuleImpl]:[bootUp]: Error: $err');
      }
    }
  }

  @override
  void bootDown() {
    log('[AppModuleImpl.bootDown]');

    for (final module in AppModule.bootUpSequence.reversed) {
      try {
        module.bootDown();
      } catch (err) {
        log('[AppModuleImpl]:[bootDown]: Error: $err');
      }
    }
  }

  @override
  void onBootUp() {
    // TODO: implement onBootUp
    log('[AppModuleImpl.onBootUp]');
  }
}
