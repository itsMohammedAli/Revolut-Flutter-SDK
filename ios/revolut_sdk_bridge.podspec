Pod::Spec.new do |s|
  s.name             = 'revolut_sdk_bridge'
  s.version          = '0.2.1'
  s.summary          = 'Flutter plugin for accepting Revolut Pay payments via the native Revolut Pay SDK on iOS.'
  s.description      = <<-DESC
Flutter plugin that bridges the native Revolut Pay SDK for iOS, allowing you to accept Revolut Pay payments in your Flutter apps.
                       DESC
  s.homepage         = 'https://github.com/itsMohammedAli/Revolut-Flutter-SDK'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'Oussama Berhili' => 'oussamaberhili190@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files = 'revolut_sdk_bridge/Sources/revolut_sdk_bridge/**/*.swift'
  s.resource_bundles = { 'revolut_sdk_bridge_privacy' => ['revolut_sdk_bridge/Sources/revolut_sdk_bridge/PrivacyInfo.xcprivacy'] }
  s.dependency 'Flutter'
  s.dependency 'RevolutPayments/RevolutPay', '3.18.0'
  s.platform = :ios, '15.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
  s.static_framework = true

end
