
platform :ios, '12.0'
use_frameworks!
inhibit_all_warnings!

workspace 'GithubStargaers.xcworkspace'

def services
  pod 'Moya', '~> 13.0.1'
end

def common
  pod 'SwiftLint'
  pod 'RxSwift', '5.1.1'
  pod 'RxCocoa', '5.1.1'
end

def app
  pod 'Anchorage'
  pod 'Kingfisher'
  pod 'IQKeyboardManagerSwift', '6.4.0'
  # Development
  pod 'SwiftGen'
end

target 'GithubStargazers' do
  common
  app
  services
end

target 'GithubStargazersTests' do
  common
  pod 'RxTest'
end


target 'GithubStargazersServices' do
  inherit! :search_paths
  project 'GithubStargazersServices/GithubStargazersServices.xcodeproj'
  common
  services
end

target 'GithubStargazersModels' do
  inherit! :search_paths
  project 'GithubStargazersModels/GithubStargazersModels.xcodeproj'
  common
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10'
      end
    end
end
