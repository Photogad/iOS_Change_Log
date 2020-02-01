#
# Be sure to run `pod lib lint CLGChangeLog.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CLGChangeLog'
  s.version          = '0.2.0'
  s.summary          = 'iOS change log is a library that automates the notification of the change log to the user'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
iOS change log is a library that automates the notification of the change log of new version of an app to the user. It shows the change log first time the app runsy after an update.
                       DESC
  s.swift_version    = '4.2'
  s.homepage         = 'https://github.com/photogad/iOS_Change_Log.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matteo Pillon' => 'matteo@matteopillon.im' }
  s.source           = { :git => 'https://github.com/photogad/iOS_Change_Log.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'CLGChangeLog/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CLGChangeLog' => ['CLGChangeLog/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
