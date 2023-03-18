#
# Be sure to run `pod lib lint netappspayios.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'netappspayios'
  s.version          = '0.0.2'
  s.summary          = 'NetAppsPay is a payment processing platform that allows you to easily integrate payments into your iOS application.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description = <<-DESC
NetAppsPay is a payment processing library that allows you to easily integrate payments into your iOS app. With NetAppsPay, you can accept payments from multiple payment channels including cards, bank transfers, and mobile wallets.

To get started with NetAppsPay, simply install the library using CocoaPods and then use the provided APIs to initiate payments and handle payment callbacks. The library provides a simple and intuitive interface for integrating payments into your app, making it easy to get started even if you have no previous experience with payment processing.

Features of NetAppsPay include:

- Support for multiple payment channels including cards, bank transfers, and mobile wallets
- Easy integration with CocoaPods
- Simple and intuitive APIs for initiating payments and handling payment callbacks
- Comprehensive documentation and support resources

To learn more about NetAppsPay and how it can help you accept payments in your iOS app, visit our website or check out the documentation included with the library.
DESC

  s.homepage         = 'https://github.com/vi31b/netappspayios'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'NetApps', :file => 'LICENSE' }
  s.author           = { 'lawrence nwoko' => 'nwokolawrence6@gmail.com' }
  s.source           = { :git => 'https://github.com/vi31b/netappspayios.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'netappspayios/Classes/**/*'
  s.dependency 'FLAnimatedImage', '~> 1.0'
#   s.resource_bundles = {
#     'netappspayios' => ['netappspayios/Assets/*.gif']
#   }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
