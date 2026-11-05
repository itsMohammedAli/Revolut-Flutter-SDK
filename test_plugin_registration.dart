#!/usr/bin/env dart
// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  print('🔍 Testing Revolut SDK Bridge Plugin Registration');
  print('=' * 50);
  
  // Check if GeneratedPluginRegistrant.m exists and contains our plugin
  final registrantFile = File('example/ios/Runner/GeneratedPluginRegistrant.m');
  
  if (!registrantFile.existsSync()) {
    print('❌ GeneratedPluginRegistrant.m not found');
    exit(1);
  }
  
  final content = registrantFile.readAsStringSync();
  
  if (content.contains('RevolutSdkBridgePlugin')) {
    print('✅ RevolutSdkBridgePlugin found in GeneratedPluginRegistrant.m');
  } else {
    print('❌ RevolutSdkBridgePlugin NOT found in GeneratedPluginRegistrant.m');
    exit(1);
  }
  
  if (content.contains('[RevolutSdkBridgePlugin registerWithRegistrar:')) {
    print('✅ Plugin registration call found');
  } else {
    print('❌ Plugin registration call NOT found');
    exit(1);
  }
  
  // Check if pubspec.yaml has plugin configuration
  final pubspecFile = File('pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print('❌ pubspec.yaml not found');
    exit(1);
  }
  
  final pubspecContent = pubspecFile.readAsStringSync();
  
  if (pubspecContent.contains('plugin:')) {
    print('✅ Plugin configuration found in pubspec.yaml');
  } else {
    print('❌ Plugin configuration NOT found in pubspec.yaml');
    exit(1);
  }
  
  if (pubspecContent.contains('RevolutSdkBridgePlugin')) {
    print('✅ RevolutSdkBridgePlugin class name found in pubspec.yaml');
  } else {
    print('❌ RevolutSdkBridgePlugin class name NOT found in pubspec.yaml');
    exit(1);
  }
  
  print('\n🎉 Plugin registration appears to be correctly configured!');
  print('\n📱 To test the plugin:');
  print('   1. Run: cd example && flutter run');
  print('   2. Tap "Initialize SDK" button');
  print('   3. Check if initialization succeeds without MissingPluginException');
}
