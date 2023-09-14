# Uncomment the next line to define a global platform for your project
platform :ios, '16.0'

target 'Motorcycle' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Motorcycle
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseFirestore'
  pod 'FirebaseFirestoreSwift'
  pod 'FirebaseStorage'
  pod 'Alamofire'
  pod 'Resolver'
  pod 'OneSignal/OneSignal', '>= 5.0.0', '< 6.0'
  pod 'OneSignal/OneSignalInAppMessages', '>= 5.0.0', '< 6.0'

end

target 'OneSignalNotificationServiceExtension' do
  use_frameworks!
  pod 'OneSignal/OneSignal', '>= 5.0.0', '< 6.0'
  pod 'OneSignal/OneSignalInAppMessages', '>= 5.0.0', '< 6.0'
end

post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
            end
        end
    end
end
