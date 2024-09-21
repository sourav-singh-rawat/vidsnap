part of '../app_services.dart';

enum AppBooterStatus { booting, booted }

extension AppBooterStatusX on AppBooterStatus {
  bool get isBooting => this == AppBooterStatus.booting;
  bool get isBooted => this == AppBooterStatus.booted;
}

class AppBooterState {
  final AppBooterStatus bootStatus;
  const AppBooterState({
    required this.bootStatus,
  });

  AppBooterState.init()
      : this(
          bootStatus: AppBooterStatus.booting,
        );

  AppBooterState copyWith({AppBooterStatus? bootStatus}) {
    return AppBooterState(
      bootStatus: bootStatus ?? this.bootStatus,
    );
  }
}
