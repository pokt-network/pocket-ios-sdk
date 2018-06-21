# Pocket
#
# Verifying:
# pod lib lint Pocket.podspec --allow-warnings
#
# Releasing:
# pod repo push master Pocket.podspec --allow-warnings

Pod::Spec.new do |s|
  # Meta
  s.name      = 'Pocket'
  s.version   = '0.0.1'
  s.license   = { :type => 'MIT' }
  s.homepage  = 'https://github.com/pokt-network/pocket-ios-sdk'
  s.authors   = { 'Luis C. de Leon' => 'luis@pokt.network' }
  s.summary   = 'An iOS SDK to connect to the Pocket Network.'

  # Settings
  s.source            = { :git => 'https://github.com/pokt-network/pocket-ios-sdk.git', :tag => s.version.to_s }
  s.source_files      = 'Pocket/Pocket/**/*.{swift}'
  s.exclude_files     = 'Pocket/PocketTests/**/*.{swift}'
  s.swift_version     = '4.0'
  s.cocoapods_version = '>= 1.4.0'

  # Deployment Targets
  s.ios.deployment_target = '11.4'

  # Framework dependencies
  s.dependency 'SwiftKeychainWrapper', :git => 'git@github.com:jrendel/SwiftKeychainWrapper.git', :branch => 'develop', :commit => '77f73c354d695d976bcf1437fc9fbcea981aa2b4'
  s.dependency 'RNCryptor', '~> 5.0'
end
