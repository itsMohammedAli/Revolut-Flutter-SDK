import 'dart:io';
import 'pigeon_revolut_platform.dart';
import 'revolut_platform.dart';

RevolutPlatform createRevolutPlatform() => PigeonRevolutPlatform(
  type: Platform.isAndroid
      ? RevolutPlatformType.android
      : Platform.isIOS
      ? RevolutPlatformType.ios
      : RevolutPlatformType.unsupported,
);
