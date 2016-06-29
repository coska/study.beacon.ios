#Buddy Beacon

Buddy Beacon is the app that checks whether a Bluetooth beacon is near your phone location or not, performs predefined actions like as turning on or off WiFi, sending predefined text message to someone, or initiating phone calls to someone. The app currently supports fifteen major brands of Bluetooth beacons in the market.

The app is one of the outcome of the Beacon Study Group in COSKA 2016, which had originally started to learn about Bluetooth Low Energy (BLE) Beacons. It is still useful for daily life by automating repetitive tasks. 



# study.beacon.ios

#### Target version
iOS 9.0 is currently set but we can change if needed.

#### XCode structure
In the XCode I used group to organize files but I prefer to saving swfit files into Classes folder and storyboard into Base.lproj.

#### Code convention
There is sample swift file, CodeViewController.swift in MyBeacon/Code Convention
Please feel free to update this file or let me know if you prefer to following different rules or convention.

#### Bundle Identifier
In case that we want to submit this app to Apple Store, I used com.alexcjlee.MyBeacon because I already have an Apple Developer Program account and use com.alexcjlee as bundle Id. We can change the Bundle ID later if needed

#### XCode
I'm not sure what version of XCode you're using. I think we need to use the same version of XCode.

#### CocoaPods
I added pods in the git repository in case that pods are no longer available for some reason later.
Also want to specifiy pod version in the Podfile so that pod is not updating accidently.

