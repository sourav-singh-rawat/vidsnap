part of '../app_services.dart';

abstract class Booter<T> {
  Future<T> bootUp();

  void onBootUp();

  void bootDown();
}
