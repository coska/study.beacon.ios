# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

pod 'FLKAutoLayout', '<= 1.0'

# update to th version 2.02 (master) due to error in Xcode 8
#pod 'RealmSwift', '<= 1.01'
pod 'RealmSwift', :git => 'https://github.com/realm/realm-cocoa.git', :branch => 'master', submodules: true

pod 'PulsingHalo'

target 'Buddy Beacon' do

end

# until Swift 3.0 being used
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3' # or '3.0'
        end
    end
end
