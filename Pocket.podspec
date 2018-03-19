Pod::Spec.new do |s|
  # Meta
  s.name            = 'Pocket'
  s.version         = '0.0.1'
  s.license         = { :type => 'MIT' }
  s.homepage        = 'https://github.com/pokt-network/pocket-ios-sdk'
  s.authors         = { 'Arthur Ariel Sabintsev' => 'arthur@sabintsev.com' }
  s.summary         = 'An iOS SDK to connect to the Pocket Network.'

  # Source Files
  s.source          = { :git => 'https://github.com/pokt-network/pocket-ios-sdk.git', :tag => s.version.to_s }
  s.source_files    = 'Pocket/**/*.{swift}'
  s.framework       = 'Foundation'
  s.platform        = :ios, '10.0'
  s.requires_arc    = true
  s.swift_version   = '4.0'
end
